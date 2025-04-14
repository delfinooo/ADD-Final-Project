// ECE5440 10409
// Tyler Nguyen 8480
// One Milisecond Timer LFSR Module. The OneMsLFSR module generates a timeout signal of 1 millisecond using a 16-bit Linear Feedback Shift Register (LFSR).
// When the reset signal is low, the timer resets to 0, and the timeout output is also set to 0. On each clock cycle, 
// if the enable signal is high, the LFSR manually shifts its bits, incorporating feedback to create a pseudo-random sequence. 
// Once the LFSR reaches a specific state (16'h6db6), which corresponds to the 50,000th state, the timeout signal is set high, indicating the completion of the timeout period. 
// If this state has not yet been reached, the timeout signal remains low.

module OneMsLFSR(timer_enable, timeout, clk, rst);
    input clk, rst;
    input timer_enable;
    output timeout;
    reg timeout;

    reg [15:0] LFSR;
    wire feedback = LFSR[15];

    always @(posedge clk)
      begin
          if (rst == 1'b0) begin
              timeout <= 1'b0;
              LFSR <= 16'hFFFF;
           end
          else begin // Normal Operation
              if (timer_enable == 1'b1) begin
                  LFSR[0] <= feedback;
                  LFSR[1] <= LFSR[0];
                  LFSR[2] <= LFSR[1] ^ feedback;
                  LFSR[3] <= LFSR[2] ^ feedback;
                  LFSR[4] <= LFSR[3];
                  LFSR[5] <= LFSR[4] ^ feedback;
                  LFSR[6] <= LFSR[5];
                  LFSR[7] <= LFSR[6];
                  LFSR[8] <= LFSR[7];
                  LFSR[9] <= LFSR[8];
                  LFSR[10] <= LFSR[9];
                  LFSR[11] <= LFSR[10];
                  LFSR[12] <= LFSR[11];
                  LFSR[13] <= LFSR[12];
                  LFSR[14] <= LFSR[13];
                  LFSR[15] <= LFSR[14];
                  
                  if (LFSR == 16'h6db6) begin // this use the 50,000th state of the 16-bit LFSR
                        timeout <= 1'b1;
                        LFSR <= 16'hFFFF;
                   end
                  else begin
                       timeout <= 1'b0;
                   end 
               end
              else begin
                  timeout <= 1'b0;
               end
           end
      end
endmodule
