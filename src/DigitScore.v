//ECE 5440
//Delfino Tzul, 6627
//DigitScore
//The DigitScore module represents a digit that will increment every time it receives an increment signal and the module is enabled.
//When the digit reaches 9 and it receives an increment signal, it will output an incrementUP signal for any leading digits and
//then become 0.
//The module recieves a reconfig signal to reconfig the digit back to 0.

module DigitScore(reconfig, increment, enable, clk, rst, incrementUP, digit);
  input reconfig, increment, enable, clk, rst;
  output incrementUP;
  output [3:0] digit;
  reg incrementUP;
  reg [3:0] digit;
  always @ (posedge clk) begin
    if(rst == 1'b0) begin
      digit <= 4'b0000; //reset to 0
      incrementUP <= 1'b0; end  
    else begin
      if(reconfig == 1'b1) begin //reconfig
        digit<= 4'b0000;
        incrementUP <= 1'b0; end
		else if(enable == 1'b1) begin
		  if (increment == 1'b1) begin //if increment
		    if(digit == 4'b1001) begin //if 9
				 incrementUP <= 1'b1; //send incrementUP
				 digit <= 4'b0000; end //go 0
			  else begin //not 9 
				 digit <= digit + 4'b0001;
				 incrementUP <= 1'b0; end 
		  end
		  else begin //not increment
			  incrementUP <= 1'b0; end //end this pulse
	   end//if(enable == 1'b1)
    end //else
  end //always
endmodule
