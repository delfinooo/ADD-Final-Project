// ECE 5440 10409
// Tyler Nguyen 8480
// Multiplexer 2to1 Module
// This module implements a 2-to-1 multiplexer that selects between two 4-bit inputs based on a single-bit select signal. 
// If select = 0, the output is assigned the value of in1. 
// If select = 1, the output is assigned the value of in2.

module Mux2to1 (in1, in2, select, select_out);
    //input clk, rst;
    input [6:0] in1, in2; // 7-bit inputs
    input select;
    output [6:0] select_out;
    reg [6:0] select_out;
    
    always@(select)
        begin
            if (select == 1'b0) begin
	        select_out = in1;
	     end
	    else begin // if select == 1'b1
	        select_out = in2;
	     end
        end
endmodule
