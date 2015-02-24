`include "pipeline_execute_memory_if.vh"
`include "cpu_types_pkg.vh"

module pipeline_execute_memory
(
  input logic CLK, nRST,
  pipeline_execute_memory_if.em emif
);

  import cpu_types_pkg::*;

  logic regwrite_l;
  logic halt_l;
  logic memtoreg_l;
  logic jump_l;
  logic branch_l;
  logic bne_l;
  logic jr_l;
  logic memread_l;
  logic memwrite_l;
  word_t jumpaddr_l;
  word_t branchaddr_l;
  word_t rdat1_l;
  logic zero_l;
  word_t aluoutput_l;
  word_t rdat2_l;
  regbits_t rd_l;

  always_ff @(posedge CLK or negedge nRST) begin
    if (!nRST) begin
      regwrite_l <= '0;
      halt_l <= '0;
      memtoreg_l <= '0;
      jump_l <= '0;
      branch_l <= '0;
      bne_l <= '0;
      jr_l <= '0;
      memread_l <= '0;
      memwrite_l <= '0;
      jumpaddr_l <= '0;
      branchaddr_l <= '0;
      rdat1_l <= '0;
      zero_l <= '0;
      aluoutput_l <= '0;
      rdat2_l <= '0;
      rd_l <= '0;
    end else if (emif.nopmode) begin
      regwrite_l <= '0;
      halt_l <= '0;
      memtoreg_l <= '0;
      jump_l <= '0;
      branch_l <= '0;
      bne_l <= '0;
      jr_l <= '0;
      memread_l <= '0;
      memwrite_l <= '0;
      jumpaddr_l <= '0;
      branchaddr_l <= '0;
      rdat1_l <= '0;
      zero_l <= '0;
      aluoutput_l <= '0;
      rdat2_l <= '0;
      rd_l <= '0;
    end else if (!emif.pcpause) begin
      regwrite_l <= emif.regwrite_i;
      halt_l <= emif.halt_i;
      memtoreg_l <= emif.memtoreg_i;
      jump_l <= emif.jump_i;
      branch_l <= emif.branch_i;
      bne_l <= emif.bne_i;
      jr_l <= emif.jr_i;
      memread_l <= emif.memread_i;
      memwrite_l <= emif.memwrite_i;
      jumpaddr_l <= emif.jumpaddr_i;
      branchaddr_l <= emif.branchaddr_i;
      rdat1_l <= emif.rdat1_i;
      zero_l <= emif.zero_i;
      aluoutput_l <= emif.aluoutput_i;
      rdat2_l <= emif.rdat2_i;
      rd_l <= emif.rd_i;
    end
  end

  assign emif.regwrite_o = regwrite_l;
  assign emif.halt_o = halt_l;
  assign emif.memtoreg_o = memtoreg_l;
  assign emif.jump_o = jump_l;
  assign emif.branch_o = branch_l;
  assign emif.bne_o = bne_l;
  assign emif.jr_o = jr_l;
  assign emif.memread_o = memread_l;
  assign emif.memwrite_o = memwrite_l;
  assign emif.jumpaddr_o = jumpaddr_l;
  assign emif.branchaddr_o = branchaddr_l;
  assign emif.rdat1_o = rdat1_l;
  assign emif.zero_o = zero_l;
  assign emif.aluoutput_o = aluoutput_l;
  assign emif.rdat2_o = rdat2_l;
  assign emif.rd_o = rd_l;
endmodule
