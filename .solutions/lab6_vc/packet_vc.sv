/*-----------------------------------------------------------------
File name     : packet_vc.sv
Developers    : Brian Dickinson
Created       : 01/08/19
Description   : lab6 verification component class
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

  function void configure(virtual interface port_if vif, int portno);
    agn.drv.vif = vif;
    agn.mon.vif = vif;
    agn.seq.portno = portno;
    agn.mon.portno = portno;
  endfunction
    
  task run(int runs);
    fork
      agn.mon.run();
    join_none
    agn.drv.run(runs);
      
  endtask
endclass

