module SIGN_EXTEND(In, ImmSrc, Imm_Ext);

input [31:0]In;
input [1:0]ImmSrc;
output [31:0]Imm_Ext;
    
    assign Imm_Ext = (ImmSrc == 2'b01) ? {{20{In[31]}}, In[31:25], In[11:7]} :	//store instruction format
                     (ImmSrc == 2'b00) ? {{20{In[31]}}, In[31:20]}          :    //load instruction format
					 (ImmSrc == 2'b10) ? {{20{In[31]}}, In[7], In[30:25], In[11:8], 1'b0} :   //branch instruction format
                     (ImmSrc == 2'b11) ? {{12{In[31]}}, In[19:12], In[20], In[30:21], 1'b0} : 32'b0;   //jump instruction format
    
endmodule