//ECE 5440
//Thomas Vo 2179861
//Programmable timer using chained counters and LFSR timer

module progTimer (
    clk, rst, enable, curLvl, timeout
);
input clk, rst, enable;
input [2:0] curLvl;
output timeout;

wire one, two; // Internal wires to connect timer stages

// Instantiate 1ms LFSR-based timer
LFSR_1msTimer A(
    enable,  // Enable signal
    clk,     // Clock input
    rst,     // Reset signal
    one      // Output: generates a pulse every 1ms
);

// Instantiate counter to create 0.1 second timing from 1ms pulses
count_to_100 B(
    clk,
    rst,
    enable,  // Enable signal
    one,     // Input from 1ms timer
    two      // Output: generates a pulse every 0.1s
);

// Instantiate counter to generate programmable timeout based on current level
count_to_X C(
    clk,
    rst,
    curLvl,  // Current difficulty level input
    enable,  // Enable signal
    two,     // Input from 0.1s timer
    timeout  // Final timeout output
);

endmodule
