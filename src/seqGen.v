//ECE 5440
//Thomas Vo 2179861
//Sequence generator combining LFSR random number and control logic

module seqGen (
    clk, rst, b_seq, seq, display, new_seq
);
input clk, rst, b_seq;
output display, new_seq;
output [19:0] seq;

wire [19:0] rand_num; // Wire to hold generated random number

// Instantiate 20-bit random number generator using LFSR
randnum_LFSR myLFSR(
    clk,        // Clock input
    rand_num    // 20-bit random output
);

// Instantiate control logic for sequence generation
control_seq_gen myC(
    clk,
    rst,
    b_seq,      // Button/trigger to generate new sequence
    rand_num,   // Random number input from LFSR
    display,    // Output to control sequence display
    new_seq,    // Signal indicating a new sequence is ready
    seq         // 20-bit sequence output
);

endmodule
