`include "pipeline_memory_writeback_if.vh"
`include "cpu_types_pkg.vh"

module pipeline_memory_writeback
(
  input logic CLK, nRST,
  pipeline_memory_writeback_if.mw mwif
);

  import cpu_types_pkg::*;

  logic regwrite_l;
  logic halt_l;
  logic memtoreg_l;
  word_t dmemload_l;
  word_t aluoutput_l;
  regbits_t rd_l;

  always_ff @(posedge CLK or negedge nRST) begin
    if (!nRST) begin
      regwrite_l <= '0;
      halt_l <= '0;
      memtoreg_l <= '0;
      dmemload_l <= '0;
      aluoutput_l <= '0;
      rd_l <= '0;
    end else if (mwif.nopmode) begin
      regwrite_l <= '0;
      halt_l <= '0;
      memtoreg_l <= '0;
      dmemload_l <= '0;
      aluoutput_l <= '0;
      rd_l <= '0;
    end else if (!mwif.pcpause) begin
      regwrite_l <= mwif.regwrite_i;
      halt_l <= mwif.halt_i;
      memtoreg_l <= mwif.memtoreg_i;
      dmemload_l <= mwif.dmemload_i;
      aluoutput_l <= mwif.aluoutput_i;
      rd_l <= mwif.rd_i;
    end
  end

  assign mwif.regwrite_o = regwrite_l;
  assign mwif.halt_o = halt_l;
  assign mwif.memtoreg_o = memtoreg_l;
  assign mwif.dmemload_o = dmemload_l;
  assign mwif.aluoutput_o = aluoutput_l;
  assign mwif.rd_o = rd_l;

endmodule
