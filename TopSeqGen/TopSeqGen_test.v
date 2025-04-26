`timescale 1ns/100ps

module TopSeqGen_test();
  reg [2:0] curLvl;
  reg b_seq, clk, rst;
  wire [3:0] seqDigit;
  wire [19:0] seq;
  wire displayDone, new_seq;

  TopSeqGen DUT_TopSeqGen(curLvl, b_seq, clk, rst, seqDigit, displayDone, seq, new_seq);

  always begin
    clk = 1'b0;
    #10;
    clk = 1'b1;
    #10;
  end

  initial begin
    curLvl = 3'd1; rst = 1'b1; b_seq = 1'b0;
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    //handle reset 
    @(posedge clk);
    #5 rst = 1'b0;
    @(posedge clk);
    #5 rst = 1'b1;
    @(posedge clk);
    //set curLvl to 3 for 3 digits to display 
    @(posedge clk);
    #5 curLvl = 3'd3;
    @(posedge clk);
    @(posedge clk);
    #5 b_seq = 1'b1; //press sequence button to generate new sequence 
    @(posedge clk);
    #5 b_seq = 1'b0; 
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
  end
endmodule
