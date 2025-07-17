/*-----------------------------------------------------------------
File name     : packet_data.sv
Developers    : Brian Dickinson
Created       : 01/08/19
Description   : lab1 packet data item 
Notes         : From the Cadence "Essential SystemVerilog for UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2019
-----------------------------------------------------------------*/

// Follow instructions in lab book
  
// add print and type policies here
typedef enum {ANY, SINGLE, MULTICAST, BROADCAST} ptype_t; 
typedef enum {HEX,BIN,DEC} pp_t;


// packet class
class packet;

  // add properties here
  local string name;

  bit [3:0] target;
  bit [3:0] source;
  bit [7:0] data;
  ptype_t ptype;

  // constructor sets source and packet type
  function new ( string name, int idt);
    this.name = name;
    source = 1 << idt; 
    ptype = ANY;
  endfunction

  function string gettype();
    return ptype.name();
  endfunction

  function string getname();
    return name;
  endfunction

  function void print(input pp_t pp = DEC);
    $display("----------------------------------");
    $display("name: %s, type: %s",getname(), gettype());
    case (pp)
      HEX: $display("from source %h, to target %h, data %h",source,target,data);
      DEC: $display("from source %0d, to target %0d, data %0d",source,target,data);
      BIN: $display("from source %b, to target %b, data %b",source,target,data);
    endcase
    $display("----------------------------------\n");
  endfunction





  // add constructor to set instance name and source by arguments and packet type

 // add print with policy
 
endclass

