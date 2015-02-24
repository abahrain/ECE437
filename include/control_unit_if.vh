`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

  word_t instruction;

  logic regdest, halt, memread, memwrite;
  logic jal, regwrite, lui, alusrc;
  logic bne, memtoreg, branch, jump;
  logic jr, extendtype, shift;
  logic care_about_rs;
  logic care_about_rt;
  aluop_t aluop;

  modport cu (
    input instruction,
    output regdest, halt, memread, memwrite,
    jal, regwrite, lui, alusrc, bne, memtoreg,
    branch, jump, jr, extendtype, shift,
    aluop, care_about_rs, care_about_rt
  );
endinterface
`endif //CONTROL_UNIT_IF_VH

/*
fetch -
decode - lui, alusrc, extendtype,
ex - aluop, shift, regdest
memory - memread, memwrite, jal, bne, branch, jump, jr
writeback - halt, jal, regwrite, memtoreg
*/
