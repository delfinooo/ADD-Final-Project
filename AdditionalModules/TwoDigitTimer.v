//ECE 5440
//Delfino Tzul, 6627
//TwoDigitTimer
//The TwoDigitTimer represents two digits whose overall value decrements by 1 every second.
//This decrement occurs when the instantiated OneSecTimer is enabled.
//Both digits initially are set to 99 meaning the decrement takes 99 seconds.
//These digits are created through the two instantiated DigitTimer modules.

module TwoDigitTimer(Timer_Reconfig, Timer_Enable, clk, rst, TwoDigitTimeout, Tens_Digit, Ones_Digit);
  input Timer_Reconfig;
  input Timer_Enable;
  input clk, rst;
  
  output TwoDigitTimeout;
  output [3:0] Tens_Digit;
  output [3:0] Ones_Digit;
  
  wire Borrow_One_Ten; //Borrow request from Ones to Tens Digit
  wire NoBorrow_Ten_One; //No Borrow signal from Tens to Ones Digit
  wire OneSecTimeout;
  wire Borrow_None_Ten; //Borrow from Tens to N/A Digit. Will not be used.
  
  //Instantiate One Second Timer
  OneSecTimer OneSecond(Timer_Enable, clk, rst, OneSecTimeout);
  
  //Instantiate Digit Timer Modules
  DigitTimer OnesDigit(Timer_Reconfig, OneSecTimeout, NoBorrow_Ten_One, clk, rst, Borrow_One_Ten, TwoDigitTimeout, Ones_Digit);
  DigitTimer TensDigit(Timer_Reconfig, Borrow_One_Ten, 1'b1, clk, rst, Borrow_None_Ten, NoBorrow_Ten_One, Tens_Digit);
  

endmodule