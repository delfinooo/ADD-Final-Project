//ECE 5440
//Delfino Tzul, 6627
//TwoDigitScore
//The TwoDigitScore module represents two digits whose overall value increments everytime 
//it recieves an increment signal. The module must be enabled to start incrementing.
//This module can be used to keep score as the digits began at 00.
//The module contains two instances of the DigitScore module. 


module TwoDigitScore(Score_Reconfig, Score_Enable, Increment, clk, rst, Tens_Digit, Ones_Digit);
  input Score_Reconfig;
  input Score_Enable;
  input Increment;
  input clk, rst;
  
  output [3:0] Tens_Digit;
  output [3:0] Ones_Digit;
  
  wire Increment_One_Ten; //Increment signal from Ones to Tens Digit
  wire Increment_Ten_None; //Increment from Tens to None Digit
  
  
  //Instantiate Digit Score Modules
  DigitScore OnesDigit(Score_Reconfig, Increment, Score_Enable, clk, rst, Increment_One_Ten, Ones_Digit);
  DigitScore TensDigit(Score_Reconfig, Increment_One_Ten, Score_Enable, clk, rst, Increment_Ten_None, Tens_Digit);
  

endmodule