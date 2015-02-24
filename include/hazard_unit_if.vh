//`ifndef HAZARD_UNIT_IF_VH
//`define HAZARD_UNIT_IF_VH

// types
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic pcsrc;
  logic pcpause;
  logic dpif_ihit, dpif_dhit;
  logic dpif_dmemREN, dpif_dmemWEN;

  logic fdif_nop, fdif_pause;
  logic deif_nop, deif_pause;
  logic emif_nop, emif_pause;
  logic mwif_nop, mwif_pause;

  modport hu (
    input pcsrc,
    dpif_ihit, dpif_dhit,
    dpif_dmemREN, dpif_dmemWEN,
    output pcpause,
    fdif_nop, fdif_pause,
    deif_nop, deif_pause,
    emif_nop, emif_pause,
    mwif_nop, mwif_pause
  );
endinterface
//`endif //HAZARD_UNIT_IF_VH
