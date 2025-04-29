module SequenceStore(newSequence, Sequence, S_out, RAM_addr, RAM_W, clk, rst);
    input newSequence, clk, rst;
    input[19:0] Sequence;
    output RAM_W;
    output [19:0] S_out;
    output[4:0] RAM_addr;
    reg[19:0] Sequence_in;
    reg RAM_W;
    reg [19:0] S_out;
    reg[4:0] RAM_addr;

    parameter INIT=1, Write=2;
    reg[1:0] State;

    always@(posedge clk) begin
      if(rst==1'b0) begin
        RAM_W <= 1'b0;
        S_out <= 20'd0;
        RAM_addr <= 5'd0;
        State <= INIT;
      end
      else begin
        case(State)
          INIT : begin
            RAM_W <= 1'b0;
            if(newSequence == 1'b1) begin
				  Sequence_in <= Sequence;
              State <= Write;
            end
            else begin
              State <= INIT;
            end
          end
          Write : begin
            RAM_W <= 1'b1;
            S_out <= Sequence_in;
            RAM_addr <= 5'd0;
            State <= INIT;
          end
          default : begin
            State <= INIT;
          end
        endcase
      end
    end
endmodule