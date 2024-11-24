//--------------------------------------------------
//						dr_agent                    
//--------------------------------------------------

`include "dr_seq_item.sv"
`include "dr_sequencer.sv"
`include "dr_sequence.sv"
`include "dr_driver.sv"
`include "dr_monitor.sv"

class dr_agent extends uvm_agent;
  
  //---------------------------------------
  // component instances                   
  //---------------------------------------
  dr_driver driver;
  dr_sequencer sequencer;
  dr_monitor monitor;
  
  `uvm_component_utils(dr_agent)
  
  //---------------------------------------
  // constructor                           
  //---------------------------------------
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //---------------------------------------
  // build_phase                           
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    monitor = dr_monitor::type_id::create("monitor", this);
    if(get_is_active() == UVM_ACTIVE) begin
      driver = dr_driver::type_id::create("driver", this);
      sequencer = dr_sequencer::type_id::create("sequencer", this);
    end
  endfunction : build_phase
  
  //---------------------------------------------------------
  // connect_phase - connecting the driver and sequencer port
  //---------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction : connect_phase
endclass : dr_agent