/*
  Eric Villasenor
  evillase@gmail.com

  ALU test bench
*/

// mapped needs this
`include "alu_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module alu_tb;

  parameter PERIOD = 10;
  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // interface
  alu_if aluif ();
  // test program
  test PROG (aluif);
  // DUT
`ifndef MAPPED
  alu DUT(aluif);
`else
  alu DUT(
    .\aluif.opcode (aluif.opcode),
    .\aluif.a (aluif.a),
    .\aluif.b (aluif.b),
    .\aluif.out (aluif.out),
    .\aluif.negative (aluif.negative),
    .\aluif.zero (aluif.zero),
    .\aluif.overflow (aluif.overflow)
  );
`endif

endmodule

program test (
  alu_if.tb tbif
);
  parameter PERIOD = 10;
  int i = 0;
  import cpu_types_pkg::*;
  initial begin
    $display("Starting");

    tbif.opcode = ALU_SLL;
    #(PERIOD);
    for (i = 1; i < 128; i = i << 1) begin
      tbif.a = i;
      #(PERIOD);
      if (tbif.out != i << 1) begin
        $display("SLL failed");
      end
    end

    tbif.opcode = ALU_SRL;
    #(PERIOD);
    for (i = 128; i > 16; i = i >> 1) begin
      tbif.a = i;
      #(PERIOD);
      if (tbif.out != i >> 1) begin
        $display("SRL failed");
      end
    end

    tbif.opcode = ALU_ADD;
    #(PERIOD);
    tbif.a = 'd10;
    tbif.b = 'd45;
    #(PERIOD)
    if (tbif.out != tbif.a + tbif.b) begin
      $display("ADD failed");
    end
    #(PERIOD);
    tbif.a = '0;
    tbif.b = '0;
    #(PERIOD)
    if (tbif.zero != 1'b1) begin
      $display("zero flag failed");
    end
    #(PERIOD);
    tbif.a = 32'b01111111111111111111111111111111;
    tbif.b = 32'b01111111111111111111111111111111;
    #(PERIOD)
    if (tbif.overflow != 1) begin
      $display("overflow flag failed");
    end

    tbif.opcode = ALU_SUB;
    #(PERIOD);
    tbif.a = 'd50;
    tbif.b = 'd45;
    #(PERIOD)
    if (tbif.out != tbif.a - tbif.b) begin
      $display("SUB failed");
    end
    #(PERIOD);
    tbif.a = 32'b10000000000000000000000000000000;
    tbif.b = 'd45;
    #(PERIOD)
    if (tbif.overflow != 1'b1) begin
      $display("overflow flag failed (SUB)");
    end

    tbif.opcode = ALU_AND;
    #(PERIOD);
    tbif.a = 'b10;
    tbif.b = 'b11;
    #(PERIOD)
    if (tbif.out != tbif.a & tbif.b) begin
      $display("AND failed");
    end

    tbif.opcode = ALU_OR;
    #(PERIOD);
    tbif.a = 'b10;
    tbif.b = 'b11;
    #(PERIOD)
    if (tbif.out != 'b11)  begin
      $display("OR failed");
    end

    tbif.opcode = ALU_XOR;
    #(PERIOD);
    tbif.a = 'b10;
    tbif.b = 'b11;
    #(PERIOD)
    if (tbif.out != 'b01) begin
      $display("XOR failed");
    end

    tbif.opcode = ALU_NOR;
    #(PERIOD);
    tbif.a = 'b10;
    tbif.b = 'b11;
    #(PERIOD)
    if (tbif.out != ~(tbif.a | tbif.b)) begin
      $display("NOR failed");
    end

    tbif.opcode = ALU_SLT;
    #(PERIOD);
    tbif.a = 'd50;
    tbif.b = 'd45;
    #(PERIOD)
    if (tbif.out != 'd0) begin
      $display("SLT failed (1)");
    end
    #(PERIOD);
    tbif.a = 'd40;
    tbif.b = 'd45;
    #(PERIOD)
    if (tbif.out != 'd1) begin
      $display("SLT failed (2)");
    end

    tbif.opcode = ALU_SLTU;
    #(PERIOD);
    tbif.a = '1;
    tbif.b = '0;
    #(PERIOD)
    if (tbif.out != 'd0) begin
      $display("SLTU failed (1)");
    end
    #(PERIOD);
    tbif.a = '0;
    tbif.b = '1;
    #(PERIOD)
    if (tbif.out != 'd1) begin
      $display("SLTU failed (2)");
    end
    $display("Finished");
    $finish;
  end
endprogram
