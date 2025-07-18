/*-----------------------------------------------------------------
File name     : packet_test.sv
Developers    : Brian Dickinson
Created       : 01/08/19
Description   : lab1  module for testing packet data
Notes         : From the Cadence "Essential SystemVerilog for UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2019
-----------------------------------------------------------------*/

module packet_test;
  import packet_pkg::*;

  packet p;

  initial begin
    p = new("p",0);
    
    // Randomize and print packet 10 times
    for (int i = 0; i < 10; i++) begin
      if (p.randomize() with { ptype != ANY; }) begin
        $display("=== Packet %0d ===", i+1);
        p.print();
      end else begin
        $display("ERROR: Failed to randomize packet %0d", i+1);
      end
    end
    
    // Force constraint violation with inline constraint for broadcast packet
    $display("\n=== Forcing Broadcast Packet (Constraint Violation) ===");
    if (p.randomize() with { target == 4'b1111; ptype != ANY; }) begin
      $display("Broadcast packet created (violates no_shared_bits constraint):");
      p.print();
    end else begin
      $display("ERROR: Failed to randomize broadcast packet");
    end
  end



//--------------------validate functions for verification --------------------
//--------------------Do not edit below this line          --------------------

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
  if (ap.ptype == "broadcast") begin
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
   

