// ECE 5440 10409
// Tyler Nguyen
// CreateFace Module
// This top-level module manages the display of facial expressions based on system events 
// such as achieving a new high score or dying. It instantiates the `SubCreateFace` module 
// to determine which face to show (happy or sad) and uses a timer (`OneSecTimer`) to control 
// how long the face remains visible. The timer is enabled when a face is displayed and triggers 
// a timeout signal to clear the face after one second. Outputs include the 7-segment display 
// patterns for eyes and mouth, as well as a control signal to indicate whether the face should 
// currently be shown.

module CreateFace(newHighScore, died, eyes, mouth, showFace, clk, rst);
    input clk, rst;
    input newHighScore, died;
    output [6:0] eyes, mouth;
    output showFace;

    wire timer_enable, timeout;
    
    SubCreateFace SubCreateFace1(newHighScore, died, timeout, timer_enable, eyes, mouth, showFace, clk, rst);
    //OneMsLFSR OneMSLFSR1(timer_enable, timeout, clk, rst);
    OneSecTimer OneSecTimer1(timer_enable, clk, rst, timeout);

    
endmodule
