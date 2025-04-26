//ECE 5440
//Delfino Tzul, 6627
//OneSecTimer
//This module will output a single pulse every 1 second. This second is based on a 50 MHz clock rate.
//A HundredMsTimer module and a CountTo10(counter) module are used to achieve this.
//An enable is needed for this module to work.

module OneSecTimer(enable, clk, rst, oneSecTimeout);
  input enable;
  input clk, rst;
  output oneSecTimeout;
  wire w_hundredmstimeout;

  //instantiate HundredMsTimer
  HundredMsTimer Main_HundredMsTimer(enable, clk, rst, w_hundredmstimeout);
  //instantiate CountTo10
  CountTo10 Main_CountTo10(w_hundredmstimeout, clk, rst, oneSecTimeout);

endmodule 
