/*-----------------------------------------------------------------
File name     : agent.sv
Developers    : Brian Dickinson
Created       : 01/08/19
Description   : lab6 component base class
Notes         : From the Cadence "Essential SystemVerilog for UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2019
-----------------------------------------------------------------*/

class agent extends component_base;

 driver drv;
 sequencer seq;
 monitor mon;

  function new (string name, component_base parent);
    super.new(name, parent);
    drv = new("drv", this);
    seq = new("seq", this);
    mon = new("mon",this);
    drv.sref = seq;
  endfunction

  function void print();
    seq.print();
    drv.print();
    mon.print();
  endfunction
  
endclass

