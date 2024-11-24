//-------------------------------------------------------------------------
//						dr_sequencer                                       
//-------------------------------------------------------------------------
class dr_sequencer extends uvm_sequencer#(dr_seq_item);
  
    `uvm_component_utils(dr_sequencer) 
  
    //---------------------------------------
    //constructor                            
    //---------------------------------------
    function new(string name, uvm_component parent);
      super.new(name,parent);
    endfunction
  endclass