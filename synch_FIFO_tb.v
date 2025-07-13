`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2025 17:46:54
// Design Name: 
// Module Name: synch_FIFO_tb
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
`define FIFO_DEPTH 16
`define DATA_WIDTH 8
`define PTR_SIZE $clog2(`FIFO_DEPTH)

module synch_FIFO_tb();
reg clk,rst,wr_en,rd_en;
reg [`DATA_WIDTH-1:0] data_in;
wire [`DATA_WIDTH-1:0] data_out;
wire [`PTR_SIZE:0] fifo_counter;
wire fifo_empty,fifo_full;

integer i;

synch_FIFO dut(.clk(clk),.rst(rst),.wr_en(wr_en),.rd_en(rd_en),.data_in(data_in),.data_out(data_out),.fifo_counter(fifo_counter),.fifo_empty(fifo_empty),.fifo_full(fifo_full));
always #5 clk = ~clk;
initial 
begin
clk = 0;
rst = 1;
wr_en = 0;
rd_en = 0;
data_in = 0;
#100;
#15 rst = 0;
// writing data into FIFO
for(i=0;i<`FIFO_DEPTH;i=i+1) begin
@(posedge clk)
if(!fifo_full) begin
wr_en <= 1;
data_in <= i;
end
end
@(posedge clk)
wr_en <= 0;
#20;
// fetching data from FIFO
for(i=0;i<`FIFO_DEPTH;i=i+1) begin
@(posedge clk)
if(!fifo_empty) begin
rd_en <= 1;
end
end
@(posedge clk)
rd_en <= 0;
#20;
$finish;
end
endmodule
