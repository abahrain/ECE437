`ifndef PIPELINE_FETCH_DECODE_IF_VH
`define PIPELINE_FETCH_DECODE_IF_VH
`include "cpu_types_pkg.vh"

interface pipeline_fetch_decode_if;

  import cpu_types_pkg::*;

  logic pcpause;
  logic nopmode;

  logic [3:0] addr_top_four_i;
  word_t pcplus4_i;
  word_t instruction_i;

  logic [3:0] addr_top_four_o;
  word_t pcplus4_o;
  word_t instruction_o;


  modport fd (
    input  pcpause,
           addr_top_four_i,
           pcplus4_i,
           instruction_i,
           nopmode,
    output addr_top_four_o,
           pcplus4_o,
           instruction_o
  );
endinterface
`endif
