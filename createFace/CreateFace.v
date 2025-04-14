// ECE 5440 10409
// Tyler Nguyen
// CreateFace Module
// Description

module CreateFace(newHighScore, died, eyes, mouth, showFace, clk, rst);
    input clk, rst;
    input newHighScore, died;
    output [6:0] eyes, mouth;
    output showFace;

    wire timer_enable, timeout;
    
    SubCreateFace SubCreateFace1(newHighScore, died, timeout, timer_enable, eyes, mouth, showFace, clk, rst);
    //OneMsLFSR OneMSLFSR1(timer_enable, timeout, clk, rst);
    OneSecTimer OneSecTimer1(timer_enable, timeout, clk, rst);

    
endmodule
