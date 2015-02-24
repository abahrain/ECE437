`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

module control_unit
(
  control_unit_if.cu cuif
);

  import cpu_types_pkg::*;

  opcode_t opcode;
  assign opcode = opcode_t'(cuif.instruction[31:26]);
  funct_t func;
  assign func = funct_t'(cuif.instruction[5:0]);

  always_comb begin
    cuif.regdest = '0;
    cuif.halt = '0;
    cuif.memread = '0;
    cuif.memwrite = '0;
    cuif.jal = '0;
    cuif.regwrite = '0;
    cuif.lui = '0;
    cuif.alusrc = '0;
    cuif.bne = '0;
    cuif.memtoreg = '0;
    cuif.branch = '0;
    cuif.jump = '0;
    cuif.jr = '0;
    cuif.extendtype = '0;
    cuif.shift = '0;
    if (opcode == RTYPE) cuif.regdest = '1;
    if (opcode == HALT) cuif.halt = '1;
    if (opcode == LW) cuif.memread = '1;
    if (opcode == SW) cuif.memwrite = '1;
    if (opcode == JAL) cuif.jal = '1;
    if (~((opcode == RTYPE & func == JR) | (opcode == BEQ) | (opcode == BNE) |
      (opcode == SW) | (opcode == J) | (opcode == HALT) | (cuif.instruction == '0))) cuif.regwrite = '1;
    if (opcode == LUI) cuif.lui = '1;
    if ((opcode == ADDIU) | (opcode == ANDI) | (opcode == LUI) |
      (opcode == LW) | (opcode == ORI) | (opcode == SLTI) | (opcode == SLTIU) |
      (opcode == SW) | (opcode == LL) | (opcode == SC) | (opcode == XORI)) cuif.alusrc = '1;
    if (opcode == BNE) cuif.bne = '1;
    if (opcode == LW) cuif.memtoreg = '1;
    if ((opcode == BEQ) | (opcode == BNE)) cuif.branch = '1;
    if ((opcode == J) | (opcode == JAL) | ((opcode == RTYPE) & (func == JR))) cuif.jump = '1;
    if ((opcode == RTYPE) & (func == JR)) cuif.jr = '1;
    if (~((opcode == ANDI) | (opcode == LUI) | (opcode == ORI) |
      (opcode == XORI))) cuif.extendtype = '1;
    if ((opcode == RTYPE) & ((func == SLL) | (func == SRL))) cuif.shift = '1;
  end

  // alu op development
  aluop_t opfromfunct;

  always_comb begin

    casez (opcode)

      RTYPE: begin
        cuif.care_about_rs = 1;
        casez (func)
          JR, SRL, SLL: begin
            cuif.care_about_rt = 0;
          end
          default: begin
            cuif.care_about_rt = 1;
          end
        endcase
      end /* end RTYPE */

      LUI: begin
        cuif.care_about_rt = 0;
        cuif.care_about_rs = 0;
      end /* end LUI */

      ADDI, ADDIU, SLTI, SLTIU, ANDI, ORI, XORI, LW, LBU, LHU, SB, SH, LL, HALT: begin
        cuif.care_about_rt = 0;
        cuif.care_about_rs = 1;
      end /* end most itype */

      BEQ, BNE, SW, SC: begin
        cuif.care_about_rt = 1;
        cuif.care_about_rs = 1;
      end

      default: begin
        cuif.care_about_rt = 0;
        cuif.care_about_rs = 0;
      end

    endcase

    casez (func)
      SLL:  opfromfunct = ALU_SLL;
      SRL:  opfromfunct = ALU_SRL;
      ADD, ADDU: opfromfunct = ALU_ADD;
      SUB, SUBU: opfromfunct = ALU_SUB;
      AND:  opfromfunct = ALU_AND;
      OR:   opfromfunct = ALU_OR;
      XOR:  opfromfunct = ALU_XOR;
      NOR:  opfromfunct = ALU_NOR;
      SLT:  opfromfunct = ALU_SLT;
      SLTU: opfromfunct = ALU_SLTU;
      default: opfromfunct = aluop_t'('1);
    endcase

    casez (opcode)
      RTYPE: cuif.aluop = opfromfunct;
      ADDIU, LW, SW, LL, SC: cuif.aluop = ALU_ADD;
      ANDI: cuif.aluop = ALU_AND;
      ORI, LUI: cuif.aluop = ALU_OR;
      BEQ, BNE: cuif.aluop = ALU_SUB;
      SLTI: cuif.aluop = ALU_SLT;
      SLTIU: cuif.aluop = ALU_SLTU;
      XORI: cuif.aluop = ALU_XOR;
      default: cuif.aluop = aluop_t'('1);
    endcase
  end

endmodule
