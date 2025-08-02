module CONTROL_UNIT(Opcode, zero, ResultSrc, MemWrite, ALUSrc, RegWrite, ImmSrc, ALUOp, Branch, PCSrc, Jump);

input [6:0]Opcode;
input zero;
output MemWrite, ALUSrc, RegWrite, Branch, PCSrc, Jump;
output [1:0] ImmSrc, ALUOp, ResultSrc;
   
    
    assign RegWrite  = ((Opcode == 7'b0000011) | (Opcode == 7'b0110011) | (Opcode == 7'b0010011) | (Opcode == 7'b1101111)) ? 1'b1 : 1'b0;
    
    assign ALUSrc    = (Opcode == 7'b0000011) | (Opcode == 7'b0100011 | (Opcode == 7'b0010011)) ? 1'b1 : 1'b0;
    
    assign MemWrite  = (Opcode == 7'b0100011) ? 1'b1 : 1'b0;
    
    assign ResultSrc = (Opcode == 7'b0000011) ? 2'b01 : (Opcode == 7'b1101111) ? 2'b10 : 2'b00;
    
    assign Branch    = (Opcode == 7'b1100011) ? 1'b1 : 1'b0;
    
    assign ImmSrc    = (Opcode == 7'b0100011) ? 2'b01 : (Opcode == 7'b1100011) ? 2'b10 : (Opcode == 7'b1101111) ? 2'b11 : 2'b00;
    
    assign ALUOp     = (Opcode == 7'b0110011 | (Opcode == 7'b0010011)) ? 2'b10 : (Opcode == 7'b1100011) ? 2'b01 : 2'b00;

    assign PCSrc     = (((zero) & (Branch)) | Jump ) ;

    assign Jump      = (Opcode == 7'b1101111) ? 1'b1 : 1'b0;

endmodule