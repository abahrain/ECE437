`ifndef PIPELINE_EXECUTE_MEMORY_IF_VH
`define PIPELINE_EXECUTE_MEMORY_IF_VH
`include "cpu_types_pkg.vh"

interface pipeline_execute_memory_if;

  import cpu_types_pkg::*;

  logic pcpause;
  logic nopmode;
  logic halt_i;

  logic regwrite_i;
  logic memtoreg_i;
  logic memwrite_i;
  logic jump_i;
  logic branch_i;
  logic bne_i;
  logic jr_i;
  logic memread_i;
  word_t jumpaddr_i;
  word_t branchaddr_i;
  word_t rdat1_i;
  logic zero_i;
  word_t aluoutput_i;
  word_t rdat2_i;
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
  word_t jumpaddr_o;
  word_t branchaddr_o;
  word_t rdat1_o;
  logic zero_o;
  word_t aluoutput_o;
  word_t rdat2_o;
  regbits_t rd_o;

  modport em (
    input  pcpause,
           nopmode,
           regwrite_i,
           halt_i,
           memtoreg_i,
           jump_i,
           branch_i,
           bne_i,
           jr_i,
           memread_i,
           memwrite_i,
           jumpaddr_i,
           branchaddr_i,
           rdat1_i,
           zero_i,
           aluoutput_i,
           rdat2_i,
           rd_i,

    output halt_o,
           regwrite_o,
           memtoreg_o,
           memwrite_o,
           jump_o,
           branch_o,
           bne_o,
           jr_o,
           memread_o,
           jumpaddr_o,
           branchaddr_o,
           rdat1_o,
           zero_o,
           aluoutput_o,
           rdat2_o,
           rd_o
  );
endinterface
`endif
