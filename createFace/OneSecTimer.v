// ECE5440 10409
// Tyler Nguyen 8480
// OneSecTimer Module
// The OneSecTimer module generates a 1-second timeout signal by combining a 100-millisecond timer and a counter. 
// It instantiates the HundredMsTimer module to create a 100-millisecond timeout signal, which is then used as input to the CountTo10 module. 
// The CountTo10 module counts the 100-millisecond timeouts and outputs a 1-second timeout signal when the count reaches 10. 
// The module operates with the enable, clock, and reset inputs, resetting the timer and output signal as needed.

module OneSecTimer(enable, oneSecTimeout, clk, rst);
    input clk, rst;
    input enable;
    output oneSecTimeout;
    
    wire hundredMsTimeout;

    HundredMsTimer HundredMsTimer1(enable, hundredMsTimeout, clk, rst);
    CountTo10 CountTo10_1(hundredMsTimeout, oneSecTimeout, clk, rst);

endmodule
