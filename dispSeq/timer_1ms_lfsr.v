module timer_1ms_lfsr (
    input clk, rst, enable,
    output reg one_ms_timeout
);
    reg [15:0] lfsr;
    wire feedback = lfsr[0] ^ lfsr[2] ^ lfsr[3] ^ lfsr[5]; // XOR taps for LFSR
    // Terminal value (found during simulation: F315)
    parameter TERMINAL_VALUE = 16'hF315;  
    always @(posedge clk) begin
        if (rst == 1'b0) begin
            lfsr <= 16'hACE1;  // Seed value to avoid getting stuck in all-zero state
            one_ms_timeout <= 0;
        end 
        else if (enable) begin
            lfsr <= {lfsr[14:0], feedback}; // Shift LFSR
            if (lfsr == TERMINAL_VALUE)  // Compare against the terminal state
                one_ms_timeout <= 1;
            else
                one_ms_timeout <= 0;
        end
    end
endmodule
