// ECE5440 10409
// Tyler Nguyen 8480
// HundredMsTimer Module
// The HundredMsTimer module generates a 100-millisecond timeout signal using a combination of a 1-millisecond timer and a counter. 
// It instantiates the OneMsTimer module to create a 1-millisecond timeout signal and uses this signal as input to the CountTo100 module. 
// The CountTo100 module counts the 1-millisecond timeouts and outputs a 100-millisecond timeout signal when the count reaches 100. 
// The module operates with the enable, clock, and reset inputs, resetting the timer and output signal as needed.

module HundredMsTimer(enable, hundredMsTimeout, clk, rst);
    input clk, rst;
    input enable;
    output hundredMsTimeout;
    
    wire oneMsTimeout;

    OneMsLFSR OneMsLFSR1(enable, oneMsTimeout, clk, rst);
    CountTo100 CountTo100_1(oneMsTimeout, hundredMsTimeout, clk, rst);

endmodule
