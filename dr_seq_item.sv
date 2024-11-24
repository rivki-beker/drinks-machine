//-------------------------------------------------------------------------
//						dr_seq_item                                        
//-------------------------------------------------------------------------
class dr_seq_item extends uvm_sequence_item;
  
    //---------------------------------------
    //data and control fields                
    //---------------------------------------
    rand bit valid;
    rand bit [9:0] pay_in;
    rand bit [7:0] code;
           bit [7:0] drink;
            bit error;
    
    //---------------------------------------
    //Utility and Field macros               
    //---------------------------------------
    `uvm_object_utils_begin(dr_seq_item)
      `uvm_field_int(valid,UVM_ALL_ON)
        `uvm_field_int(pay_in,UVM_ALL_ON)
       `uvm_field_int(code,UVM_ALL_ON)
        `uvm_field_int(drink,UVM_ALL_ON)
        `uvm_field_int(error,UVM_ALL_ON)
    `uvm_object_utils_end
    
    //---------------------------------------
    //Constructor                            
    //---------------------------------------
    function new(string name ="dr_seq_item");
      super.new(name);
    endfunction
    
    //---------------------------------------
    //constaints                             
    //---------------------------------------
    constraint solve_before { solve pay_in before code; };
    constraint pay_in_c  { pay_in inside {10'h3F, 10'hFF, 10'h3FF}; };
    constraint six_c {pay_in == 10'h3F -> code inside { 8'hC1, 8'hC2, 8'hC3}; };
    constraint eigth_c {pay_in == 10'hFF -> code inside { 8'hB6, 8'hB7 }; };
    constraint ten_c {pay_in == 10'h3FF -> code inside { 8'hD4, 8'hD5 }; };
    
  //   constraint code_c  { code inside {8'hC1, 8'hC2, 8'hC3, 8'hB6, 8'hB7,8'hD4, 8'hD5}; };
  endclass