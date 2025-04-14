// ECE 5440 10409
// Tyler Nguyen
// CreateFace Module
// Description

`timescale 1 ns/100 ps
module testbench_CreateFace();
    reg clk, rst;
    reg newHighScore_s, died_s;
    wire [6:0] eyes_s, mouth_s;
    wire showFace_s;

    always
      begin
          clk = 1'b0;
          #10;
          clk = 1'b1;
          #10;
      end

    CreateFace DUT_CreateFace1(newHighScore_s, died_s, eyes_s, mouth_s, showFace_s, clk, rst);

    initial
      begin
          rst = 1'b1;
          newHighScore_s = 1'b0;
          died_s = 1'b0;

          @(posedge clk);
          rst = 1'b0;
          @(posedge clk);
          rst = 1'b1;

          @(posedge clk);
          #5 newHighScore_s = 1'b1;
          //#5 died_s = 1'b1;
          @(posedge clk);
          #5 newHighScore_s = 1'b0;
          //#5 died_s = 1'b0;
          @(posedge clk);
      end

endmodule
