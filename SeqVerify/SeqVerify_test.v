`timescale 1ns/100ps

module SeqVerify_test();
  reg display_done, b_player, newSequence, clk, rst;
  reg [2:0] LVL;
  reg [3:0] player_num;
  reg [19:0] Sequence;
  wire correct, incorrect;
  SeqVerify DUT_SeqVerify(display_done, LVL, b_player, newSequence, Sequence, 
                          player_num, clk, rst, correct, incorrect);

  always begin
    clk = 1'b0;
    #10;
    clk = 1'b1;
    #10;
  end

  initial begin
    display_done = 1'b0; b_player = 1'b0; newSequence = 1'b0; rst = 1'b1;
    player_num = 4'd0;
    LVL = 3'd3; //checking only 3 digits
    Sequence = 20'h12345; //setting sequence 
    
    //handle reset 
    @(posedge clk);
    #5 rst = 1'b0;
    @(posedge clk);
    #5 rst = 1'b1;
    @(posedge clk);
    //beginning sequence store process
    #5 newSequence = 1'b1;
    @(posedge clk);
    #5 newSequence = 1'b0;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    //beginning sequence check process
    #5 display_done = 1'b1;
    @(posedge clk);
    #5 display_done = 1'b0;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    //sending numbers from player
    #5 player_num = 4'd1;
    @(posedge clk);
    #5 b_player = 1'b1;  //sent 1
    @(posedge clk);
    #5 b_player = 1'b0;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    //#5 player_num = 4'd2; //(correct)
    #5 player_num = 4'd1; //(incorrect)
    @(posedge clk);
    #5 b_player = 1'b1;  //sent 2 (correct) or 1 (incorrect)
    @(posedge clk);
    #5 b_player = 1'b0;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    #5 player_num = 4'd3;
    @(posedge clk);
    #5 b_player = 1'b1;  //sent 3
    @(posedge clk);
    #5 b_player = 1'b0;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    
 

  end
endmodule
