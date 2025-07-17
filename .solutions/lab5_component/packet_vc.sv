/*-----------------------------------------------------------------
File name     : vc.sv
Developers    : Brian Dickinson
Created       : 01/08/19
Description   : lab5 verification component 
Notes         : From the Cadence "Essential SystemVerilog for UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2019
-----------------------------------------------------------------*/

class packet_vc extends component_base;

 agent agn;

  function new (string name, component_base parent);
    super.new(name, parent);
    agn = new("agn", this);
  endfunction

  task run();
    agn.mon.run();
    agn.drv.run();
      
  endtask
endclass

