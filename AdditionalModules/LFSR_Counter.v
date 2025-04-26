//ECE 5440
//Delfino Tzul, 6627
//LFSR_Counter
//The LFSR_Counter module utilizes a 4 bit LFSR to generate a random value. When the input signal, count, is high, the interal LFSR changes through
//the use of its feedback.
//The 4 bit output signal of this module is labeled q.
module LFSR_Counter(count, clk, rst, q);
  input count;
  input clk, rst;
  output [3:0] q;

  reg [3:0] LFSR;
  wire feedback = LFSR[3];

  always @(posedge clk)
  begin
	 if(rst == 1'b0) 
	   LFSR <= 4'd0; 
    else begin
		 if(count == 1'b1) begin
			 LFSR[0] <= feedback;
			 LFSR[1] <= LFSR[0] ~^ feedback;
			 LFSR[2] <= LFSR[1];
			 LFSR[3] <= LFSR[2];
		 end
    end
  end
  
  assign q = LFSR;

endmodule
