//ECE 5440
//Delfino Tzul, 6627
//ButtonShaper
//The ButtonShaper module is designed to deliver out a single pulse when the button on the FPGA board is pressed.
//When the button is pressed, the button signal is 0. When the button is not pressed, the button signal is 1.
//Many clock cycles can occur while the button is pressed, this module ensures only a single pulse is sent
//regardless of how long the button is held. This prevents multiple pulses from being sent from a single push.

module ButtonShaper(button_in, pulse_out, clk, rst);
  input button_in;
  output pulse_out;
  input clk, rst;
  reg pulse_out;
  parameter INIT=0, PULSE=1, WAIT=2;
  reg [1:0] State, StateNext;

  //Comblogic
  always @ (State, button_in) begin
    case(State)
      INIT: begin
        pulse_out = 1'b0;
        if( button_in == 1'b0) begin //0 when pressed
          StateNext = PULSE; end
        else begin
          StateNext = INIT; end
      end
      PULSE: begin
        pulse_out = 1'b1;
        StateNext = WAIT;
      end
      WAIT: begin
        pulse_out = 1'b0;
        if( button_in == 1'b1) begin
          StateNext = INIT; end
        else begin
          StateNext = WAIT; end
      end
      default: begin
        pulse_out = 1'b0;
        StateNext = INIT;
      end
    endcase
  end

  //StateReg
  always @ (posedge clk) begin
    if(rst == 1'b0) begin //active low
      State <= INIT; end
    else begin
      State <= StateNext; end
    end

endmodule
