
module ScoreTracker(score_req, score, playerID, isGuest, clk, rst, personal_winner, global_winner, valid);
  input score_req, isGuest, clk, rst;
  input [6:0] score;
  input [2:0] playerID;
  output personal_winner, global_winner, valid;

  //internal signals
  wire [4:0] RAM_addr;
  wire RAM_R, RAM_W;
  wire [6:0] RAM_out, RAM_data;
  //instantiation of the RAM 
  RAM_SCORE RAMScore(RAM_addr, clk, RAM_out, RAM_W, RAM_data);

  //instantiation of the ScoreTracking module
  ScoreTracking ScoreTracking1(score_req, score, playerID, isGuest, RAM_data, personal_winner, 
                               global_winner, RAM_addr, RAM_out, RAM_W, RAM_R, valid, clk, rst);

endmodule