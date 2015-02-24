`include "register_file_if.vh"
`include "cpu_types_pkg.vh"

module register_file
(
  input logic CLK, nRST,
  register_file_if.rf rfif
);
  // word
  import cpu_types_pkg::*;

  word_t [31:1] register;

  always_ff @(negedge CLK or negedge nRST) begin
    if (!nRST) begin
      register <= '0;
    end else if (rfif.WEN && rfif.wsel != 0) begin
      register[rfif.wsel] <= rfif.wdat;
    end
  end

  assign rfif.rdat1 = rfif.rsel1 == 0 ? '0 : register[rfif.rsel1];
  assign rfif.rdat2 = rfif.rsel2 == 0 ? '0 : register[rfif.rsel2];
endmodule
