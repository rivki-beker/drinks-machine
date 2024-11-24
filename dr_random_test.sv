//----------------------------------------------------------
//						dr_random_test                      
//----------------------------------------------------------
class dr_random_test extends dr_model_base_test;
    `uvm_component_utils(dr_random_test)
    
    //----------------------------------
    // sequence instance                
    //----------------------------------
    
    random_sequence r_seq;
    
    uvm_analysis_port#(dr_seq_item) item_expected;
    
    //---------------------------------------
    // constructor                           
    //---------------------------------------
    function new(string name = "dr_random_test",uvm_component parent=null);
      super.new(name,parent);
    endfunction : new 
    
    //---------------------------------------
    // build_phase                           
    //---------------------------------------
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      item_expected = new("item_expected",this);
      r_seq = random_sequence::type_id::create("r_seq");
    endfunction : build_phase
    
    //---------------------------------------
    // connect_phase                         
    //---------------------------------------
    function void connect_phase(uvm_phase phase);
      item_expected.connect(env.dr_scb.item_expected);
    endfunction : connect_phase
    
    //---------------------------------------
    // run_phase - starting the test         
    //---------------------------------------
    task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      repeat(10)begin
      r_seq.dr_exp = item_expected;
      r_seq.start(env.dr_agnt.sequencer);
      #4ns;
      end
      
      phase.drop_objection(this);
    endtask : run_phase
  endclass
  
  