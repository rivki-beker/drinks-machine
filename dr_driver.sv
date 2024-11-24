//------------------------------------------------------
//						dr_driver                       
//------------------------------------------------------
class dr_driver extends uvm_driver #(dr_seq_item);
  
    //---------------------------------------
    // Virtual Interface                     
    //---------------------------------------
    virtual dr_if vif;
    `uvm_component_utils(dr_driver)
    
    //---------------------------------------
    // Constructor                           
    //---------------------------------------
    function new (string name, uvm_component parent);
      super.new(name, parent);
    endfunction : new
  
    //---------------------------------------
    // build phase                           
    //---------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual dr_if)::get(this,"" ,"vif",vif))
        `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
      endfunction:build_phase
    
    //---------------------------------------
    // run phase                             
    //---------------------------------------
    virtual task run_phase(uvm_phase phase);
      forever begin 
        seq_item_port.get_next_item(req);
        drive(req);
        seq_item_port.item_done();
      end
    endtask:run_phase
    
    //-------------------------------------------------------
    // drive - transaction level to signal level             
    // drives the value's from seq_item to interface signals 
    //-------------------------------------------------------
    virtual task drive(dr_seq_item req);
      @(posedge vif.clk)
      begin
      vif.valid = req.valid;
      vif.pay_in = req.pay_in;
      vif.code = req.code;
        `uvm_info(get_type_name(),$sformatf("*****driver data %h %h %h",vif.valid,vif.pay_in,vif.code),UVM_LOW)
      end
      @(negedge vif.clk)
      begin
      vif.valid = 0;
      vif.pay_in = 0;
      vif.code = 0;
        `uvm_info(get_type_name(),$sformatf("*****driver data %h %h %h",vif.valid,vif.pay_in,vif.code),UVM_LOW)
      end
    endtask:drive
  
  endclass