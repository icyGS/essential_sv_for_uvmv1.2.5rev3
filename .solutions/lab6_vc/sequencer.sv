/*-----------------------------------------------------------------
File name     : sequencer.sv
Developers    : Brian Dickinson
Created       : 01/08/19
Description   : lab6 sequencer component
Notes         : From the Cadence "Essential SystemVerilog for UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2019
-----------------------------------------------------------------*/

class sequencer extends component_base;

  int portno;
  int ok;

  function new (string name, component_base parent);
    super.new(name, parent);
  endfunction

  function void get_next_item(output packet pkt);
    psingle ps;
    pbroadcast pb;
    pmulticast pm;
    randcase
      1:begin : single_packet
        ps = new("ps",portno); 
        ok = ps.randomize();
        pkt = ps;
        end
      1:begin : multicast_packet
        pm = new("ps",portno); 
        ok = pm.randomize();
        pkt = pm;
        end
      1:begin : broadcast_packet
        pb = new("ps",portno); 
        ok = pb.randomize();
        pkt = pb;
        end
       endcase
  endfunction

endclass
