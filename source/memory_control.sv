/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;

  // outputs to cache
  assign ccif.iload[0] = ccif.ramload;
  assign ccif.iwait[0] = ccif.iREN[0] & (ccif.dREN[0] | ccif.dWEN[0] | (ccif.ramstate != ACCESS));
  assign ccif.dload[0] = ccif.ramload;
  assign ccif.dwait[0] = (ccif.dREN[0] | ccif.dWEN[0]) & (ccif.ramstate != ACCESS);

  // outputs to ram
  assign ccif.ramaddr  = (ccif.dREN[0] | ccif.dWEN[0]) ? ccif.daddr[0] : ccif.iaddr[0];
  assign ccif.ramREN   = ccif.dREN[0] | (!ccif.dWEN[0] & ccif.iREN[0]);
  assign ccif.ramWEN   = ccif.dWEN[0];
  assign ccif.ramstore = ccif.dstore[0];
endmodule
