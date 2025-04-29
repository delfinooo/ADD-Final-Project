//ECE5440 Course Number: 10409
//Author: Delfino Tzul, 6627
//SevenSegDecoder
//This module is a decoder for the Seven Segment Display on the FPGA board.
//An input of 4 bits is recieved and an output of 7 bits is provided. 
//To turn on a segment, a 0 must be sent to it. To turn it off a 1 is sent.

//Each bit in "Segments" corresponds to a segment on the Seven Segment Display

module SevenSegDecoder(NumberToDisplay, Segments);

  input [3:0] NumberToDisplay;
  output [6:0] Segments; 
  reg [6:0] Segments;

  always @ (NumberToDisplay)
    begin
      case(NumberToDisplay)
        4'b0000:begin Segments = 7'b1000000;end         
        4'b0001:begin Segments = 7'b1111001;end
        4'b0010:begin Segments = 7'b0100100;end 
        4'b0011:begin Segments = 7'b0110000;end  
        4'b0100:begin Segments = 7'b0011001;end   
        4'b0101:begin Segments = 7'b0010010;end   
        4'b0110:begin Segments = 7'b0000010;end  
        4'b0111:begin Segments = 7'b1111000;end  
        4'b1000:begin Segments = 7'b0000000;end
        4'b1001:begin Segments = 7'b0011000;end  
        4'b1010:begin Segments = 7'b0001000;end //uppercase A
        4'b1011:begin Segments = 7'b0000011;end //lowercase b
        4'b1100:begin Segments = 7'b1000110;end //uppercase C
        4'b1101:begin Segments = 7'b0100001;end //lowercase d
        4'b1110:begin Segments = 7'b0000110;end //uppercase E
        4'b1111:begin Segments = 7'b0001110;end //uppercase F
	     default:begin Segments = 7'b1111111;end

      endcase     

    end


endmodule
