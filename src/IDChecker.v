
//ECE 5440
//Delfino Tzul, 6627
//IDChecker
//The IDChecker module is in charge of handling the user ID enter process.
//The module will read in each digit of the ID the player inputs and then checks the ROM_ID to see if the id exists.
//Once the player is logged in, an internalPlayerID signal is passed along to represent the player.

module IDChecker(idDigit, b_id, logout, ROM_data, clk, rst, matchedID, ROM_addr, internalPlayerID, isGuest);

  input [3:0] idDigit;
  input b_id, logout, clk, rst;
  input [15:0] ROM_data;
  output matchedID;
  output [4:0] ROM_addr;
  output [2:0] internalPlayerID;
  output isGuest;
  reg matchedID;
  reg [4:0] ROM_addr;
  reg [2:0] internalPlayerID;
  reg isGuest;

  //Internal signals
  reg [15:0] uid;
  reg [15:0] ROM_id;
  reg [3:0] State;
  reg [2:0] counter;

  parameter Digit1=0, Digit2=1, Digit3=2, Digit4=3, FetchROM=4, ROMCYC1=5, ROMCYC2=6, ROMCATCH=7, COMPARE=8, CHECKSTATUS=9, CHECKGUEST=10, PASSED=11;

  always @(posedge clk) begin
    if(rst == 1'b0) begin
      uid <= 16'd0;
      State <= Digit1;
      matchedID <= 1'b0;
      internalPlayerID <= 3'd0;
      counter <= 3'd0;
      isGuest <= 1'b0;
      ROM_addr <= 5'd0; end
    else begin
      case(State)
        Digit1: begin
	  if(b_id == 1'b1) begin
	    uid[15:12] <= idDigit;
	    State <= Digit2; end
	  else
	    State <= Digit1;
        end
        Digit2: begin
	  if(b_id == 1'b1) begin
	    uid[11:8] <= idDigit;
	    State <= Digit3; end
	  else
	    State <= Digit2;
	end
	Digit3: begin
	  if(b_id == 1'b1) begin
	    uid[7:4] <= idDigit;
	    State <= Digit4; end
	  else
	    State <= Digit3;
	end
	Digit4: begin
	  if(b_id == 1'b1) begin
	    uid[3:0] <= idDigit;
	    State <= FetchROM; end
	  else
	    State <= Digit4;
	end
	FetchROM: begin
	  ROM_addr <= 5'd0 + counter;
          State <= ROMCYC1;
        end
        ROMCYC1: begin
          State <= ROMCYC2;
        end
        ROMCYC2: begin
          State <= ROMCATCH;
        end
        ROMCATCH: begin
          ROM_id <= ROM_data;
          State <= COMPARE;
        end
	COMPARE: begin
	  if(ROM_id == uid)
	    State <= CHECKGUEST;
	  else
	    State <= CHECKSTATUS;
	end
	CHECKSTATUS: begin
	  if(ROM_id == 16'hFFFF) begin //reached the end of the useful entries in the ROM
	    matchedID <= 1'b0;
	    counter <= 3'd0; //reset counter for next attempt
	    State <= Digit1; end
	  else begin
	    counter <= counter + 3'd1; //increment counter
	    State <= FetchROM; end //fetch the next id in the ROM
        end
	CHECKGUEST: begin
	  if(ROM_id == 16'h1111)
	    isGuest <= 1'b1;
          else
	    isGuest <= 1'b0;
          matchedID <= 1'b1; //either case set matchedID high
          State <= PASSED;
	end
	PASSED: begin
	  matchedID <= 1'b1;
	  internalPlayerID <= counter; //counter functions as the internal player id
	  if(logout == 1'b1) begin
	    isGuest <= 1'b0;
	    matchedID <= 1'b0;
	    counter <= 3'd0; //reset counter for new attempt
	    State <= Digit1; end
	  else 
	    State <= PASSED;
	end
	default: begin
          uid <= 16'd0;
          State <= Digit1;
          matchedID <= 1'b0;
          internalPlayerID <= 3'd0;
          counter <= 3'd0;
          isGuest <= 1'b0;
          ROM_addr <= 1'b0;
	end
      endcase
    end
  end
endmodule

