//ECE 5440
//Delfino Tzul, 6627
//GameplayController
//The GameplayController module is in charge of controlling the game process. This module will ensure the timer, score, and levels are reset
//for each game. 
//The module will also keep track of the player's score throughout the game and send it to the ScoreChecker module after completion.
//The module will also handle logouts by sending a logout pulse to the Authentication module.
//This entire process only begins once the player has successfully logged in to the system.

module GameplayController(passed, correct, incorrect, game_b, psub_b_in, seq_b_in, TwoDigitTimeout, clk, rst, 
                          T_S_Enable, T_S_Reconfig, dead, psub_b_out, seq_b_out, checkscore, currentlevel, logout, PlayerScore);

  input passed, correct, incorrect, game_b, psub_b_in, seq_b_in, TwoDigitTimeout, clk, rst;
  output T_S_Enable, T_S_Reconfig, dead, psub_b_out, seq_b_out, checkscore, logout;
  output [3:0] currentlevel;
  output [6:0] PlayerScore;
  reg T_S_Enable, T_S_Reconfig, dead, psub_b_out, seq_b_out, checkscore, logout;
  reg [3:0] currentlevel;
  reg [6:0] PlayerScore;
  //internal signals
  reg [2:0] State;
  reg [3:0] delaycounter;
  parameter INACTIVE=0, RECONFIG=1, WAITFORSTART=2, GAMEPLAY=3, GAMEOVER=4, DELAY=5;

  always @(posedge clk) begin
    if(rst == 1'b0) begin
      currentlevel <= 4'd0;
      dead <= 1'd0; logout <= 1'd0;
      T_S_Enable <= 1'b0; T_S_Reconfig <= 1'b0;
      checkscore <= 1'b0; PlayerScore <= 7'd0; delaycounter <= 4'd0;
      State <= INACTIVE;
    end
    else begin
      case(State) 
        INACTIVE: begin
	  psub_b_out <= 1'b0; seq_b_out <= 1'b0; //block button outputs
	  checkscore <= 1'b0; delaycounter <= 4'd0;
          logout <= 1'b0;
	  if(passed == 1'b1 && logout != 1'b1)
	    State <= RECONFIG;
	  else
	    State <= INACTIVE;
        end
        RECONFIG: begin
	  T_S_Reconfig <= 1'b1;
	  currentlevel <= 4'd0;
	  PlayerScore <= 7'd0;
	  State <= WAITFORSTART;
        end
        WAITFORSTART: begin
	  T_S_Reconfig <= 1'b0; //end this pulse
	  if(game_b == 1'b1) begin
	    T_S_Enable <= 1'b1; //enable timer and score
	    checkscore <= 1'b0; //just in case
	    currentlevel <= 4'd1; //set to level 1 
	    State <= GAMEPLAY; end
	  else if (psub_b_in == 1'b1) begin //log out if player submit button is pressed
	    logout <= 1'b1;
	    State <= INACTIVE; end
	  else
	    State <= WAITFORSTART;
        end
        GAMEPLAY: begin
	  psub_b_out <= psub_b_in; seq_b_out <= seq_b_in; //allow button signals to pass
	  if(TwoDigitTimeout == 1'b1) begin
	    State <= GAMEOVER;
	    checkscore <= 1'b1; end
	  else if (incorrect == 1'b1) begin //player got a sequence wrong
	    State <= GAMEOVER;
	    checkscore <= 1'b1; 
	    dead <= 1'b1; end
	  else if (correct == 1'b1) begin //player got a sequence correct
	    if(currentlevel < 4'd5) //keep level at 5 (MAX LEVEL)
	      currentlevel <= currentlevel + 4'd1;
	    PlayerScore <= PlayerScore + 7'd1;  
	  end
	  else
	    State <= GAMEPLAY;
        end
        GAMEOVER: begin
	  dead <= 1'b0; //end this pulse
	  checkscore <= 1'b0; //end this pulse
	  T_S_Enable <= 1'b0;
	  psub_b_out <= 1'b0; seq_b_out <= 1'b0; //block button outputs
	  if(game_b == 1'b1) begin
	    State <= RECONFIG; end
	  else if (psub_b_in == 1'b1) begin //log out if player submit button is pressed
	    State <= DELAY;
	    delaycounter <= 4'd0;
	    logout <= 1'b1; end
	  else
	    State <= GAMEOVER;
        end
	DELAY: begin
	  logout <= 1'b0; //end this pulse
	  delaycounter <= delaycounter + 4'd1;
          if(delaycounter == 4'b1111)
	    State <= INACTIVE;
	  else
	    State <= DELAY;
	end 
        default: begin State <= INACTIVE; end
      endcase
    end  
  end
endmodule
