`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic instruction_halt, pipeline_end_halt, memread, memwrite, regwrite_control;
  word_t imemaddr, dmemstore, dmemaddr;

  logic pcpause, regwrite_register, system_halt;
  logic fdif_nop, fdif_pause;
  logic deif_nop, deif_pause;
  logic emif_nop, emif_pause;
  logic mwif_nop, mwif_pause;
  word_t dmemload;

  // pc pause really pauses all pipeline regs
  modport ru (
    input instruction_halt, pipeline_end_halt, memread, memwrite, imemaddr, dmemstore, dmemaddr,
    output pcpause, system_halt, dmemload,
    fdif_nop, fdif_pause,
    deif_nop, deif_pause,
    emif_nop, emif_pause,
    mwif_nop, mwif_pause
  );
endinterface
`endif //REQUEST_UNIT_IF_VH
