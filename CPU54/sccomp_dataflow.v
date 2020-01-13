`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/10 11:13:02
// Design Name: 
// Module Name: sccomp_dataflow
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module sccomp_dataflow(
    input clk_in,
    input reset,
    output [31:0] inst,
    output [31:0] pc
    );
     
    wire [31:0] imm;
    wire [31:0] Rt;
    wire [31:0] alu_r;
    wire cs;
    wire dm_w;
    wire dm_r;
    wire [31:0] ram_out;
    wire clk_out;
    wire [2:0]select;
    
    assign inst=imm;
assign clk_out=clk_in;
//divider div(clk_in,reset,clk_out);

    imem imem(((pc- 32'h00400000)/4),imm);
    //imem im(pc,inst)
    //IMEM imem(1,((pc- 32'h00400000)/4),imm);

    cpu sccpu(clk_out,reset,imm,ram_out, //input
                Rt,select,alu_r,pc,cs,dm_w,dm_r); //output
                
    DMEM dram(
    .clk(clk_out),
    .CS(cs),  //enable control signal
    .DM_W(dm_w), //write
    .DM_R(dm_r), //read
    .select(select),
    .addr((alu_r[31:0]-32'h10010000)),
    .data_in(Rt),
    .data_out(ram_out)
     );   
    
endmodule
