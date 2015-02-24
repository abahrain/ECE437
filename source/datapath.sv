/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
//`include "datapath_cache_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;
  import forwarding_unit_pkg::*;

  // pc init
  parameter PC_INIT = 0;

  // interfaces
  register_file_if rfif ();
  control_unit_if cuif ();
  hazard_unit_if huif ();
  alu_if aluif ();
  pc_if pcif ();
  forwarding_unit_if fuif ();

  pipeline_fetch_decode_if fdif ();
  pipeline_decode_execute_if deif ();
  pipeline_execute_memory_if emif ();
  pipeline_memory_writeback_if mwif ();

  // modules
  hazard_unit hazard(huif, fdif, deif, emif, mwif);
  register_file register(CLK, nRST, rfif);
  control_unit control(cuif);
  alu alu(aluif);
  pc pc(CLK, nRST, pcif);
  pipeline_fetch_decode pfd(CLK, nRST, fdif);
  pipeline_decode_execute pde(CLK, nRST, deif);
  pipeline_execute_memory pem(CLK, nRST, emif);
  pipeline_memory_writeback pmw(CLK, nRST, mwif);
  forwarding_unit fu (fuif, deif, emif, mwif);

  // Hazard unit dpif inputs
  assign huif.dpif_ihit = dpif.ihit;
  assign huif.dpif_dhit = dpif.dhit;
  assign huif.dpif_dmemREN = dpif.dmemREN;
  assign huif.dpif_dmemWEN = dpif.dmemWEN;

  /* FETCH BLOCK */

  word_t pcplus4;
  word_t pcnext_special;
  logic pcsrc;

  assign pcplus4 = pcif.address + 4;
  assign huif.pcsrc = pcsrc;

  //pc
  assign pcif.next_address = pcsrc ? (pcnext_special) : (pcplus4);
  assign pcif.pcpause = huif.pcpause;

  assign dpif.imemREN  = ~dpif.halt;
  assign dpif.imemaddr = pcif.address;

  //fdif
  assign fdif.nopmode = huif.fdif_nop;
  assign fdif.pcpause = huif.fdif_pause;

  assign fdif.instruction_i = dpif.imemload;
  assign fdif.addr_top_four_i = pcif.address[31:28];
  assign fdif.pcplus4_i = pcplus4;

  // intermediate vars
  r_t rtype;
  i_t itype;
  j_t jtype;

  // set up instruction version vars
  assign rtype = r_t'(fdif.instruction_o);
  assign itype = i_t'(fdif.instruction_o);
  assign jtype = j_t'(fdif.instruction_o);
  /* FETCH BLOCK */

  // declare intermediate vars
  word_t extended;
  word_t swizzle_output;

  logic branchcontrol;

  /* DECODE BLOCK */
  // control unit
  assign cuif.instruction = fdif.instruction_o;

  //rfif
  assign rfif.WEN = mwif.regwrite_o;
  assign rfif.rsel1 = rtype.rs;
  assign rfif.rsel2 = rtype.rt;
  assign rfif.wsel = mwif.rd_o;
  assign rfif.wdat = (mwif.memtoreg_o) ? (mwif.dmemload_o) : (mwif.aluoutput_o);

  // determine intermediate vars
  assign extended = cuif.extendtype ? {{16{itype.imm[15]}}, itype.imm} : {16'b0, itype.imm};
  assign swizzle_output = cuif.lui ? {extended[15:0], extended[31:16]} : extended;

  //deif
  assign deif.nopmode = huif.deif_nop;
  assign deif.pcpause = huif.deif_pause;

  assign deif.regwrite_i = cuif.regwrite;
  assign deif.halt_i = cuif.halt;
  assign deif.memtoreg_i = cuif.memtoreg;
  assign deif.jump_i = cuif.jump;
  assign deif.branch_i = cuif.branch;
  assign deif.bne_i = cuif.bne;
  assign deif.jr_i = cuif.jr;
  assign deif.memread_i = cuif.memread;
  assign deif.memwrite_i = cuif.memwrite;
  assign deif.alusrc_i = cuif.alusrc;
  assign deif.aluop_i = cuif.aluop;
  assign deif.regdest_i = cuif.regdest;
  assign deif.jal_i = cuif.jal;
  assign deif.shift_i = cuif.shift;
  assign deif.care_about_rs_i = cuif.care_about_rs;
  assign deif.care_about_rt_i = cuif.care_about_rt;

  assign deif.instruction_top_25_i = fdif.instruction_o[25:0];
  assign deif.addr_top_four_i = fdif.addr_top_four_o;
  assign deif.pcplus4_i = fdif.pcplus4_o;
  assign deif.rdat1_i = rfif.rdat1;
  assign deif.rdat2_i = rfif.rdat2;
  assign deif.swizzler_output_i = swizzle_output;
  assign deif.rs_i = fdif.instruction_o[25:21];
  assign deif.rt_i = fdif.instruction_o[20:16];
  assign deif.rd_i = fdif.instruction_o[15:11];
  /* DECODE BLOCK */

  /* EXECUTE BLOCK */

  word_t rdat1_or_forwarded;
  word_t rdat2_or_forwarded;

  always_comb begin
    casez (fuif.forward_a)
      FORWARD_R:  rdat1_or_forwarded = deif.rdat1_o;
      FORWARD_EM: rdat1_or_forwarded = emif.aluoutput_o;
      FORWARD_MW: rdat1_or_forwarded = rfif.wdat;
      default:    rdat1_or_forwarded = 32'hdeadbeef;
    endcase
    casez (fuif.forward_b)
      FORWARD_R:  rdat2_or_forwarded = deif.rdat2_o;
      FORWARD_EM: rdat2_or_forwarded = emif.aluoutput_o;
      FORWARD_MW: rdat2_or_forwarded = rfif.wdat;
      default:    rdat2_or_forwarded = 32'hdeadbeef;
    endcase
  end

  //alu
  assign aluif.a = rdat1_or_forwarded;
  assign aluif.b = (deif.shift_o) ? (
      {27'b0, deif.instruction_top_25_o[10:6]}) :
      ((deif.alusrc_o) ? (deif.swizzler_output_o) : (rdat2_or_forwarded));
  assign aluif.opcode = deif.aluop_o;

  //emif
  assign emif.nopmode = huif.emif_nop;
  assign emif.pcpause = huif.emif_pause;

  assign emif.regwrite_i = deif.regwrite_o;
  assign emif.halt_i = deif.halt_o;
  assign emif.memtoreg_i = deif.memtoreg_o;
  assign emif.memwrite_i = deif.memwrite_o;
  assign emif.jump_i = deif.jump_o;
  assign emif.branch_i = deif.branch_o;
  assign emif.bne_i = deif.bne_o;
  assign emif.jr_i = deif.jr_o;
  assign emif.memread_i = deif.memread_o;

  assign emif.jumpaddr_i = {deif.addr_top_four_o,
                            deif.instruction_top_25_o,
                            2'b00};
  assign emif.branchaddr_i = (
      $signed(deif.swizzler_output_o << 2)) + deif.pcplus4_o;
  assign emif.rdat1_i = rdat1_or_forwarded;
  assign emif.rdat2_i = rdat2_or_forwarded;
  assign emif.zero_i = aluif.zero;
  assign emif.aluoutput_i = deif.jal_o ? deif.pcplus4_o : aluif.out;

  regbits_t reg_31;
  assign reg_31 = 5'b11111;
  assign emif.rd_i = (deif.jal_o) ? (reg_31) :
                       ((deif.regdest_o) ?
                          (deif.rd_o) :
                          (deif.rt_o));
  /* EXECUTE BLOCK */

  /* MEMORY BLOCK */

  word_t pca;
  assign pcsrc = emif.jump_o | (emif.branch_o & branchcontrol);
  assign pca = (emif.jr_o) ? (emif.rdat1_o) : (emif.jumpaddr_o);
  assign branchcontrol = (emif.branch_o & (emif.bne_o ^ emif.zero_o));
  assign pcnext_special = branchcontrol ? emif.branchaddr_o : pca;

  //dpif
  assign dpif.dmemREN   = emif.memread_o;
  assign dpif.dmemWEN   = emif.memwrite_o & ~dpif.halt;
  assign dpif.dmemstore = emif.rdat2_o;
  assign dpif.dmemaddr  = emif.aluoutput_o;

  //mwif
  assign mwif.nopmode = huif.mwif_nop;
  assign mwif.pcpause = huif.mwif_pause;

  assign mwif.regwrite_i = emif.regwrite_o;
  assign mwif.halt_i = emif.halt_o;
  assign mwif.memtoreg_i = emif.memtoreg_o;
  assign mwif.dmemload_i = dpif.dmemload;
  assign mwif.aluoutput_i = emif.aluoutput_o;
  assign mwif.rd_i = emif.rd_o;
  /* MEMORY BLOCK */

  /* WRITEBACK BLOCK */
  // halt signal
  //assign dpif.halt = mwif.halt_o;
  /* WRITEBACK BLOCK */

  logic halt;
  assign dpif.halt = halt;

  always_ff @(posedge CLK, negedge nRST) begin
    if (~nRST) begin
      halt <= 1'b0;
    end else if (mwif.halt_o == 1'b1) begin
      halt <= 1'b1;
    end
  end
endmodule
