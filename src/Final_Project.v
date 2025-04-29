//ECE5440
//Delfino Tzul, 6627
//Final_Project
//
//This module contains the following instances:
//1 instance of the TwoDigitTimer module,
//1 instance of the TwoDigitScore module,
//2 instances of the Mux2to1 module,
//1 instance of the CreateFace module, 
//6 instances of the SevenSegDecoder module,
//1 instance of the TopSeqGen module,
//1 instance of the SeqVerify module,
//3 instances of the ButtonShaper module,
//1 instances of the ScoreTracker module,
//and 1 instance of the Controller module.
//The player's switches are located on the very right of the switches on the FPGA board.
//The authentication switches are located on the very left of the switches on the FPGA board.

module Final_Project(Playernum, AuthDigit, b_game, b_psub, b_seq, clk, rst, 
                     LoggedIn, LoggedOut, GlobalWin, Timer_Tens_Display, Timer_Ones_Display,
							Score_Tens_Display, Score_Ones_Display, Seq_Display, Lvl_Display);
								 
  input [3:0] Playernum, AuthDigit;
  input b_game, b_psub, b_seq, clk, rst;
  output LoggedIn, LoggedOut, GlobalWin; //LEDs
  output [6:0] Timer_Tens_Display, Timer_Ones_Display; 
  output [6:0] Score_Tens_Display, Score_Ones_Display;
  output [6:0] Seq_Display, Lvl_Display;
  //internal signals
  wire b_psub_in, b_psub_out, b_seq_in, b_seq_out, b_game_in; //button signals
  wire correct, incorrect, TwoDigitTimeout, T_S_Enable, T_S_Reconfig, died;
  wire psub_b_out, seq_b_out, personalwin, globalwin, valid;
  wire [3:0] curlevel;
  wire isGuest_out, newHighScore, score_req;
  wire [2:0] intPlayID_out;
  wire [6:0] score_out;
  wire displayDone, showSeq, newSequence;
  wire [19:0] Sequence;
  wire Timer_Score_Reconfig, Timer_Score_Enable, showFace;
  wire [6:0] Face_eyes, Face_mouth;
  wire [3:0] seqDigit;
  wire [3:0] Timer_Tens_Digit, Timer_Ones_Digit, Score_Tens_Digit, Score_Ones_Digit;
  wire [6:0] Score_Tens_Mux, Score_Ones_Mux, Seq_Mux;

  // Connect Buttons to Button Shaper
  ButtonShaper PSub_ButtonShaper(b_psub, b_psub_in, clk , rst);
  ButtonShaper Game_ButonShaper(b_game, b_game_in, clk, rst); 
  ButtonShaper Seq_ButonShaper(b_seq, b_seq_in, clk, rst); 
  

  // Connect Controller
  Controller Main_Controller(AuthDigit, LoggedOut, LoggedIn, clk, rst, b_game_in, correct, incorrect, b_psub_in, b_seq_in, TwoDigitTimeout,
									  T_S_Enable, T_S_Reconfig, died, psub_b_out, seq_b_out, curlevel, personalwin, globalwin, valid, 
									  isGuest_out, newHighScore, score_req, intPlayID_out, score_out);
									 
  // Connect SeqVerify
  SeqVerify SeqVerify1(displayDone, curlevel[2:0], psub_b_out, newSequence, Sequence, Playernum, clk, rst, correct, incorrect);
  
  //Connect ScoreTracker
  ScoreTracker ScoreTracker1(score_req, score_out, intPlayID_out, isGuest_out, clk, rst, personalwin, globalwin, valid);
  
  // Connect TwoDigitTimer
  TwoDigitTimer Main_TwoDigitTimer(T_S_Reconfig, T_S_Enable, clk, rst, TwoDigitTimeout, Timer_Tens_Digit, Timer_Ones_Digit);
  
  // Connect CreateFace
  CreateFace CreateFace1(newHighScore, died, Face_eyes, Face_mouth, showFace, clk, rst);
  
  // Connect TopSeqGen
  TopSeqGen TopSeqGen1(curlevel[2:0], seq_b_out, clk, rst, seqDigit, displayDone, showSeq, Sequence, newSequence);
  
  // Connect TwoDigitScore
  TwoDigitScore Main_TwoDigitScore(T_S_Reconfig, T_S_Enable, correct, clk, rst, Score_Tens_Digit, Score_Ones_Digit);
  
  // Connect TwoDigitScore output signals to SevenSegDecoders
  SevenSegDecoder Score10s_Dec(Score_Tens_Digit, Score_Tens_Mux);
  SevenSegDecoder Score1s_Dec(Score_Ones_Digit, Score_Ones_Mux);
  
  // Decode and Display TwoDigitTimer output signals
  SevenSegDecoder Timer10s_Dec(Timer_Tens_Digit, Timer_Tens_Display);
  SevenSegDecoder Timer1s_Dec(Timer_Ones_Digit, Timer_Ones_Display);
  
  // Decode Level and Sequence 
  SevenSegDecoder Seq_Dec(seqDigit, Seq_Mux);
  SevenSegDecoder Lvl_Dec(curlevel, Lvl_Display); 
  
  //Connect Mux between Sequence Display and TopSeqGen
  Mux2to1 MuxSeq(7'b1111111, Seq_Mux, showSeq, Seq_Display);
  
  // Connect Muxes to the CreateFace and TwoDigitScore output signals
  Mux2to1 Mux10s(Score_Tens_Mux, Face_eyes, showFace, Score_Tens_Display);
  Mux2to1 Mux1s(Score_Ones_Mux, Face_mouth, showFace, Score_Ones_Display);
  
  
  // Assign Statements
  assign GlobalWin = globalwin;
  
endmodule
