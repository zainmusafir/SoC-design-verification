class spi_4wire_agent extends uvm_agent;
   

   `uvm_component_utils(spi_4wire_agent) 


   spi_4wire_agent_driver m_driver;

   //spi_4wire_agent_item spi_item;   //object 
   spi_4wire_agent_config m_cfg;
   uvm_sequencer #(spi_4wire_agent_item) sequencer;

   //monitor and driver 

   spi_4wire_agent_monitor m_monitor;
   


  function new(string name = "spi_4wire_agent",  uvm_component parent = null);
    super.new(name, parent);
  endfunction : new



//build phase 

 virtual  function void build_phase(uvm_phase phase);
     if(!uvm_config_db #(spi_4wire_agent_config)::get(this, "", "spi_4wire_agent_config", m_cfg)) begin
      `uvm_error("build_phase", "spi_4wire_agent_config not found")
    end   

     m_monitor  = spi_4wire_agent_monitor::type_id::create("m_monitor",this);

  if (m_cfg.is_active == UVM_ACTIVE) begin
      m_driver   = spi_4wire_agent_driver::type_id::create("m_driver",this);
      sequencer  = uvm_sequencer #(spi_4wire_agent_item)::type_id::create("sequencer",this); 
      m_cfg.sequencer = sequencer;
    end 
  endfunction: build_phase

//connect phase 
 virtual function void connect_phase(uvm_phase phase);
   m_monitor.m_cfg = m_cfg;
  
   if (m_cfg.is_active == UVM_ACTIVE) begin
      `uvm_info(get_type_name(),$psprintf(" check for m_cfg: 0x%0h", m_cfg.is_active), UVM_HIGH);
      m_driver.m_cfg = m_cfg; // The virtual interface is included in the m_cfg class!!!
      m_driver.seq_item_port.connect(sequencer.seq_item_export);   
    end     
 endfunction : connect_phase

endclass : spi_4wire_agent 