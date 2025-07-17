/*-----------------------------------------------------------------
File name     : component_base.sv
Developers    : Brian Dickinson
Created       : 01/08/19
Description   : lab6 component base class
Notes         : From the Cadence "Essential SystemVerilog for UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2019
-----------------------------------------------------------------*/

virtual class component_base;
  protected string name;
  component_base parent;

  function new (string name, component_base parent);
    this.name = name;
    this.parent = parent;
  endfunction

  virtual function string getname();
    return name;
  endfunction

 function string pathname();
    component_base ptr = this;
    pathname = name;
    while (ptr.parent != null) begin
      ptr = ptr.parent;
      pathname = {ptr.name, ".", pathname};
    end
  endfunction : pathname

  virtual function void print();
   $display("@ %s",this.pathname());
  endfunction

endclass

