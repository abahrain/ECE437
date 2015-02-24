`include "pipeline_fetch_decode_if.vh"
`include "cpu_types_pkg.vh"

module pipeline_fetch_decode
(
  input logic CLK, nRST,
  pipeline_fetch_decode_if.fd fdif
);

  import cpu_types_pkg::*;

  logic [3:0] addr_top_four_l;
  word_t pcplus4_l;
  word_t instruction_l;

  always_ff @(posedge CLK or negedge nRST) begin
    if (!nRST) begin
      addr_top_four_l <= 4'h0;
      pcplus4_l <= 32'h0;
      instruction_l <= 32'h0;
    end else if (fdif.nopmode) begin
      addr_top_four_l <= 4'h0;
      pcplus4_l <= 32'h0;
      instruction_l <= 32'h0;
    end else if (!fdif.pcpause) begin
      addr_top_four_l <= fdif.addr_top_four_i;
      pcplus4_l <= fdif.pcplus4_i;
      instruction_l <= fdif.instruction_i;
    end
  end

  assign fdif.addr_top_four_o = addr_top_four_l;
  assign fdif.pcplus4_o = pcplus4_l;
  assign fdif.instruction_o = instruction_l;

endmodule
