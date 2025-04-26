//ECE 5440
//Delfino Tzul, 6627
//LFSR_1msTimer
//This module will output a single pulse every 1 millisecond. This time is based on a 50 MHz clock rate.
//The pulse is calculated to occur every 50,000 cycles. 49,999 cycles are used instead due to the
//0 state of the timer variable (when it is equal to 0).
//An enable is needed for this module to work.
//This module utilizes an LFSR and replaces the previous "counter" version.
module LFSR_1msTimer(enable, clk, rst, oneMsTimeout);
  input clk, enable, rst;
  output oneMsTimeout;
  reg oneMsTimeout;
  reg [15:0] LFSR;
  wire feedback = LFSR[15];

  always @(posedge clk) begin
    if(rst == 1'b0) begin
      LFSR <= 16'd65535;
      oneMsTimeout <= 1'b0;
    end
    else begin
      if(enable == 1'b1) begin
        if(LFSR == 16'd28086) begin //(28086) value of LFSR @ the 49,999 cycle 
          oneMsTimeout <= 1'b1; //note 50,000th cycle occurs at value (56172) but this will be overwritten
          LFSR <= 16'd65535;
        end
        else begin
          oneMsTimeout <= 1'b0;
          LFSR[0] <= feedback;
          LFSR[1] <= LFSR[0];
          LFSR[2] <= LFSR[1] ^ feedback;
          LFSR[3] <= LFSR[2] ^ feedback;
          LFSR[4] <= LFSR[3];
          LFSR[5] <= LFSR[4] ^ feedback;
          LFSR[6] <= LFSR[5];
          LFSR[7] <= LFSR[6];
          LFSR[8] <= LFSR[7];
          LFSR[9] <= LFSR[8];
          LFSR[10] <= LFSR[9];
          LFSR[11] <= LFSR[10];
          LFSR[12] <= LFSR[11];
          LFSR[13] <= LFSR[12];
          LFSR[14] <= LFSR[13];
          LFSR[15] <= LFSR[14];
        end
      end
    end
  end
endmodule

