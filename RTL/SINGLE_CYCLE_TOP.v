`include "PC_COUNTER.v"
`include "INSTR_MEM.v"
`include "REGISTER_FILE.v"
`include "SIGN_EXTEND.v"
`include "ALU.v"
`include "CONTROL_UNIT_TOP.v"
`include"DATA_MEM.v"
`include"PC_ADDER.v"
`include"MUX.v"
`include"MUX_2.v"


module SINGLE_CYCLE_TOP(
        input clk,
        input rst,
        output [31:0] PC_OUT,
        output [31:0] INSTR_OUT
    );
    

wire [31:0]PC_TOP, PC_ONE, PC_TARGET, RD_INSTR, RD1_TOP, RD2_TOP, SIGN_EXT_TOP, ALUResult, ReadData, PC_PLUS, SrcB, MUX_Result;
wire RegWrite, MemWrite, ALUSrc, PCSrc, Zero, Jump;
wire [1:0] ImmSrc, ResultSrc;
wire [2:0] ALUControl_TOP;

    MUX mux_pctarget(
            .a(PC_PLUS),
            .b(PC_TARGET),
            .s(PCSrc),
            .c(PC_ONE));

    PC_COUNTER PC(
            .clk(clk),
            .rst(rst),
            .PC_NEXT(PC_ONE),
            .PC(PC_TOP));
            
    PC_ADDER PC_Adder(
            .a(PC_TOP),
            .b(32'd4),
            .c(PC_PLUS));
            
    INSTR_MEM I_MEM(
            .Addr(PC_TOP),
            .rst(rst),
            .RD(RD_INSTR));
            
    REGISTER_FILE REG_FILE(
            .A1(RD_INSTR[19:15]),
            .A2(RD_INSTR[24:20]), 
            .A3(RD_INSTR[11:7]), 
            .clk(clk), 
            .rst(rst), 
            .WE3(RegWrite), 
            .WD3(MUX_Result), 
            .RD1(RD1_TOP), 
            .RD2(RD2_TOP));
            
    SIGN_EXTEND SIGN_EXT(
            .In(RD_INSTR),
	    .ImmSrc(ImmSrc), 
            .Imm_Ext(SIGN_EXT_TOP));

    MUX mux_reg_to_alu(
            .a(RD2_TOP),
            .b(SIGN_EXT_TOP),
            .s(ALUSrc),
            .c(SrcB));

    PC_ADDER imm_and_pc_adder(
            .a(PC_TOP),
            .b(SIGN_EXT_TOP),
            .c(PC_TARGET));
            
    ALU ALU_inst(
            .A(RD1_TOP),
            .B(SrcB),
            .ALUControl(ALUControl_TOP),
            .Result(ALUResult),
            .Negative(),
            .Zero(Zero),
            .Carry(),
            .Overflow(),
            .rst(rst));
            
    CONTROL_UNIT_TOP CONTROL(
            .Opcode(RD_INSTR[6:0]),
            .Zero(Zero), 
            .RegWrite(RegWrite), 
            .ImmSrc(ImmSrc), 
            .ALUSrc(ALUSrc), 
            .MemWrite(MemWrite), 
            .ResultSrc(ResultSrc), 
            .Branch(), 
            .func3(RD_INSTR[14:12]), 
            .func7(), 
            .ALUControl(ALUControl_TOP),
            .PCSrc(PCSrc));
            
    DATA_MEM DATA_MEMORY(
            .Addr(ALUResult), 
            .WD(RD2_TOP), 
            .clk(clk), 
            .WE(MemWrite), 
            .rst(rst), 
            .RD(ReadData));

    MUX_2 mux_data_mem_to_reg(
	    .a(ALUResult),
	    .b(ReadData),
            .c(PC_PLUS),
	    .s(ResultSrc),
	    .y(MUX_Result));

assign PC_OUT = PC_TOP;
assign INSTR_OUT = RD_INSTR;
            
endmodule
