`include "alu_if.vh"
`include "cpu_types_pkg.vh"

module alu
(
  alu_if.alu aluif
);

  import cpu_types_pkg::*;

  always_comb begin
    aluif.overflow = 0;
    casez (aluif.opcode)
      ALU_SLL: aluif.out = aluif.a << aluif.b;
      ALU_SRL: aluif.out = aluif.a >> aluif.b;
      ALU_ADD: begin
        aluif.out = aluif.a + aluif.b;
        aluif.overflow = (aluif.a[31] == aluif.b[31]) ? ((aluif.out[31] != aluif.a[31]) ? 1 : 0) : 0;
      end
      ALU_SUB: begin
        aluif.out = aluif.a - aluif.b;
        aluif.overflow = (aluif.a[31] != aluif.b[31]) ? ((aluif.out[31] != aluif.a[31]) ? 1 : 0) : 0;
      end
      ALU_AND: aluif.out = aluif.a & aluif.b;
      ALU_OR:  aluif.out = aluif.a | aluif.b;
      ALU_XOR: aluif.out = aluif.a ^ aluif.b;
      ALU_NOR: aluif.out = ~(aluif.a | aluif.b);
      ALU_SLT: aluif.out =$signed(aluif.a) < $signed(aluif.b);
      ALU_SLTU:aluif.out = $unsigned(aluif.a) < $unsigned(aluif.b);
      default: aluif.out = '0;
    endcase
  end

  always_comb begin
    aluif.zero = '0;
    aluif.negative = '0;

    if (aluif.out == '0) aluif.zero = 1;
    if (aluif.out[31]) aluif.negative = 1;
  end

endmodule
