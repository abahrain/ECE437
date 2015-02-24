`include "pc_if.vh"
`include "cpu_types_pkg.vh"

module pc (
  input CLK, nRST,
  pc_if.pc pcif
);
  // type import
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;

  always_ff @(posedge CLK or negedge nRST) begin
    if (!nRST) begin
      pcif.address <= PC_INIT;
    end else if (pcif.pcpause) begin
      pcif.address <= pcif.address;
    end else begin
      pcif.address <= pcif.next_address;
    end
  end

endmodule
