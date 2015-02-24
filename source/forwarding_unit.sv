// interface include
`include "pipeline_decode_execute_if.vh"
`include "pipeline_execute_memory_if.vh"
`include "pipeline_memory_writeback_if.vh"
`include "forwarding_unit_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module forwarding_unit (
  forwarding_unit_if.fuif fuif,
  pipeline_decode_execute_if deif,
  pipeline_execute_memory_if emif,
  pipeline_memory_writeback_if mwif
);

  //import forwarding_unit_pkg::*;
  import cpu_types_pkg::*;

  logic em_match_a;
  logic em_match_b;
  logic mw_match_a;
  logic mw_match_b;

  regbits_t zero_reg;
  assign zero_reg = 5'b00000;

  assign em_match_a = (emif.regwrite_o &
                      (emif.rd_o != zero_reg) &
                      (emif.rd_o == deif.rs_o));
  assign em_match_b = (emif.regwrite_o &
                      (emif.rd_o != zero_reg) &
                      (emif.rd_o == deif.rt_o));
  assign mw_match_a = (mwif.regwrite_o &
                      (mwif.rd_o != zero_reg) &
                      (mwif.rd_o == deif.rs_o));
  assign mw_match_b = (mwif.regwrite_o &
                      (mwif.rd_o != zero_reg) &
                      (mwif.rd_o == deif.rt_o));

  assign fuif.forward_a =  (em_match_a) ? (FORWARD_EM) :
                          ((mw_match_a) ? (FORWARD_MW) : (FORWARD_R));
  assign fuif.forward_b =  (em_match_b) ? (FORWARD_EM) :
                          ((mw_match_b) ? (FORWARD_MW) : (FORWARD_R));
endmodule
