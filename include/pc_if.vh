`ifndef PC_IF_VH
`define PC_IF_VH
`include "cpu_types_pkg.vh"

interface pc_if;
  // import types
  import cpu_types_pkg::*;

  word_t next_address, address;
  logic pcpause;

  modport pc (
    input next_address, pcpause,
    output address
  );
endinterface
`endif
