
//spi agent config 

class spi_4wire_agent_config extends uvm_object;
    `uvm_object_utils(spi_4wire_agent_config);

    uvm_active_passive_enum is_active = UVM_ACTIVE;  

    uvm_sequencer # (spi_4wire_agent_item) sequencer; //sequencer object 

    virtual spi_4wire_agent_if spi_4wire_agent_if;   //virtual interface handle

    function new(string name = "spi_4wire_agent_config");
        super.new(name);
    endfunction: new

endclass: spi_4wire_agent_config