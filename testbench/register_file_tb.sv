/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG (CLK, nRST, rfif);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test (
  input logic CLK,
  output logic nRST,
  register_file_if.tb tbif
);
  parameter PERIOD = 10;
  int i = 0;
  initial begin
    $display("Starting");
    nRST = 0;
    #(PERIOD);
    nRST = 1;
    #(PERIOD);

    tbif.WEN = 0;
    for (i = 0; i < 32; i++) begin
      tbif.rsel1 = i;
      #(PERIOD);
      if (tbif.rdat1 != '0) begin
        $error("Non-zero after nRST");
      end
    end

    // fill up the reg
    #(PERIOD);
    tbif.WEN = 1;
    for (i = 1; i < 33; i++) begin
      tbif.wsel = i - 1;
      tbif.wdat = i * 2;
      #(PERIOD);
    end
    tbif.WEN = 0;
    #(PERIOD);

    // check filled up reg
    for (i = 1; i < 33; i += 2) begin
      tbif.rsel1 = i - 1;
      tbif.rsel2 = i;
      #(PERIOD);
      if (tbif.rsel1 == 0) begin
        if (tbif.rdat1 != 0) begin
          $display("Special 0 register returned nonzero");
        end
      end else if (tbif.rdat1 != (i * 2)) begin
        $display("Reading data back has yielded a wrong value");
      end
      if (tbif.rdat2 != ((i + 1) * 2)) begin
        $display("Reading data back has yielded a wrong value");
      end
    end

    $display("Finished");
    $finish;
  end
endprogram


