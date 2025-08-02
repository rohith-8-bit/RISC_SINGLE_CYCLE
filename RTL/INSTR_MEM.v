module INSTR_MEM(Addr, rst, RD);

input [31:0]Addr;
input rst;      //active low reset
output [31:0] RD;
    
reg [31:0] Mem [1023:0];
    
assign RD = (~rst) ? 32'b0 : Mem[Addr[31:2]];

initial begin
	//Mem[0] <= 32'h00500293;
	//Mem[1] <= 32'h00F28313; //addi;
	//Mem[0] <= 32'hFFD30393; //addi;
	//Mem[1] <= 32'h00A3C413; //addi;
	//Mem[0] <= 32'hFF9FF06F; //jump;

	$readmemh("memfile.hex",Mem);
end

endmodule