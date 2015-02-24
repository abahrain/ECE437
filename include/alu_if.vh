`ifndef ALU_IF_VH
`define ALU_IF_VH
`include "cpu_types_pkg.vh"

interface alu_if;
  // import types
  import cpu_types_pkg::*;

  aluop_t opcode;
  word_t a, b, out;
  logic negative, zero, overflow;

  modport alu (
    input opcode, a, b,
    output out, negative, zero, overflow
  );

  modport tb (
    input out, negative, zero, overflow,
    output opcode, a, b
  );
endinterface
`endif
