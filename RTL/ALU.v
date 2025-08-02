module ALU(A,B,ALUControl,Result,Negative,Zero,Carry,Overflow);

input [31:0]A,B;
input [2:0]ALUControl;
output [31:0]Result;
output Negative,Zero,Carry,Overflow;

wire [31:0] sum, B2;
wire cout;

assign B2 = (ALUControl[0] == 1'b0) ? B : ~B; 

assign {cout,sum} = A + B2 + ALUControl ;

assign Result = (ALUControl[2:0] == 3'b000) ? sum :
                (ALUControl[2:0] == 3'b001) ? sum :
                (ALUControl[2:0] == 3'b010) ? (A & B) :
                (ALUControl[2:0] == 3'b011) ? (A | B) :
                (ALUControl[2:0] == 3'b101) ? {{31{1'b0}},(sum[31])} : 32'd0 ;
                
assign Negative = Result[31]; //negative flag
assign Zero     = &(~Result); //zero flag
assign Carry    = (cout & (~ALUControl[1])); //carry flag
assign Overflow = (~ALUControl[1]) & (sum[31] ^ A[31]) & (~(A[31 ^ B[31] ^ ALUControl[0]])); //overflow flag 


endmodule