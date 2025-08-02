`include"ALU_CONTROL.v"
`include"CONTROL_UNIT.v"

module CONTROL_UNIT_TOP(Opcode, Zero, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, func3, func7, ALUControl, PCSrc, Jump);

input [6:0]Opcode, func7;
input [2:0]func3;
input Zero;
output RegWrite, ALUSrc, MemWrite, Branch, PCSrc, Jump;
output [1:0] ImmSrc, ResultSrc;
output [2:0]ALUControl;

wire [1:0]ALUOp;

    CONTROL_UNIT CONTROL(
                .Opcode(Opcode),
                .zero(Zero),
                .RegWrite(RegWrite),
                .ImmSrc(ImmSrc),
                .MemWrite(MemWrite),
                .ResultSrc(ResultSrc),
                .Branch(Branch),
                .ALUSrc(ALUSrc),
                .ALUOp(ALUOp),
                .PCSrc(PCSrc),
                .Jump(Jump)
    );

    ALU_CONTROL ALU_CONTROL(
                            .ALUOp(ALUOp),
                            .func3(func3),
                            .func7(func7),
                            .Opcode(Opcode),
                            .ALUControl(ALUControl)
    );


endmodule