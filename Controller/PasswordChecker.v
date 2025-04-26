
//ECE 5440
//Delfino Tzul, 6627
//PasswordChecker
//The PasswordChecker module is in charge of handling the password enter process.
//The module will read in each digit of the password the player inputs and then checks the ROM_PSWD to see if their password matches
//the password of the id that the player logged in with.
//The player has 3 attempts to input the correct password before they are are logged out and must reenter their id again.

module PasswordChecker(passwordDigit, b_password, matchedID, isGuestIN, ROM_data, internalPlayerIDIN, logoutOUT, logoutIN, clk, rst, loggedin, loggedout, passed, ROM_addr, internalPlayerIDOUT, isGuestOUT);
  input clk, rst, b_password, matchedID, logoutIN;
  input [3:0] passwordDigit;
  input isGuestIN;
  input [2:0] internalPlayerIDIN;
  input [23:0] ROM_data;
  output loggedin, loggedout, passed, logoutOUT;
  output [4:0] ROM_addr;
  output [2:0] internalPlayerIDOUT;
  output isGuestOUT;
  reg loggedin, loggedout, passed, logoutOUT;
  reg [4:0] ROM_addr;
  reg [2:0] internalPlayerIDOUT;
  reg isGuestOUT;
  

  //Internal Signals
  reg [23:0] userPass;
  reg [3:0] State;
  reg [23:0] ROM_pass;
  reg [1:0] counter;
  reg [2:0] playerID;
  parameter INACTIVE=0, Digit1=1, Digit2=2, Digit3=3, Digit4=4, Digit5=5, Digit6=6, FetchROM=7, ROMCYC1=8, ROMCYC2=9, ROMCATCH=10, COMPARE=11, WAIT=12, PASSED=13;

  always @(posedge clk) begin
    if(rst == 1'b0) begin
      userPass <= 24'd0;
      State <= INACTIVE;
      internalPlayerIDOUT <= 3'd0; playerID <= 3'd0;
      counter <= 2'd0;
      passed <= 1'b0;
      loggedout <= 1'b1; logoutOUT <= 1'b0;
      loggedin <= 1'b0;
      isGuestOUT <= 1'b0;
      ROM_addr <= 5'd0; end
    else begin
      case(State)
        INACTIVE: begin
	  userPass <= 24'd0; counter <= 2'd0; passed <= 1'b0;
          loggedout <= 1'b1;
          loggedin <= 1'b0;
	  if(matchedID == 1'b1) begin
	    State <= Digit1; end
          else
	    State <= INACTIVE;
        end
        Digit1: begin
	  playerID <= internalPlayerIDIN;
	  if(b_password == 1'b1) begin
	    userPass[23:20] <= passwordDigit;
	    State <= Digit2; end
	  else
	    State <= Digit1;
        end
        Digit2: begin
	  if(b_password == 1'b1) begin
	    userPass[19:16] <= passwordDigit;
	    State <= Digit3; end
	  else
	    State <= Digit2;
        end
        Digit3: begin
	  if(b_password == 1'b1) begin
	    userPass[15:12] <= passwordDigit;
	    State <= Digit4; end
	  else
	    State <= Digit3;
        end
        Digit4: begin
	  if(b_password == 1'b1) begin
	    userPass[11:8] <= passwordDigit;
	    State <= Digit5; end
	  else
	    State <= Digit4;
        end
        Digit5: begin
	  if(b_password == 1'b1) begin
	    userPass[7:4] <= passwordDigit;
	    State <= Digit6; end
	  else
	    State <= Digit5;
        end
        Digit6: begin
	  if(b_password == 1'b1) begin
	    userPass[3:0] <= passwordDigit;
	    State <= FetchROM; end
	  else
	    State <= Digit6;
        end
        FetchROM: begin
          ROM_addr <= 5'd0 + playerID; //use internal player ID as the address to the ROM
          State <= ROMCYC1;
        end
        ROMCYC1: begin
          State <= ROMCYC2;
        end
        ROMCYC2: begin
          State <= ROMCATCH;
        end
        ROMCATCH: begin
          ROM_pass <= ROM_data;
          State <= COMPARE;
        end   
	COMPARE: begin
	  if(ROM_pass == userPass)
	    State <= PASSED;
          else begin
	    if(counter == 2'd2) begin //if 3 tries have been done
	      logoutOUT <= 1'b1;
	      counter <= 2'd0; //reset to be used in next state
              State <= WAIT; end //kick out the user
	    else begin  //if 3 tries have not been done
	      counter <= counter + 2'd1;
	      State <= Digit1; end  //let them try again
          end
        end  
	WAIT: begin
	  logoutOUT <= 1'b0; //end this pulse
	  if(counter == 2'd2) //delay for 3 clock cycles
	    State <= Digit1;
          else begin
	    counter <= counter + 2'd1;
	    State <= WAIT; end
	end
	PASSED: begin
	  loggedin <= 1'b1; loggedout <= 1'b0;
	  passed <= 1'b1;	
	  isGuestOUT <= isGuestIN;
	  internalPlayerIDOUT <= internalPlayerIDIN;
	  if(logoutIN == 1'b1) begin
	    logoutOUT <= 1'b1;
	    counter <= 2'd0; //reset to be used in next state
	    State <= WAIT; end
	  else
	    State <= PASSED;
	end
	default: begin
          userPass <= 24'd0;
          State <= INACTIVE;
          internalPlayerIDOUT <= 3'd0; playerID <= 3'd0;
          counter <= 2'd0;
          passed <= 1'b0;
          loggedout <= 1'b1; logoutOUT <= 1'b0;
          loggedin <= 1'b0;
          isGuestOUT <= 1'b0;
          ROM_addr <= 5'd0;	  
	end
      endcase
    end
  end

endmodule