module drink(
  input            clk,
  input            rst,
  input            valid,
  input  [9:0]     pay_in,
  input  [7:0]     code,
  output reg [7:0] drink,
  output reg       error
);
  always @(posedge clk or posedge rst) begin
      if (rst) begin
          drink <= 0;
          error <= 0;
      end else if (valid) begin
          error <= 0;
          case (code)
              8'hC1, 8'hC2, 8'hC3: 
                  if (pay_in == 10'h3F) drink <= code; else error <= 1;
              8'hD4, 8'hD5: 
                  if (pay_in == 10'h3FF) drink <= code; else error <= 1;
              8'hB6, 8'hB7: 
                  if (pay_in == 10'hFF) drink <= code; else error <= 1;
              default: error <= 1;
          endcase
      end else if (!valid && (pay_in != 0 || code != 0)) begin
          error <= 1;
      end
  end

  always @(negedge clk) begin
          drink <= 0;
          error <= 0;
  end
endmodule