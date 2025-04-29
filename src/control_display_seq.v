//ECE 5440
//Thomas Vo 2179861
//FSM code for control display sequence

module control_display_seq (
    clk,rst, display, curLvl, seq, timer,
    seqDigit, displayDone, showSeq, enable_to_timer
);
input clk, rst, display, timer;
input [2:0] curLvl;
input [19:0] seq;
output reg displayDone, enable_to_timer;
output reg [3:0] seqDigit;
output reg showSeq;

reg  [3:0] state;
reg [19:0] caughtSeq;
reg [2:0] counter;

// State encoding
parameter init = 0,
          w1 = 1, d1 = 2,
          w2 = 3, d2 = 4,
          w3 = 5, d3 = 6,
          w4 = 7, d4 = 8,
          w5 = 9, d5 = 10,
          done1 = 11, done2 = 12;

always @(posedge clk) begin
    if (rst == 0) begin
        // Reset all outputs and state variables
        displayDone <= 0;
        state <= init;
        counter <= 0; 
        showSeq <= 1'b0;
        seqDigit <= 4'd0;
        enable_to_timer <= 0;
    end else begin
        case (state)
            init: begin
                // Initialization state: wait for display signal
                displayDone <= 0;
                if (display == 1) begin
                    caughtSeq <= seq;            // Capture input sequence
                    state <= w1;                 // Move to first wait state
                    enable_to_timer <= 1;         // Start timer
                    counter <= 0;                // Reset counter
                end
            end

            // --- Wait state before showing first digit ---
            w1: begin
                seqDigit <= 4'd0; 
                showSeq <= 1'b0;                  // Clear display output
                if (timer == 1)
                    state <= d1;                  // When timer expires, show first digit
            end
            d1: begin
                seqDigit <= caughtSeq[19:16]; 
                showSeq <= 1'b1;                  // Display first digit
                if (timer == 1) begin
                    if (counter + 1 == curLvl)    // If enough digits shown, go to done
                        state <= done1;
                    else
                        state <= w2;              // Else, wait for next digit
                    counter <= counter + 1;       // Increment counter
                end
            end

            // --- Wait and display second digit ---
            w2: begin
                seqDigit <= 4'd0; 
                showSeq <= 1'b0;
                if (timer == 1)
                    state <= d2;
            end
            d2: begin
                seqDigit <= caughtSeq[15:12]; 
                showSeq <= 1'b1;
                if (timer == 1) begin
                    if (counter + 1 == curLvl)
                        state <= done1;
                    else
                        state <= w3;
                    counter <= counter + 1;
                end
            end

            // --- Wait and display third digit ---
            w3: begin
                seqDigit <= 4'd0; 
                showSeq <= 1'b0;
                if (timer == 1)
                    state <= d3;
            end
            d3: begin
                seqDigit <= caughtSeq[11:8]; 
                showSeq <= 1'b1;
                if (timer == 1) begin
                    if (counter + 1 == curLvl)
                        state <= done1;
                    else
                        state <= w4;
                    counter <= counter + 1;
                end
            end

            // --- Wait and display fourth digit ---
            w4: begin
                seqDigit <= 4'd0; 
                showSeq <= 1'b0;
                if (timer == 1)
                    state <= d4;
            end
            d4: begin
                seqDigit <= caughtSeq[7:4]; 
                showSeq <= 1'b1;
                if (timer == 1) begin
                    if (counter + 1 == curLvl)
                        state <= done1;
                    else
                        state <= w5;
                    counter <= counter + 1;
                end
            end

            // --- Wait and display fifth digit ---
            w5: begin
                seqDigit <= 4'd0; 
                showSeq <= 1'b0;
                if (timer == 1)
                    state <= d5;
            end
            d5: begin
                seqDigit <= caughtSeq[3:0]; 
                showSeq <= 1'b1;
                if (timer == 1) begin
                    state <= done1;
                    counter <= counter + 1;
                end
            end

            // --- Display done sequence ---
            done1: begin
                enable_to_timer <= 0;             // Disable timer
                showSeq <= 1'b0;                  // Stop displaying digits
                displayDone <= 1;                 // Raise done signal
                seqDigit <= 4'd0;                 // Clear digit
                state <= done2;
            end
            done2: begin
                displayDone <= 0; 
                showSeq <= 1'b0;
                state <= init;                    // Return to init to wait for next sequence
            end

            default: begin
                // Default case: reinitialize everything
                state <= init;
                displayDone <= 0;
                counter <= 0; 
                showSeq <= 1'b0;
                seqDigit <= 4'd0;
                enable_to_timer <= 0;
            end
        endcase
    end
end

endmodule
