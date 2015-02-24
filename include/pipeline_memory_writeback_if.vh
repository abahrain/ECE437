`ifndef PIPELINE_MEMORY_WRITEBACK_IF_VH
`define PIPELINE_MEMORY_WRITEBACK_IF_VH
`include "cpu_types_pkg.vh"

interface pipeline_memory_writeback_if;

  import cpu_types_pkg::*;

  logic pcpause;
  logic halt_i;
  logic nopmode;

  logic regwrite_i;
  logic memtoreg_i;
  word_t dmemload_i;
  word_t aluoutput_i;
  regbits_t rd_i;

  logic regwrite_o;
  logic halt_o;
  logic memtoreg_o;
  word_t dmemload_o;
  word_t aluoutput_o;
  regbits_t rd_o;


  modport mw (
    input  pcpause,
           nopmode,
           halt_i,
           memtoreg_i,
           regwrite_i,
           dmemload_i,
           aluoutput_i,
           rd_i,
    output halt_o,
           memtoreg_o,
           regwrite_o,
           dmemload_o,
           aluoutput_o,
           rd_o
  );
endinterface
`endif
