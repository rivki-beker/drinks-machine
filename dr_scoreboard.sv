//---------------------------------------------------
//						dr_scoreboard                
//---------------------------------------------------
`uvm_analysis_imp_decl(_exp)
`uvm_analysis_imp_decl(_act)

class dr_scoreboard extends uvm_scoreboard;
  //---------------------------------------------------------
  // declaring pkt_qu to store the pkt's recived from monitor
  //---------------------------------------------------------
  dr_seq_item pkt_act[$];
  dr_seq_item pkt_exp[$];
  
  //---------------------------------------
  //port to recive packets from monitor    
  //---------------------------------------
  uvm_analysis_imp_act #(dr_seq_item, dr_scoreboard) item_actual;
  uvm_analysis_imp_exp #(dr_seq_item, dr_scoreboard) item_expected;
  `uvm_component_utils(dr_scoreboard)
  
  //---------------------------------------
  // new - constructor                     
  //---------------------------------------
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  //------------------------------------------------------
  // build_phase - create port and initialize local memory
  //------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_actual = new("item_actual", this);
    item_expected = new("item_expected", this);
  endfunction : build_phase
  
  //----------------------------------------------------------------
  // write task - recives the pkt from monitor and pushes into queue
  //----------------------------------------------------------------
  virtual function void write_act(dr_seq_item pkt);
    pkt.print();
    pkt_act.push_back(pkt);
    `uvm_info(get_type_name(), $sformatf("pkt_act %h", pkt_act[pkt_act.size()-1].code), UVM_LOW)
  endfunction : write_act
      
      
  virtual function void write_exp(dr_seq_item pkt);
    if(pkt.code == 8'hC1 || pkt.code == 8'hC2 || pkt.code == 8'hC3)
      begin
      	if(pkt.pay_in != 10'h3F)
      		pkt.error = 1;
      end
    else if(pkt.code == 8'hD4 || pkt.code == 8'hD5)
      begin
      	if( pkt.pay_in != 10'h3FF)
      		pkt.error = 1;
      end
    else if(pkt.code == 8'hB6 || pkt.code == 8'hB7)
      begin
      	if( pkt.pay_in != 10'hFF)
      		pkt.error = 1;
      end
    else
    pkt.error = 1;
    pkt.drink = pkt.code;
    if(pkt.valid == 0)
      pkt.error = 1;
    else if(!pkt.error)
    	pkt_exp.push_back(pkt);
    `uvm_info(get_type_name(), $sformatf("pkt_exp %h", pkt_exp[pkt_exp.size()-1].code), UVM_LOW)
  endfunction : write_exp
    
  //---------------------------------------
  //check phase                            
  //---------------------------------------
   function void check_phase(uvm_phase phase);
      dr_seq_item a, b;
      a = new("a");
      b = new ("b");
     `uvm_info(get_type_name(), $sformatf("pkt_exp.size: %h pkt_act.size: %h", pkt_exp.size(), pkt_act.size()), UVM_LOW)
     repeat(pkt_act.size())begin
        a = pkt_act.pop_front();
        b = pkt_exp.pop_front();
       
       if(a.drink != b.drink)
            `uvm_error(get_type_name(), $sformatf("expected: %h != actual %h", b.drink, a.drink))
            else `uvm_info(get_type_name(), $sformatf("expected: %h = actual %h", b.drink, a.drink), UVM_LOW)
          end
    endfunction : check_phase
    
      
      
endclass