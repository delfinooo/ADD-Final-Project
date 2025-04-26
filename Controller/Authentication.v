//ECE 5440
//Delfino Tzul, 6627
//Authentication
//The Authentication module controls the entire login process and handles logout requests.
//The module achieves this functionality through instances of the IDChecker and PasswordChecker modules.
//These modules are used to check a player's id and password when logging in.

module Authentication(ID_pass_Digit, B_id_pass, clk, rst, passed, logout, loggedin, loggedout, isGuest, internalPlayerID);
  input clk, rst, B_id_pass, logout;
  input [3:0] ID_pass_Digit;
  output [2:0] internalPlayerID;
  output isGuest, passed, loggedin, loggedout;

  //internal signals
  wire matchedID, isGuestIN, logoutIN;
  wire [2:0] internalPlayerIDIN;
  wire [4:0] ROM_ID_addr;
  wire [15:0] ROM_ID_data;
  wire [4:0] ROM_PSWD_addr;
  wire [23:0] ROM_pass_data;


  //instantiation of the ID Checker and ROM holding ID values
  ROM_ID ID_ROM(ROM_ID_addr, clk, ROM_ID_data);
  IDChecker ID_Checker(ID_pass_Digit, B_id_pass, logout, ROM_ID_data, clk, rst, matchedID, ROM_ID_addr, internalPlayerIDIN, isGuestIN);

  //instantiation Password checker and ROM holding password values
  ROM_PSWD PSWD_ROM(ROM_PSWD_addr, clk, ROM_pass_data);
  PasswordChecker Pass_Checker(ID_pass_Digit, B_id_pass, matchedID, isGuestIN, ROM_pass_data, internalPlayerIDIN, logoutIN, logout, clk, rst, loggedin, loggedout, passed, ROM_PSWD_addr, internalPlayerID, isGuest);


endmodule
