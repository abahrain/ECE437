`include "pipeline_decode_execute_if.vh"
`include "cpu_types_pkg.vh"

module pipeline_decode_execute
(
  input logic CLK, nRST,
  pipeline_decode_execute_if.de deif
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
  logic alusrc_l;
  aluop_t aluop_l;
  logic regdest_l;
  logic jal_l;
  logic shift_l;
  logic care_about_rs_l;
  logic care_about_rt_l;
  logic [25:0] instruction_top_25_l;
  logic [3:0] addr_top_four_l;
  word_t pcplus4_l;
  word_t rdat1_l;
  word_t rdat2_l;
  word_t swizzler_output_l;
  regbits_t rs_l;
  regbits_t rt_l;
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
      alusrc_l <= '0;
      aluop_l <= aluop_t'('0);
      regdest_l <= '0;
      jal_l <= '0;
      shift_l <= '0;
      care_about_rs_l <= '0;
      care_about_rt_l <= '0;
      instruction_top_25_l <= '0;
      addr_top_four_l <= '0;
      pcplus4_l <= '0;
      rdat1_l <= '0;
      rdat2_l <= '0;
      swizzler_output_l <= '0;
      rs_l <= '0;
      rt_l <= '0;
      rd_l <= '0;
    end else if (deif.nopmode) begin
      regwrite_l <= '0;
      halt_l <= '0;
      memtoreg_l <= '0;
      jump_l <= '0;
      branch_l <= '0;
      bne_l <= '0;
      jr_l <= '0;
      memread_l <= '0;
      memwrite_l <= '0;
      alusrc_l <= '0;
      aluop_l <= aluop_t'('0);
      regdest_l <= '0;
      jal_l <= '0;
      shift_l <= '0;
      care_about_rs_l <= '0;
      care_about_rt_l <= '0;
      instruction_top_25_l <= '0;
      addr_top_four_l <= '0;
      pcplus4_l <= '0;
      rdat1_l <= '0;
      rdat2_l <= '0;
      swizzler_output_l <= '0;
      rs_l <= '0;
      rt_l <= '0;
      rd_l <= '0;
    end else if (!deif.pcpause) begin
      regwrite_l <= deif.regwrite_i;
      halt_l <= deif.halt_i;
      memtoreg_l <= deif.memtoreg_i;
      jump_l <= deif.jump_i;
      branch_l <= deif.branch_i;
      bne_l <= deif.bne_i;
      jr_l <= deif.jr_i;
      memread_l <= deif.memread_i;
      memwrite_l <= deif.memwrite_i;
      alusrc_l <= deif.alusrc_i;
      aluop_l <= deif.aluop_i;
      regdest_l <= deif.regdest_i;
      jal_l <= deif.jal_i;
      shift_l <= deif.shift_i;
      care_about_rs_l <= deif.care_about_rs_i;
      care_about_rt_l <= deif.care_about_rt_i;
      instruction_top_25_l <= deif.instruction_top_25_i;
      addr_top_four_l <= deif.addr_top_four_i;
      pcplus4_l <= deif.pcplus4_i;
      rdat1_l <= deif.rdat1_i;
      rdat2_l <= deif.rdat2_i;
      swizzler_output_l <= deif.swizzler_output_i;
      rs_l <= deif.rs_i;
      rt_l <= deif.rt_i;
      rd_l <= deif.rd_i;
    end
  end

  assign deif.regwrite_o = regwrite_l;
  assign deif.halt_o = halt_l;
  assign deif.memtoreg_o = memtoreg_l;
  assign deif.jump_o = jump_l;
  assign deif.branch_o = branch_l;
  assign deif.bne_o = bne_l;
  assign deif.jr_o = jr_l;
  assign deif.memread_o = memread_l;
  assign deif.memwrite_o = memwrite_l;
  assign deif.alusrc_o = alusrc_l;
  assign deif.aluop_o = aluop_l;
  assign deif.regdest_o = regdest_l;
  assign deif.jal_o = jal_l;
  assign deif.shift_o = shift_l;
  assign deif.care_about_rs_o = care_about_rs_l;
  assign deif.care_about_rt_o = care_about_rt_l;
  assign deif.instruction_top_25_o = instruction_top_25_l;
  assign deif.addr_top_four_o = addr_top_four_l;
  assign deif.pcplus4_o = pcplus4_l;
  assign deif.rdat1_o = rdat1_l;
  assign deif.rdat2_o = rdat2_l;
  assign deif.swizzler_output_o = swizzler_output_l;
  assign deif.rs_o = rs_l;
  assign deif.rt_o = rt_l;
  assign deif.rd_o = rd_l;

endmodule
