// interface include
`include "datapath_cache_if.vh"
`include "pipeline_fetch_decode_if.vh"
`include "pipeline_decode_execute_if.vh"
`include "pipeline_execute_memory_if.vh"
`include "pipeline_memory_writeback_if.vh"

// memory types
`include "cpu_types_pkg.vh"
`include "hazard_unit_if.vh"

module hazard_unit (
  hazard_unit_if.hu huif,

  //datapath_cache_if dpif,

  pipeline_fetch_decode_if fdif,
  pipeline_decode_execute_if deif,
  pipeline_execute_memory_if emif,
  pipeline_memory_writeback_if mwif
);

  // internal signals representing the need to do something with the pipeline
  logic waiting_for_instruction;
  logic waiting_for_data;
  logic use_after_load_hzd;
  logic jump_or_branch;

  // signals for decomposing complicated dependencies
  logic valid_lw_in_ex;
  logic lw_affects_rs_and_cares;
  logic lw_affects_rt_and_cares;

  // detect when each situation is happening
  assign waiting_for_instruction = ~huif.dpif_ihit;
  assign waiting_for_data        = ~huif.dpif_dhit &
    (huif.dpif_dmemREN | huif.dpif_dmemWEN);

  assign valid_lw_in_ex          = deif.memread_o & (emif.rd_i != '0);
  assign lw_affects_rs_and_cares = (emif.rd_i == deif.rs_i) & deif.care_about_rs_i;
  assign lw_affects_rt_and_cares = (emif.rd_i == deif.rt_i) & deif.care_about_rt_i;
  assign use_after_load_hzd      = valid_lw_in_ex &
                                   (lw_affects_rs_and_cares | lw_affects_rt_and_cares);
  assign jump_or_branch          = huif.pcsrc;

  // control pcpause and pipeline latches' synchronous and asynchronous resets accordingly
  assign huif.pcpause    = (waiting_for_instruction | waiting_for_data | use_after_load_hzd) &
                            ~jump_or_branch;

  assign huif.fdif_pause = waiting_for_data | use_after_load_hzd;
  assign huif.fdif_nop   = (waiting_for_instruction | jump_or_branch) & ~huif.fdif_pause;

  assign huif.deif_pause = waiting_for_data | deif.halt_o;
  assign huif.deif_nop   = jump_or_branch | use_after_load_hzd;

  assign huif.emif_pause = waiting_for_data | emif.halt_o;
  assign huif.emif_nop   = jump_or_branch;

  assign huif.mwif_pause = mwif.halt_o;
  assign huif.mwif_nop   = waiting_for_data;
endmodule
