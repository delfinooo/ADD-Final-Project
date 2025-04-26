//ECE 5440
//Delfino Tzul, 6627
//DigitTimer
//The DigitTimer module serves to represent a single digit with the capability of borrowing and providing borrows to other digits.
//The module holds a max digit of 9 and will provide borrows/decrement until it is 0. Once it is 0, it will request for a borrow from a higher
//digit. If none is provided, it will stay 0 and not provide any borrows to lower digits.
//The module is capable of reconfiguring back to 9 if necessary.

module DigitTimer(reconfig, borrowDN, noborrowUP, clk, rst, borrowUP, noborrowDN, digit);
  input reconfig, borrowDN, noborrowUP, clk, rst;
  output borrowUP, noborrowDN;
  output [3:0] digit;
  reg borrowUP, noborrowDN;
  reg [3:0] digit;
  always @ (posedge clk) begin
    if(rst == 1'b0) begin
      digit <= 4'b0000; //reset to 0
      noborrowDN <= 1'b1; //can not provide
      borrowUP <= 1'b1; end  //need to borrow
    else begin
      if(reconfig == 1'b1) begin
        digit<= 4'b1001;
        noborrowDN <= 1'b0;
        borrowUP <= 1'b0; end
		else if (borrowDN == 1'b1) begin //if request from other digit
		  if(digit == 4'b0000) begin //if 0
		    borrowUP <= 1'b1; //ask to borrow
          if(noborrowUP == 1'b0) begin //can borrow
			   digit <= 4'b1001;
				noborrowDN <= 1'b0;	
			 end
			 else begin //can not borrow
			   digit <= 4'b0000;
				noborrowDN <= 1'b1; //can not provide -> timeout
			 end
		  end	//if(digit == 4'b0000)
		  else begin //if digit is not 0
		    borrowUP <= 1'b0;  //not borrowing
		    digit <= digit - 4'b0001;
		    noborrowDN <= 1'b0; end	 
		end
		else if ((digit == 4'b0000) && (noborrowUP == 1'b1) ) begin //if no request, and digit is 0 and can not borrow
		  borrowUP <= 1'b0; //end this pulse
		  noborrowDN <= 1'b1; end
		else begin //none of the above
		  borrowUP <= 1'b0; end //end this pulse
    end //else
  end //always
endmodule
