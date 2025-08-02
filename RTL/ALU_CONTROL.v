module ALU_CONTROL(Opcode, func7, ALUOp, func3, ALUControl);

input [6:0]Opcode, func7;
input [1:0]ALUOp;
input [2:0]func3;
output [2:0]ALUControl;
    
assign ALUControl = (ALUOp == 2'b00) ? 3'b000 :
                    (ALUOp == 2'b01) ? 3'b001 :
                    ((ALUOp == 2'b10) & (func3 == 3'b010)) ? 3'b101 :
                    ((ALUOp == 2'b10) & (func3 == 3'b110)) ? 3'b011 :
                    ((ALUOp == 2'b10) & (func3 == 3'b111)) ? 3'b010 :
                    ((ALUOp == 2'b10) & (func3 == 3'b000) & ({Opcode[5],func7[5]} == 2'b11)) ? 3'b001 :
                    ((ALUOp == 2'b10) & (func3 == 3'b000) & ({Opcode[5],func7[5]} != 2'b11)) ? 3'b000 : 3'b000;
endmodule
