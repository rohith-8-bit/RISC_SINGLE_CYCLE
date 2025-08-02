module PC_COUNTER(PC_NEXT, clk, rst, PC);

input [31:0]PC_NEXT;
input clk,rst;
output reg [31:0] PC;
    
    always@(posedge clk)begin
        if(~rst) begin
            PC <= 31'b0;
        end
        else begin
            PC <= PC_NEXT;
        end
    end
        
endmodule