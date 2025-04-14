// ECE5440 10409
// Tyler Nguyen 8480
// CountTo10 Module
// The countTo10 module counts from 0 to 10 based on the increment input signal. When the reset signal is low, the counter resets to 0, 
// and the timeout output is set to 0. On each clock cycle, if the increment signal is high, the counter increments by 1. When the counter reaches 10, 
// it resets to 0, and the timeout signal is set high. If the increment signal is low, the counter holds its value, and the timeout signal is reset to 0.

module CountTo10(incre, timeout, clk, rst);
    input clk, rst;
    input incre;
    output timeout;
    reg timeout;
    reg [3:0] count; // 10 is 4-bit in binary

    always@(posedge clk)
      begin
          if (rst == 1'b0) begin
              count <= 4'b0000;
              timeout <= 1'b0;
           end
          else begin // Normal Operation
              if (incre == 1'b1) begin
                  if (count == 4'b1001) begin // (9) because need to keep offset of 1 in mind since it count 0 first
                  //if (count == 4'b0001) begin // TEST with (1) due to offset of 1; terminal value is 2
                      count <= 4'b0000;
                      timeout <= 1'b1;
                   end
                  else begin
                      count <= count + 4'b0001;
                      timeout <= 1'b0;
                   end
               end
              else begin
                  timeout <= 1'b0;
               end
           end      
      end

endmodule