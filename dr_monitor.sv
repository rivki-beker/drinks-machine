//-------------------------------------------------------
//						dr_monitor                       
//-------------------------------------------------------

class dr_monitor extends uvm_monitor;
  
    //---------------------------------------
    // Virtual Interface                     
    //---------------------------------------
    virtual dr_if vif;
    
    //------------------------------------------------------
    // analysis port, to send the transaction to scoreboard 
    //------------------------------------------------------
    uvm_analysis_port #(dr_seq_item) item_actual;
    
    dr_seq_item trans_collected;
    
    `uvm_component_utils(dr_monitor)
    
    //---------------------------------------
    // new - constructor                     
    //---------------------------------------
    function new (string name, uvm_component parent);
      super.new(name, parent);
      trans_collected = new();
      item_actual = new("item_actual", this);
    endfunction : new
    
    //--------------------------------------------
    // build_phase - getting the interface handle 
    //--------------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual dr_if)::get(this, "", "vif", vif))
        `uvm_fatal("NOVIf", { "virtual interface must be set for:", get_full_name(), ".vif" });
    endfunction:build_phase
    
    //--------------------------------------------
    // run_phase                                  
    //--------------------------------------------
    virtual task run_phase(uvm_phase phase);
      forever begin
        
        @(posedge vif.clk)
        begin
          #2ns;
          if(!vif.error)
          begin
            `uvm_info(get_type_name(),$sformatf("*****monitor data %h %h",vif.drink,vif.error),UVM_LOW)
            trans_collected = new();
            trans_collected.drink = vif.drink;
            trans_collected.error=vif.error;
            item_actual.write(trans_collected);
          end
        end
      
      end
      
    endtask:run_phase
  endclass