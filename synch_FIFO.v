`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2025 23:23:57
// Design Name: 
// Module Name: synch_FIFO
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

module synch_FIFO(
input clk,rst,wr_en,rd_en,
input [`DATA_WIDTH-1:0] data_in,
output reg [`DATA_WIDTH-1:0] data_out,
output reg [`PTR_SIZE:0] fifo_counter,
output reg fifo_empty,fifo_full
);
reg [`PTR_SIZE-1:0] rd_ptr,wr_ptr;
reg [`DATA_WIDTH-1:0] fifo_mem[0:`FIFO_DEPTH-1]; // depth 16 => [0:15] 8 bit elements
always @(fifo_counter)
begin
fifo_empty = (fifo_counter == 0);
fifo_full = (fifo_counter == `FIFO_DEPTH);
end
always @(posedge clk or posedge rst)
begin
if(rst)
fifo_counter <= 0; // reset the counter of FIFO
else if((!fifo_full && wr_en) && (!fifo_empty && rd_en)) // when doing read and write operation simultaneously
fifo_counter <= fifo_counter; // No need to update the counter
else if(!fifo_full && wr_en) // when doing only write operation
fifo_counter <= fifo_counter + 1; // Increment the counter when data is written 
else if(!fifo_empty && rd_en) // when doing only read operation
fifo_counter <= fifo_counter - 1; // Decrement the counter when data is read
else
fifo_counter <= fifo_counter; // when doing nothing
end
//  Fetching data from FIFO
always @(posedge clk or posedge rst)
begin
if(rst)
data_out <= 0; // on reset output of FIFO is all zero 
else if(rd_en && !fifo_empty)
data_out <= fifo_mem[rd_ptr]; // reading the 8 bit data from buffer location indicated by read pointer
else
data_out <= data_out; // hold the data_out as it is
end
// Writing data into the FIFO
always @(posedge clk)
begin
if(wr_en && !fifo_full)
fifo_mem[wr_ptr]<=data_in; // write data into the FIFO
else
fifo_mem[wr_ptr]<=fifo_mem[wr_ptr]; // hold the data 
end
// for managing the pointers
always @(posedge clk or posedge rst)
begin
if(rst)
begin
wr_ptr <= 0;
rd_ptr <= 0;
end
else
begin
if(!fifo_full && wr_en)
wr_ptr <= wr_ptr + 1;
else
wr_ptr <= wr_ptr;
if(!fifo_empty && rd_en)
rd_ptr <= rd_ptr + 1;
else
rd_ptr <= rd_ptr;
end

end
endmodule
