// ECE 5440 10409
// Tyler Nguyen
// SubCreateFace Module
// Description

module SubCreateFace(newHighScore, died, timeout, timer_enable, eyes, mouth, showFace, clk, rst);
    input clk, rst;
    input newHighScore, died, timeout;
    output [6:0] eyes, mouth;
    output showFace, timer_enable;

    reg [6:0] eyes, mouth;
    reg showFace, timer_enable;

    reg [1:0] State;
    parameter NoFace = 0, HappyFace = 1, SadFace = 2, Timer = 3;
    
    always@(posedge clk)
      begin
          if (rst == 1'b0) begin
              timer_enable <= 1'b0;
              showFace <= 1'b0;
              eyes <= 7'b1111111;
              mouth <=7'b1111111;
              State <= NoFace;
           end
          else begin // Normal Operation
              case(State)
                  NoFace: begin
                      timer_enable <= 1'b0;
                      showFace <= 1'b0;
                      eyes <= 7'b1111111;
                      mouth <=7'b1111111;
                      if (newHighScore == 1'b1) begin
                          State <= HappyFace;
                       end
                      else if (died == 1'b1) begin
                          State <= SadFace;
                       end
                      else begin
                          State <= NoFace;
                       end
                   end
                  HappyFace: begin
                      showFace <= 1'b1;
                      eyes <= 7'b1110110;
                      mouth <=7'b1110000;
                      State <= Timer;
                   end
                  SadFace: begin
                      showFace <= 1'b1;
                      eyes <= 7'b1110110;
                      mouth <=7'b1000110;
                      State <= Timer;
                   end
                  Timer: begin
                      timer_enable <= 1'b1;
                      if (timeout == 1'b1) begin
                          State <= NoFace;
                       end
                      else begin
                          State <= Timer;
                       end
                   end
                  default: begin
                      State <= NoFace;
                   end
              endcase
           end
      end   
endmodule
