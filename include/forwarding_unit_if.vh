`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH
`include "cpu_types_pkg.vh"

package forwarding_unit_pkg;
  typedef enum logic [1:0] {
    FORWARD_R = 2'b00,
    FORWARD_EM = 2'b01,
    FORWARD_MW = 2'b10
  } forward_sel_t;
endpackage

interface forwarding_unit_if;
  // import types
  import cpu_types_pkg::*;
  import forwarding_unit_pkg::*;

  forward_sel_t forward_a;
  forward_sel_t forward_b;

  modport fuif (
    output forward_a, forward_b
  );
endinterface
`endif
