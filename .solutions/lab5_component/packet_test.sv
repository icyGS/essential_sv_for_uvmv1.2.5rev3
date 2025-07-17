/*-----------------------------------------------------------------
File name     : packet_test.sv
Developers    : Brian Dickinson
Created       : 01/08/19
Description   : lab5  module for testing verification component structure
Notes         : From the Cadence "Essential SystemVerilog for UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2019
-----------------------------------------------------------------*/

module packet_test;
import packet_pkg::*;

packet_vc pvc;


initial begin
  pvc = new("pvc", null);
  pvc.run();
end

/*bit ok;

packet parray [15:0];
packet p;
psingle ps;
pbroadcast pb;
pmulticast pm;

initial begin
  foreach (parray [i])
    randcase
     1:begin : single_packet
       ps = new($sformatf("parray[%0d]",i), 0);
       ok = ps.randomize();
       parray[i] = ps;
       end
     1:begin : multicast_packet
       pm = new($sformatf("parray[%0d]",i), 1);
       ok = pm.randomize();
       parray[i] = pm;
       end
     1:begin : broadcast_packet
       pb = new($sformatf("parray[%0d]",i), 2);
       ok = pb.randomize();
       parray[i] = pb;
       end
     endcase
  foreach (parray[i]) begin
    parray[i].print();
    validate(parray[i]);
  end
end
*/

//--------------------validate functions for verification --------------------

function int countones (input logic[3:0] vec);
  countones = 0;
  foreach (vec [i])
    if (vec[i]) countones++;
endfunction

function void validate (input packet ap);
  int sco, tco;
  sco = countones(ap.source);
  tco = countones(ap.target);
  if (sco != 1) 
     $display("ERROR in source %h - no. bits set = %0d", ap.source, sco);
  if (ap.ptype == BROADCAST) begin
    if  (ap.target != 4'hf) 
       $display("ERROR: broadcast packet target is %h not 4'hf", ap.target);
  end
  else 
  begin
    if ( |(ap.source & ap.target) == 1'b1)   
      $display("ERROR: non-broadcast packet %s has same source %h and target %h bit set", ap.getname(), ap.source, ap.target);
    if ((ap.ptype == "single") & (tco != 1)) 
      $display("ERROR: single packet %s does not have only one bit set in target %h", ap.getname(), ap.target);
    if ((ap.ptype == "multicast") & (tco < 2)) 
      $display("ERROR: multicast packet %s does not have more than one bit set in target %h", ap.getname(), ap.target);
  end
endfunction
       
endmodule
   

