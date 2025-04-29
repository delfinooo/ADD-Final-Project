//ECE 5440
//Thomas Vo 2179861
//20-bit random number generator using LFSR

module randnum_LFSR(clock, q);
input clock;
output [19:0] q;

reg [19:0] LFSR; // 20-bit Linear Feedback Shift Register

// Initialize LFSR to a non-zero seed value to avoid stuck-at-zero state
initial begin
    LFSR = 20'hABCDE; // Arbitrary non-zero initial seed
end

always @(posedge clock) begin
    // Feedback calculation for maximal-length 20-bit LFSR
    // XOR taps at bit positions 20 and 3 (adjusted from 20 and 17 traditional taps)
    LFSR[0] <= LFSR[19] ^ LFSR[2]; // New bit = XOR of bit 19 and bit 2
    LFSR[19:1] <= LFSR[18:0];      // Shift register contents to the right
end

// Assign current LFSR value to output
assign q = LFSR;

endmodule
