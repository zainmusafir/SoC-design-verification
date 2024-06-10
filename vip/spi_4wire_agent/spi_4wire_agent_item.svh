class spi_4wire_agent_item extends uvm_sequence_item;
   logic [7:0] rw_address;
   logic [7:0] write_data;
   logic [7:0] read_data;

   `uvm_object_utils_begin(spi_4wire_agent_item);
     `uvm_field_int(rw_address, UVM_DEFAULT);
     `uvm_field_int(write_data, UVM_DEFAULT);
     `uvm_field_int(read_data, UVM_DEFAULT);
   `uvm_object_utils_end;



  virtual function void displayAllData();
    `uvm_info("item data", $sformatf("rw_address=%h, write_data=%h, read_data=%h", rw_address, write_data, read_data), UVM_HIGH)
  endfunction

endclass: spi_4wire_agent_item