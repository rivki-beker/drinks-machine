//-------------------------------------------------------------------------
//						dr_sequence                                        
//-------------------------------------------------------------------------
class random_sequence extends uvm_sequence#(dr_seq_item);
    uvm_analysis_port#(dr_seq_item) dr_exp;
    `uvm_object_utils(random_sequence)
    
    //---------------------------------------
    //Constructor                            
    //---------------------------------------
    function new(string name = "random_sequence");
      super.new(name);
    endfunction
    
    `uvm_declare_p_sequencer(dr_sequencer)
    
    //-----------------------------------------------
    // create, randomize and send the item to driver 
    //-----------------------------------------------
    virtual task body();
      `uvm_do(req)
       dr_exp.write(req);
    endtask
  endclass