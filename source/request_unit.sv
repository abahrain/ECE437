// interface include
`include "request_unit_if.vh"
`include "datapath_cache_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module request_unit (
  input CLK, nRST,
  datapath_cache_if.dp dpif,
  request_unit_if.ru ruif
);

  logic saw_instruction_halt;
  logic general_pause;

  always_ff @(posedge CLK, negedge nRST) begin
    if (!nRST) begin
      saw_instruction_halt <= '0;
    end else if (ruif.instruction_halt == '1) begin
      saw_instruction_halt <= '1;
    end
  end

  assign dpif.imemREN = ~ruif.system_halt;
  assign dpif.imemaddr = ruif.imemaddr;
  assign dpif.dmemREN = ruif.memread;
  assign dpif.dmemWEN = ruif.memwrite;

  assign dpif.dmemstore = ruif.dmemstore;
  assign dpif.dmemaddr  = ruif.dmemaddr;

  assign dpif.halt = ruif.system_halt;

  assign ruif.pcpause = ~dpif.ihit | ruif.system_halt;
  assign ruif.dmemload = dpif.dmemload;
  assign ruif.system_halt = saw_instruction_halt & ruif.pipeline_end_halt;

  assign general_pause = ~dpif.ihit | ruif.system_halt;

  assign ruif.fdif_nop = saw_instruction_halt & ~(ruif.memread | ruif.memwrite)
  & ~ruif.fdif_pause;
  assign ruif.fdif_pause = general_pause;
  assign ruif.deif_nop = '0;
  assign ruif.deif_pause = general_pause;
  assign ruif.emif_nop = dpif.dhit;
  assign ruif.emif_pause = general_pause & ~ruif.emif_nop;
  assign ruif.mwif_nop = '0;
  assign ruif.mwif_pause = general_pause & ~dpif.dhit;
endmodule
