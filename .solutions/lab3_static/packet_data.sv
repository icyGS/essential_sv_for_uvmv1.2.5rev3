/*-----------------------------------------------------------------
File name     : packet_data.sv
Developers    : Brian Dickinson
Created       : 01/08/19
Description   : lab4 packet data with static properties and methods
Notes         : From the Cadence "Essential SystemVerilog for UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2019
-----------------------------------------------------------------*/

  // print policy for formatting packet print
 typedef enum {HEX,BIN,DEC} pp_t;
 typedef enum {ANY,SINGLE,MULTICAST,BROADCAST} packet_type_t;
 typedef enum {UNIDED, IDED} tag_t;

// packet class
class packet;

  local string name;

  rand bit [3:0] target;
  bit [3:0] source;
  rand bit [7:0] data;
  packet_type_t ptype;

  tag_t tagmode;
  int tag;
  static int pktcount;

  // constructor sets source and packet type
  function new (string name, int idt);
    this.name = name;
    source = 1 << idt;
    ptype = ANY;
    pktcount++;
    tag = pktcount;
  endfunction

 static function int getcount();
   return (pktcount);
 endfunction

 function void post_randomize();
   if (tagmode == IDED) data = tag;
 endfunction

  // basic constraint (over-ridden for broadcast packet)
  constraint ts_bits {(target & source) == 4'b0;}
  constraint t_not0 {target != 0;}

 // print with policy
  function void print(input pp_t pp = BIN);
    $display("\n----------------------------------");
    $display("name: %s, type: %s tag: %0d pktcount %0d tagmode %s",getname(), gettype(), tag, pktcount, tagmode.name());
    case (pp)
      HEX: $display("from source %h, to target %h, data %h",source,target,data);
      DEC: $display("from source %0d, to target %0d, data %0d",source,target,data);
      BIN: $display("from source %b, to target %b, data %b",source,target,data);
    endcase
  endfunction

  function string getname();
      return name;
  endfunction

  // get packet type
  function string gettype();
      return ptype.name();
  endfunction
 
  endclass

