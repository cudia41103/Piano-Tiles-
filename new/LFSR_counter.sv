`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2023 02:37:45 PM
// Design Name: 
// Module Name: LFSR_counter
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


module LSFR_counter 
#(parameter BITS = 5)
(
  input logic clk,
  input logic rst_n,

  output reg [4:0] data
);
reg [4:0] data_next;

always @* begin
  data_next[4] = data[4]^data[1];
  data_next[3] = data[3]^data[0];
  data_next[2] = data[2]^data_next[4];
  data_next[1] = data[1]^data_next[3];
  data_next[0] = data[0]^data_next[2];
end

always_ff @(posedge clk or negedge rst_n) begin
  if(!rst_n)
    data <= 5'h1f;
  else
    data <= data_next;
end
endmodule