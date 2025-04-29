//ECE 5440
//Delfino Tzul, 6627
//HundredMsTimer
//This module will output a single pulse every 100 milliseconds. This time is based on a 50 MHz clock rate.
//A OneMsTimer module and a CountTo100(counter) module are used to achieve this.
//An enable is needed for this module to work.

module HundredMsTimer(enable, clk, rst, hundredMsTimeout);
  input clk, rst;
  input enable;
  output hundredMsTimeout;

  wire w_onemstimeout;

  //instantiate LFSR_1msTimer
  LFSR_1msTimer LFSR_1msTimer1(enable, clk, rst, w_onemstimeout);
  //instantiate CountTo100
  CountTo100 Main_CountTo100(w_onemstimeout, clk, rst, hundredMsTimeout);

endmodule
