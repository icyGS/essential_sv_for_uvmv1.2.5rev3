/*-----------------------------------------------------------------
File name     : driver.sv
Developers    : Brian Dickinson
Created       : 01/08/19
Description   : lab5 driver component 
Notes         : From the Cadence "Essential SystemVerilog for UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2019
-----------------------------------------------------------------*/

class driver extends component_base;

 sequencer sref;

  function new (string name, component_base parent);
    super.new(name, parent);
  endfunction

  task run();
    $display("Driver @%s",pathname());
    $display("Sequencer @%s",sref.pathname());
    
  endtask

endclass


