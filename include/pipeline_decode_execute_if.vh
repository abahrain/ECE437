`ifndef PIPELINE_DECODE_EXECUTE_IF_VH
`define PIPELINE_DECODE_EXECUTE_IF_VH
`include "cpu_types_pkg.vh"

interface pipeline_decode_execute_if;

  import cpu_types_pkg::*;

  logic halt_i;
  logic pcpause;
  logic nopmode;

  logic regwrite_i;
  logic memtoreg_i;
  logic jump_i;
  logic branch_i;
  logic bne_i;
  logic jr_i;
  logic memread_i;
  logic memwrite_i;
  logic alusrc_i;
  aluop_t aluop_i;
  logic regdest_i;
  logic jal_i;
  logic shift_i;
  logic care_about_rs_i;
  logic care_about_rt_i;
  logic [25:0] instruction_top_25_i;
  logic [3:0] addr_top_four_i;
  word_t pcplus4_i;
  word_t rdat1_i;
  word_t rdat2_i;
  word_t swizzler_output_i;
  regbits_t rs_i;
  regbits_t rt_i;
  regbits_t rd_i;

  logic regwrite_o;
  logic halt_o;
  logic memtoreg_o;
  logic jump_o;
  logic branch_o;
  logic bne_o;
  logic jr_o;
  logic memread_o;
  logic memwrite_o;
  logic alusrc_o;
  aluop_t aluop_o;
  logic regdest_o;
  logic jal_o;
  logic shift_o;
  logic care_about_rs_o;
  logic care_about_rt_o;
  logic [25:0] instruction_top_25_o;
  logic [3:0] addr_top_four_o;
  word_t pcplus4_o;
  word_t rdat1_o;
  word_t rdat2_o;
  word_t swizzler_output_o;
  regbits_t rs_o;
  regbits_t rt_o;
  regbits_t rd_o;

  modport de (
    input  pcpause,
           nopmode,
           halt_i,
           regwrite_i,
           memtoreg_i,
           jump_i,
           branch_i,
           bne_i,
           jr_i,
           memread_i,
           memwrite_i,
           alusrc_i,
           aluop_i,
           regdest_i,
           jal_i,
           shift_i,
           care_about_rs_i,
           care_about_rt_i,
           instruction_top_25_i,
           addr_top_four_i,
           pcplus4_i,
           rdat1_i,
           rdat2_i,
           swizzler_output_i,
           rs_i,
           rt_i,
           rd_i,

    output memtoreg_o,
           halt_o,
           regwrite_o,
           jump_o,
           branch_o,
           bne_o,
           jr_o,
           memread_o,
           memwrite_o,
           alusrc_o,
           aluop_o,
           regdest_o,
           jal_o,
           shift_o,
           care_about_rs_o,
           care_about_rt_o,
           instruction_top_25_o,
           addr_top_four_o,
           pcplus4_o,
           rdat1_o,
           rdat2_o,
           swizzler_output_o,
           rs_o,
           rt_o,
           rd_o
  );
endinterface
`endif
