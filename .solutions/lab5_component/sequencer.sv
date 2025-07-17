/*-----------------------------------------------------------------
File name     : sequencer.sv
Developers    : Brian Dickinson
Created       : 01/08/19
Description   : lab5 sequencer component
Notes         : From the Cadence "Essential SystemVerilog for UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2019
-----------------------------------------------------------------*/

class sequencer extends component_base;

  function new (string name, component_base parent);
    super.new(name, parent);
  endfunction

endclass
