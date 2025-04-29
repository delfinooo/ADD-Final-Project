//ECE 5440
//Delfino Tzul, 6627
//GameController
//The GameController module controls the entire game process. 
//This module utilizes an instance of the GameplayController and ScoreChecker modules to properly 
//update signals during gameplay and check the player's score once the game has concluded.
//This module sends out signals to various other modules that are used to realize the game.
//The module will also inform the Authentication module when a player wishes to logout.

module GameController(passed, correct, incorrect, game_b, psub_b_in, seq_b_in, TwoDigitTimeout, clk, rst, 
                      T_S_Enable, T_S_Reconfig, died, psub_b_out, seq_b_out, currentlevel, logout,
                      personalwin, globalwin, valid, isGuest_in, intPlayID_in,                    
                      isGuest_out, intPlayID_out, newHighScore, score_req, score_out);

  input passed, correct, incorrect, game_b, psub_b_in, seq_b_in, TwoDigitTimeout, clk ,rst;
  output T_S_Enable, T_S_Reconfig, died, psub_b_out, seq_b_out, logout;
  output [3:0] currentlevel;
  input personalwin, globalwin, valid, isGuest_in;
  input [2:0] intPlayID_in;
  output isGuest_out, newHighScore, score_req;
  output [2:0] intPlayID_out; 
  output [6:0] score_out;
  //internal signals
  wire checkscore;
  wire dead;
  wire [6:0] PlayerScore;

  //instantiation of the Gameplay Controller
  GameplayController GameplayControl(passed, correct, incorrect, game_b, psub_b_in, seq_b_in, TwoDigitTimeout, clk, rst, 
                   T_S_Enable, T_S_Reconfig, dead, psub_b_out, seq_b_out, checkscore, currentlevel, logout, PlayerScore);

  //instantiation of the Score Checker
  ScoreChecker ScoreCheck(personalwin, globalwin, valid, isGuest_in, intPlayID_in, checkscore, PlayerScore, dead, clk, rst, 
                          isGuest_out, intPlayID_out, newHighScore, died, score_req, score_out);


endmodule
