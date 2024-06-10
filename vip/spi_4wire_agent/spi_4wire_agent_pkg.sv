//----------------------------------------------------------------------
// spi_wire_agent_pkg
//----------------------------------------------------------------------
package spi_4wire_agent_pkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;
     
  // Include the sequence_items (transactions)
  `include "spi_4wire_agent_item.svh"  

  // Include the agent config object
   `include "spi_4wire_agent_config.svh"
   
  // Include the components  
  `include "spi_4wire_agent_driver.svh"
     `include "spi_4wire_agent_monitor.svh"
  `include "spi_4wire_agent.svh"

  
endpackage: spi_4wire_agent_pkg