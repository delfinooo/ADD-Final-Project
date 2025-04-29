//ECE 5440
//Delfino Tzul, 6627
//CountTo100
//This module will increase a counter when the input signal, increment, is high.
//To count 100 times, the counter will output a high signal, timeout, when count is 99.
//This is to compensate for time when the counter is equal to 0.
//The counter variable is 'count'.
//During testing, the counter was modified to count up to 3.

module CountTo100(increment, clk, rst, timeout);
  input increment;
  input clk, rst;
  output timeout;
  reg timeout;
  reg [6:0] count;
  
  always @(posedge clk) begin
    if(rst == 1'b0) begin
      count <= 7'b0000000;
      timeout <= 1'b0;
    end
    else begin //regular tasks
      if(increment == 1'b1) begin
        if(count == 7'b1100011) begin //(99) one less than desired : 100
        //if(count == 7'b0000010) begin //TEST WITH (2) ONE LESS THAN DESIRED : 3
          timeout <= 1'b1;
          count <= 7'b0000000; 
        end
        else begin
          //timeout <= 1'b0;
          count <= count + 7'b0000001; 
        end
      end //if(increment == 1'b1)
      else begin
        timeout <= 1'b0;
      end        
    end //else
  end //always

endmodule 
