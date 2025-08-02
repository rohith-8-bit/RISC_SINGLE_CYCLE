module DATA_MEM(Addr, WD, clk, WE, rst, RD);

input [31:0] Addr, WD;
input clk, WE, rst;
output [31:0] RD;
    
reg [31:0] Memory [1023:0];
    
assign RD = (~rst) ? 32'b0 : Memory[Addr];
    
always@(posedge clk) begin
    if(WE) begin
        Memory[Addr] <= WD;
    end
end

initial begin
	//Memory[28] <= 32'h00000020;
	Memory[40] <= 32'h00000044;
end
    
endmodule