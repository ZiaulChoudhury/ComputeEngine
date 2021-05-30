module mkmultfinal(clk, a, b, p,ce);
input clk;
input ce;
(*keep = "True"*)input signed[16 - 1 : 0] a;
(*keep = "True"*)input signed[16 - 1 : 0] b;
output[32 - 1 : 0] p;
reg signed  [16 - 1 : 0] a_reg0;
reg signed  [16 - 1 : 0] b_reg0;
wire signed [32 - 1 : 0] tmp_product;
reg signed  [32 - 1 : 0] p;
assign tmp_product[31:0] = $signed(a_reg0[15:0]) * $signed(b_reg0[15:0]);
always @ (posedge clk) begin
if(ce) begin
a_reg0 <= a;
b_reg0 <= b;
end
p <= tmp_product; 
end
endmodule

