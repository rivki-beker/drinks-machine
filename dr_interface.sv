//-------------------------------------------------------------------------
//						dr_interface                                       
//-------------------------------------------------------------------------
interface dr_if(input logic clk, rst);
 
    //---------------------------------------
    //declaring the signals                  
    //---------------------------------------
    logic valid;
    logic [9:0] pay_in;
    logic [7:0] code;
    logic [7:0] drink;
    logic error;
  endinterface
  