`timescale 1 ns/100 ps
module RAM_SCORE_testbench ( );
    reg clk, rst, score_req, isGuest;
    reg [6:0] score;
    reg [2:0] playerID;
    wire [4:0] RAM_addr;
    wire [6:0] RAM_out, RAM_data;
    wire RAM_W;
    wire personal_winner, global_winner, RAM_R, valid;

    always
      begin
        clk = 1'b0;
        #10;
        clk = 1'b1;
        #10;
      end

    ScoreTracking DUT_ScoreTracking(score_req, score, playerID, isGuest, RAM_data, personal_winner, global_winner, RAM_addr, RAM_out, RAM_W, RAM_R, valid, clk, rst);
    RAM_SCORE DUT_RAM_SCORE(RAM_addr, clk, RAM_out, RAM_W, RAM_data);

    initial
      begin
        rst = 1'b1;
        score_req = 1'b0;
        isGuest = 1'b0;
        score = 7'd0;
        playerID = 3'd0;
        @(posedge clk);
        @(posedge clk);
        #5 rst = 1'b0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        #5 rst = 1'b1;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        #5 score = 7'd7;
        #5 playerID = 3'b101;
        @(posedge clk);
        @(posedge clk);
        #5 score_req = 1'b1;
        @(posedge clk);
        @(posedge clk);
        #5 score_req = 1'b0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        #5 score = 7'd5;
        #5 playerID = 3'b101;
        @(posedge clk);
        @(posedge clk);
        #5 score_req = 1'b1;
        @(posedge clk);
        @(posedge clk);
        #5 score_req = 1'b0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        #5 score = 7'd9;
        #5 playerID = 3'b101;
        @(posedge clk);
        @(posedge clk);
        #5 score_req = 1'b1;
        @(posedge clk);
        @(posedge clk);
        #5 score_req = 1'b0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        #5 score = 7'd8;
        #5 playerID = 3'b001;
        @(posedge clk);
        @(posedge clk);
        #5 score_req = 1'b1;
        @(posedge clk);
        @(posedge clk);
        #5 score_req = 1'b0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        isGuest = 1'b1;
        #5 score = 7'd10;
        #5 playerID = 3'b101;
        @(posedge clk);
        @(posedge clk);
        #5 score_req = 1'b1;
        @(posedge clk);
        @(posedge clk);
        #5 score_req = 1'b0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
      end
endmodule
