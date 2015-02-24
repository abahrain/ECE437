/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module memory_control_tb;

  parameter PERIOD = 10;
  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  cache_control_if ccif ();
  cpu_ram_if ramif ();

  // ram
  ram ram(CLK, nRST, ramif);

  // test program
  test PROG (CLK, nRST, ccif, ramif);
  // DUT
  memory_control DUT(CLK, nRST, ccif);

  assign ramif.ramaddr = ccif.ramaddr;
  assign ramif.ramstore = ccif.ramstore;
  assign ramif.ramREN = ccif.ramREN;
  assign ramif.ramWEN = ccif.ramWEN;

  assign ccif.ramstate = ramif.ramstate;
  assign ccif.ramload = ramif.ramload;

endmodule

program test (
  input logic CLK,
  output logic nRST,
  cache_control_if.cc ccif,
  cpu_ram_if ramif
);
  parameter PERIOD = 10;
  int i = 0;
  import cpu_types_pkg::*;

  initial begin
    $display("Starting");
    ccif.iREN[0] = '0;
    ccif.dREN[0] = '0;
    ccif.dWEN[0] = '0;
    ccif.dstore[0] = '0;
    ccif.iaddr[0] = '0;
    ccif.daddr[0] = '0;
    nRST = '1;

    #(PERIOD);
    ccif.iaddr[0] = 32'h00000004;
    ccif.iREN[0] = '1;
    #(1);
    if (ccif.iwait[0] != 1'b1) begin
      $display("not getting iwait");
    end

    i = 0;
    while (ccif.iwait[0] == 1'b1) begin
      i = i + 1;
      #(1);
    end
    @(posedge CLK);
    $display("done waiting for iwait, took %d ns", i);
    ccif.iREN[0] = '1;
    $display("iload: %h", ccif.iload[0]);

    $display("writing to ram");

    ccif.dstore[0] = 32'haddaadda;
    ccif.daddr[0] = 32'h00000FFF;
    ccif.dWEN[0] = 1'b1;
    #(1);
    if (ccif.dwait[0] != 1'b1) begin
      $display("not getting dwait");
    end

    i = 0;
    while (ccif.dwait[0] == 1'b1) begin
      i = i + 1;
      #(1);
    end
    @(posedge CLK);
    $display("done waiting for dwait, took %d ns", i);
    ccif.dWEN[0] = '0;

    ccif.dREN[0] = '1;
    $display("reading data written to ram (addaadda)");
    #(1);
    i = 0;
    while (ccif.dwait[0] == 1'b1) begin
      i = i + 1;
      #(1);
    end
    @(posedge CLK);
    $display("done waiting for dwait, took %d ns", i);
    ccif.dREN[0] = '0;
    $display("read result: %h", ccif.dload[0]);

    $display("Finished");
    $finish;
  end
endprogram


