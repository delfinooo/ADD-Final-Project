module control_display_seq (
    clk,rst, display, curLvl, seq, timer,
    seqDigit, displayDone, enable_to_timer
);
input clk, rst, display, timer;
input [2:0] curLvl;
input [19:0] seq;
output reg displayDone, enable_to_timer;
output reg [3:0] seqDigit;

reg  [3:0] state;
reg [19:0] caughtSeq;
reg [2:0] counter;
parameter init = 0,
          w1 = 1, d1 = 2,
          w2 = 3, d2 = 4,
          w3 = 5, d3 = 6,
          w4 = 7, d4 = 8,
          w5 = 9, d5 = 10,
          done1 = 11, done2 = 12;

always @(posedge clk) begin
    if (rst == 0) begin
        displayDone <= 0;
        state <= init;
        counter <= 0;
        seqDigit <= 4'dX;
        enable_to_timer <= 0;
    end else begin
        case (state)
            init: begin
                displayDone <= 0;
                if (display == 1) begin
                    caughtSeq <= seq;
                    state <= w1;
                    enable_to_timer <= 1;
                    counter <= 0;
                end
            end

            // --- Wait before showing first digit ---
            w1: begin
                seqDigit <= 4'dX;
                if (timer == 1)
                    state <= d1;
            end
            d1: begin
                seqDigit <= caughtSeq[19:16];
                if (timer == 1) begin
                    if (counter + 1 == curLvl)
                        state <= done1;
                    else
                        state <= w2;
                    counter <= counter + 1;
                end
            end

            w2: begin
                seqDigit <= 4'dX;
                if (timer == 1)
                    state <= d2;
            end
            d2: begin
                seqDigit <= caughtSeq[15:12];
                if (timer == 1) begin
                    if (counter + 1 == curLvl)
                        state <= done1;
                    else
                        state <= w3;
                    counter <= counter + 1;
                end
            end

            w3: begin
                seqDigit <= 4'dX;
                if (timer == 1)
                    state <= d3;
            end
            d3: begin
                seqDigit <= caughtSeq[11:8];
                if (timer == 1) begin
                    if (counter + 1 == curLvl)
                        state <= done1;
                    else
                        state <= w4;
                    counter <= counter + 1;
                end
            end

            w4: begin
                seqDigit <= 4'dX;
                if (timer == 1)
                    state <= d4;
            end
            d4: begin
                seqDigit <= caughtSeq[7:4];
                if (timer == 1) begin
                    if (counter + 1 == curLvl)
                        state <= done1;
                    else
                        state <= w5;
                    counter <= counter + 1;
                end
            end

            w5: begin
                seqDigit <= 4'dX;
                if (timer == 1)
                    state <= d5;
            end
            d5: begin
                seqDigit <= caughtSeq[3:0];
                if (timer == 1) begin
                    state <= done1;
                    counter <= counter + 1;
                end
            end

            done1: begin
                enable_to_timer <= 0;
                displayDone <= 1;
                seqDigit <= 4'dX;
                state <= done2;
            end
            done2: begin
                displayDone <= 0;
                state <= init;
            end

            default: begin
                state <= init;
                displayDone <= 0;
                counter <= 0;
                seqDigit <= 4'dX;
                enable_to_timer <= 0;
            end
        endcase
    end
end

    
endmodule