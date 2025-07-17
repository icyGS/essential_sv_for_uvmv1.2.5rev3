/*-----------------------------------------------------------------
File name     : monitor.sv
Developers    : Brian Dickinson
Created       : 01/08/19
Description   : lab6 monitor component 
Notes         : From the Cadence "Essential SystemVerilog for UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2019
-----------------------------------------------------------------*/

class monitor extends component_base;
 virtual interface port_if vif;
 int portno;

 packet pkt;

  function new (string name, component_base parent);
    super.new(name, parent);
  endfunction

  task run();
   forever begin
     vif.collect_packet(pkt);
     $display("Port%0d Monitor (%s) captures packet IN @%t",portno, pathname(), $time);
     pkt.print();
    end
  endtask

endclass    
