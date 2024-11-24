//--------------------------------------------------------
//						dr_test                           
//--------------------------------------------------------
`include "dr_env.sv"
class dr_model_base_test extends uvm_test;
  
  `uvm_component_utils(dr_model_base_test)
  
  //---------------------------------------
  // env instance                          
  //---------------------------------------
  dr_model_env env;
  
  //---------------------------------------
  // constructor                           
  //---------------------------------------
  function new(string name = "dr_model_base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction:new
  
  //---------------------------------------
  // build_phase                           
  //---------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    env = dr_model_env::type_id::create("env", this);
  endfunction:build_phase
  
  //---------------------------------------
  // end_of_elobaration phase              
  //---------------------------------------
  virtual function void end_of_elaboration();
    //print the topology
    print();
  endfunction
  
  //---------------------------------------
  // report_phase phase                    
  //---------------------------------------
  function void report_phase(uvm_phase phase);
    uvm_report_server svr;
    super.report_phase(phase);
    
    svr = uvm_report_server::get_server();
    
    if(svr.get_severity_count(UVM_FATAL) + svr.get_severity_count(UVM_ERROR)>0)
      begin 
        `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
        `uvm_info(get_type_name(), "----            TEST FAIL          ----", UVM_NONE)
        `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
      end
      else begin
        `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
        `uvm_info(get_type_name(), "----           TEST PASS           ----", UVM_NONE)
        `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
      end
  endfunction
  
endclass