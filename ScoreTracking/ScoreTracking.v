module ScoreTracking(score_req, score, playerID, isGuest, RAM_data, personal_winner, global_winner, RAM_addr, RAM_out, RAM_W, RAM_R, valid, clk, rst);
    input score_req, isGuest, clk, rst;
    input [6:0] score, RAM_data;
    input [2:0] playerID;
    output personal_winner, global_winner, RAM_W, RAM_R, valid;
    output [4:0] RAM_addr;
    output [6:0] RAM_out;
    reg personal_winner, global_winner, RAM_W, RAM_R, valid;
    reg [4:0] RAM_addr;
    reg [6:0] RAM_out;

    parameter RAM_INIT=1, Wait=2, Check_Guest=3, Fetch_RAM=4, RAM_CYC1=5, RAM_CYC2=6, Catch_RAM=7, Compare=8, Write_RAM=9, Check_GlobalWinner=10, Update_Global =11;
    reg [3:0] State;
    reg ram_init;
    reg [4:0] counter;
    reg [2:0] player_id;
    reg [6:0] player_score;
    reg [6:0] ram_score;
    reg [2:0] winnerPlayerID;
    reg [6:0] winnerScore;

    always@(posedge clk) begin
      if(rst==1'b0) begin
        ram_init <= 1'b1;
        counter <= 5'd0;
        personal_winner <= 1'b0;
        global_winner <= 1'b0;
        valid <= 1'b0;
        winnerScore <= 7'd0;
        winnerPlayerID <= 3'd0;
        State <= RAM_INIT;
      end
      else begin
        case(State)
          RAM_INIT : begin
            if(ram_init==1'b1) begin
              RAM_W <= 1'b1;
              RAM_R <= 1'b0;
              RAM_addr <= counter;
              RAM_out <= 7'd0;
              counter <= counter + 1;
              if(counter == 5'd31) begin
                ram_init <= 1'b0;
                State <= Wait;
              end
              else begin
                State <= RAM_INIT;
              end
            end
            else begin
              State <= Wait;
            end
          end
          Wait : begin
            RAM_R <= 1'b0;
            RAM_W <= 1'b0;
            valid <= 1'b0;
            if(score_req == 1'b1) begin
              player_id <= playerID;
              player_score <= score;
              State <= Check_Guest;
            end
            else begin
              State <= Wait;
            end
          end
          Check_Guest : begin
            personal_winner <= 1'b0;
            global_winner <= 1'b0;
            if(isGuest == 1'b1) begin
              State <= Check_GlobalWinner;
            end
            else begin
              State <= Fetch_RAM;
            end
          end
          Fetch_RAM : begin
            RAM_R <= 1'b1;
            RAM_W <= 1'b0;
            RAM_addr <= {2'b00, player_id};
            State <= RAM_CYC1;
          end
          RAM_CYC1 : begin
            State <= RAM_CYC2;
          end
          RAM_CYC2 : begin
            State <= Catch_RAM;
          end
          Catch_RAM : begin
            ram_score <= RAM_data;
            State <= Compare;
          end
          Compare : begin
            if(player_score > ram_score) begin
              personal_winner <= 1'b1;
              State <= Write_RAM;
            end
            else begin
              personal_winner <= 1'b0;
              valid <= 1'b1;
              State <= Wait;
            end
          end
          Write_RAM : begin
            RAM_R <= 1'b0;
            RAM_W <= 1'b1;
            RAM_out <= player_score;
            RAM_addr <= {2'b00, player_id};
            State <= Check_GlobalWinner;
          end
          Check_GlobalWinner : begin
            if(player_score > winnerScore) begin
              global_winner <= 1'b1;
              State <= Update_Global;
            end
            else begin
              global_winner <= 1'b0;
              valid <= 1'b1;
              State <= Wait;
            end
          end
          Update_Global : begin
            if(isGuest == 1'b0) begin
              winnerScore <= player_score;
              winnerPlayerID <= player_id;
            end
            valid <= 1'b1;
            State <= Wait;
          end
          default : begin
            State <= Wait;
          end
        endcase
      end
    end
endmodule