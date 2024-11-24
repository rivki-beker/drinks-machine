`include "uvm_macros.svh"
`include "dr_interface.sv"
`include "dr_base_test.sv"
`include "dr_random_test.sv"

module tbench_top;
  
  //---------------------------------------
  //clock and reset signal declaration     
  //---------------------------------------
  bit clk;
  bit rst;
  
  //---------------------------------------
  //clock generation                       
  //---------------------------------------
  always #5 clk = ~clk;
  
  //---------------------------------------
  //reset Generation                       
  //---------------------------------------
  initial begin 
    rst = 1;
    #5 rst = 0;
  end
  
  //---------------------------------------
  //interface instance                     
  //---------------------------------------
  dr_if intf(clk, rst);
  
  //---------------------------------------
  //DUT instance                           
  //---------------------------------------
  drink DUT(
    .clk(clk),
    .rst(rst),
    .valid(intf.valid),
    .pay_in(intf.pay_in),
    .code(intf.code),
    .drink(intf.drink),
    .error(intf.error)
  );
  
  //-----------------------------------------------------------------
  //passing the interface handle to lower heirarchy using set method 
  //and enabling the wave dump                                       
  //-----------------------------------------------------------------
  initial begin 
    uvm_config_db#(virtual dr_if)::set(uvm_root::get(), "*", "vif", intf);
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  //---------------------------------------
  //calling test                           
  //---------------------------------------
  initial begin
    run_test();
  end
  
endmodule