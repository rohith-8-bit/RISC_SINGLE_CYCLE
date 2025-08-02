module REGISTER_FILE(A1, A2, A3, clk, rst, WE3, WD3, RD1, RD2);

input [4:0]A1, A2, A3;
input clk, rst, WE3;
input [31:0] WD3;
output [31:0] RD1, RD2;

reg [31:0] Register [31:0];

assign RD1 = (!rst | A1 == 5'b0) ? 32'b0 : Register[A1];
assign RD2 = (!rst | A2 == 5'b0) ? 32'b0 : Register[A2];

always@(posedge clk) begin
    if(WE3 & (A3 != 5'b0)) begin
        Register[A3] <= WD3;
    end
end

initial begin
	//Register[0] <= 32'h00000000;
	Register[9] <= 32'h00000020;
	Register[6] <= 32'h0000000A;
	//Register[11] <= 32'h00000028;
	//Register[12] <= 32'h00000030;
end
 
endmodule