//ECE 5440
//Delfino Tzul, 6627
//ScoreChecker
//The ScoreChecker module is in charge of sending requests to the score tracking module in order to verify
//if a player has exceeded either their personal best score or the global winner score.
//The module will also inform the createFace module 
//This process occurs after a game has concluded.

module ScoreChecker(personalwin, globalwin, valid, isGuest_in, intPlayID_in, checkscore, score_in, dead, clk, rst, 
                    isGuest_out, intPlayID_out, newHighScore, died, score_req, score_out);
  input isGuest_in, valid, personalwin, globalwin, checkscore, dead, clk, rst;
  input [2:0] intPlayID_in;
  input [6:0] score_in;
  output isGuest_out, newHighScore, died, score_req;
  reg isGuest_out, newHighScore, died, score_req;
  output [2:0] intPlayID_out;
  reg [2:0]  intPlayID_out;
  output [6:0] score_out;
  reg [6:0] score_out;
  //internal signals
  reg [2:0] State;
  reg deadFlag;
  parameter INACTIVE=0, REQUEST=1, WAIT=2, CHECK=3;
  
  always @ (posedge clk) begin
    if(rst == 1'b0) begin
      isGuest_out <= 1'b0; newHighScore <= 1'b0; score_out <= 7'd0;
      score_req <= 1'b0; intPlayID_out <= 3'd0; died <= 1'b0; deadFlag <= 1'b0; end
    else begin
      case(State) 
        INACTIVE: begin
	  newHighScore <= 1'b0; died <= 1'b0; //end these pulses
	  score_req <= 1'b0; deadFlag <= 1'b0;
	  isGuest_out <= 1'b0; intPlayID_out <= 3'd0;
	  if(checkscore == 1'b1) //proceed to send score to score tracking module
	    State <= REQUEST;
	  else
	    State <= INACTIVE;
          if(dead == 1'b1)
	    deadFlag <= 1'b1;
	end
	REQUEST: begin
	  score_out <= score_in; //send the score out
	  score_req <= 1'b1;
          intPlayID_out <= intPlayID_in;
	  State <= WAIT;
	end
	WAIT: begin
	  score_req <= 1'b0; //end this pulse
	  if(valid == 1'b1)
	    State <= CHECK;
	  else
	    State <= WAIT;
	end
	CHECK: begin
	  if(personalwin == 1'b1 || globalwin == 1'b1)
	    newHighScore <= 1'b1;
          else if (deadFlag == 1'b1)
	    died <= 1'b1;
	  State <= INACTIVE; 
	end
        default: begin State <= INACTIVE; end
      endcase
    end
  end
endmodule 
