module randnum_LFSR(clock, q);
  input clock;
  output [19:0] q;

  reg [19:0] LFSR;

  // Initialize to a non-zero value
  initial begin
    LFSR = 20'hABCDE; // Any non-zero seed value
  end

  always @(posedge clock) begin
    // Taps for maximal-length 20-bit LFSR: bits 20 and 17
    LFSR[0] <= LFSR[19] ^ LFSR[2];
    LFSR[19:1] <= LFSR[18:0];
  end

  assign q = LFSR;
endmodule
