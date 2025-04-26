//ECE 5440
//Delfino Tzul, 6627
//Controller
//The Controller module controls the entire system process. It contains an instance of the Authentication and GameController modules.
//Through these instances, the module permits players to login to the system, logout of the system, and play the game.
//It provides control signals to various other modules in the system and contains ROMs that hold the players' ids and passwords.

module Controller(ID_pass_Digit, loggedout, loggedin, clk, rst, game_b, correct, incorrect, psub_b_in, seq_b_in, TwoDigitTimeout,
                  T_S_Enable, T_S_Reconfig, dead, psub_b_out, seq_b_out, currentlevel, personalwin, globalwin, valid, 
                  isGuest_out, newHighScore, score_req, inPlayID_out, score_out );
  input clk, rst;
  input game_b;  
  //GameController module signals
  input correct, incorrect, psub_b_in, seq_b_in, TwoDigitTimeout;
  output T_S_Enable, T_S_Reconfig, dead, psub_b_out, seq_b_out;
  output [3:0] currentlevel;
  input personalwin, globalwin, valid;
  output isGuest_out, newHighScore, score_req;
  output [2:0] inPlayID_out;
  output [6:0] score_out;
  //Authentication module signals
  input [3:0] ID_pass_Digit;
  output loggedout, loggedin;
  //internal
  wire passed;
  wire logout;
  wire isGuest;
  wire [2:0] internalPlayerID;
  //instantiation of the GameController module
  GameController(passed, correct, incorrect, game_b, psub_b_in, seq_b_in, TwoDigitTimeout, clk, rst, 
                 T_S_Enable, T_S_Reconfig, dead, psub_b_out, seq_b_out, currentlevel, logout,
                 personalwin, globalwin, valid, isGuest, internalPlayerID,                    
                 isGuest_out, intPlayID_out, newHighScore, score_req, score_out);

  //instantiation of the Authentication module
  Authentication(ID_pass_Digit, game_b, clk, rst, passed, logout, loggedin, loggedout, isGuest, internalPlayerID);
endmodule
