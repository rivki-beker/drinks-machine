//----------------------------------------------------------------
//						dr_env                                    
//----------------------------------------------------------------
`include "dr_agent.sv"
`include "dr_scoreboard.sv"

class dr_model_env extends uvm_env;
   
  //---------------------------------------
  // agent and scoreboard instance         
  //---------------------------------------
  dr_agent dr_agnt;
  dr_scoreboard dr_scb;
  
  `uvm_component_utils(dr_model_env)
  
  //---------------------------------------
  // constructor                           
  //---------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  //---------------------------------------
  // build_phase - crate the components    
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    dr_agnt = dr_agent::type_id::create("dr_agent", this);
    dr_scb = dr_scoreboard::type_id::create("dr_scb", this);
  endfunction : build_phase
  
  //-------------------------------------------------------
  // connect_phase - connecting monitor and scoreboard port
  //-------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    dr_agnt.monitor.item_actual.connect(dr_scb.item_actual);
  endfunction : connect_phase
  
endclass
