//ECE 5440
//Thomas Vo 2179861
//Top module connecting display sequence control and programmable timer

module dispSeq (
    clk, rst, curLvl, display, seq,
    seqDigit, displayDone, showSeq
);
input clk, rst, display;
input [2:0] curLvl;
input [19:0] seq;
output displayDone, showSeq;
output [3:0] seqDigit;

wire control_to_timer_enable, timeout; // Internal wires for module connections

// Instantiate programmable timer
progTimer myTimer(
    clk,
    rst,
    control_to_timer_enable, // Enable signal from control_display_seq
    curLvl,                   // Current level determines timer settings
    timeout                   // Timer output to control_display_seq
);

// Instantiate control display sequence module
control_display_seq myDS(
    clk,
    rst,
    display,                  // Trigger to start displaying sequence
    curLvl,
    seq,                      // 20-bit sequence to display
    timeout,                  // Input from timer
    seqDigit,                 // Output current digit to display
    displayDone,              // Output done signal
    showSeq,                  // Signal to control when to show digit
    control_to_timer_enable   // Output to control timer start/reset
);

endmodule
