//ECE 5440
//Tarek Bakeer 0491
//sequenceCheck_tb
//Test bench for the sequence check module

`timescale 1ns / 1ps

module sequenceCheck_tb;

    // Inputs
    reg [3:0] player_num;
    reg b_player;
    reg clk;
    reg rst;
    reg [19:0] S_in;
    reg [2:0] LVL;
    reg display_done;

    // Outputs
    wire correct;
    wire incorrect;
    wire RAM_r;
    wire [4:0] RAM_addr;

    // Instantiate the Unit Under Test (UUT)
    sequenceCheck uut (
        .player_num(player_num),
        .b_player(b_player),
        .clk(clk),
        .rst(rst),
        .S_in(S_in),
        .RAM_addr(RAM_addr),
        .RAM_r(RAM_r),
        .correct(correct),
        .incorrect(incorrect),
        .LVL(LVL),
        .display_done(display_done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Initialize Inputs
        player_num = 4'b0000;
        b_player = 0;
        rst = 0;
        S_in = 20'h00000;
        LVL = 3'd1;
        display_done = 0;

        // Wait 10 ns for global reset to finish
        #10;
        
        // Release reset
        rst = 1;
        #30;
// Testing Level 5
		LVL = 3'd5;
#20;

        display_done = 1;
        #10;
        display_done = 0;
		#20
        S_in = 20'h123AC; // Expected sequence: A
        
        // Press button with correct digit
        #50;
        player_num = 4'h1;
        b_player = 1;
        #10;
        b_player = 0;
        
        // Wait for verification
        #50;

        player_num = 4'h2;
        b_player = 1;
        #10;
        b_player = 0;
// Wait for verification
        #50;

player_num = 4'h3;
        b_player = 1;
        #10;
        b_player = 0;
// Wait for verification
        #50;

player_num = 4'hA;
        b_player = 1;
        #10;
        b_player = 0;
// Wait for verification
        #50;

player_num = 4'hC;
        b_player = 1;
        #10;
        b_player = 0;
// Wait for verification
        #50;








    end

   

endmodule
