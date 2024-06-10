   import uvm_pkg::*;
   `include "uvm_macros.svh";

class scoreboard_zu_base extends uvm_scoreboard;
    `uvm_component_utils(scoreboard_zu_base);

    function new(string name="",uvm_component parent=null);
      super.new(name,parent);
    endfunction

    typedef enum {FALSE, TRUE} bool;
   
endclass : scoreboard_zu_base
