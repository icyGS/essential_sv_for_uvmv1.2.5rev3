/*-----------------------------------------------------------------
File name     : fullswitch_test.sv
Developers    : Brian Dickinson
Created       : 01/08/19
Description   : lab6 top level module with all four verification components
Notes         : From the Cadence "Essential SystemVerilog for UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2019
-----------------------------------------------------------------*/

module top;

  import packet_pkg::*;

  logic clk = 1'b0;
  logic reset = 1'b0;

  packet_vc pvc0, pvc1, pvc2, pvc3;

  always
    #10 clk <= ~clk;

  port_if port0(clk,reset);
  port_if port1(clk,reset);
  port_if port2(clk,reset);
  port_if port3(clk,reset);

  switch_port sw1 (.port0, .port1, .port2, .port3, .clk, .reset);

   initial begin
    $timeformat(-9,2," ns",8);
    reset = 1'b0;
    @(negedge clk);
    reset = 1'b1;
    @(negedge clk);
    reset = 1'b0;

    // insert your code here:
    pvc0 = new("pvc0", null);
    pvc0.configure(port0, 0);
    pvc1 = new("pvc1", null);
    pvc1.configure(port1, 1);
    pvc2 = new("pvc2", null);
    pvc2.configure(port2, 2);
    pvc3 = new("pvc3", null);
    pvc3.configure(port3, 3);
    fork
      pvc0.run(1);
      pvc1.run(1);
      pvc2.run(1);
      pvc3.run(1);
    join
    #500;

    $finish;
    end

 initial begin : monitors
   fork
     port0.monitor(0);
     port1.monitor(1);
     port2.monitor(2);
     port3.monitor(3);
   join
 end

endmodule

