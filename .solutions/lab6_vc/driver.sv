/*-----------------------------------------------------------------
File name     : driver.sv
Developers    : Brian Dickinson
Created       : 01/08/19
Description   : lab6 driver component 
Notes         : From the Cadence "Essential SystemVerilog for UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2019
-----------------------------------------------------------------*/

class driver extends component_base;

 sequencer sref;

 virtual interface port_if vif;

 packet pkt;

  function new (string name, component_base parent);
    super.new(name, parent);
  endfunction

  task run(int runs);
    repeat (runs) begin
      sref.get_next_item(pkt);
      //$display("Driver (%s) sends packet IN @%t", pathname(), $time);
      //pkt.print();
      vif.drive_packet(pkt);
    end
  endtask

endclass


