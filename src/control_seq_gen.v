module control_seq_gen (
    clk,rst, b_seq, in_rand_num,
    display, new_seq, seq
);
    input clk, rst, b_seq;
    input [19:0] in_rand_num;
    output reg display, new_seq;
    output reg [19:0] seq;
    reg [2:0] state;
    parameter init = 0, gen1 = 1, gen2 = 2;
    always @(posedge clk) begin
        if(rst == 0) begin
            display <= 0;
            new_seq <= 0;
            seq <= 20'd0;
            state <= init;
        end
        else begin
            case (state)
                init:begin
                    display <= 0;
                    new_seq <=0;
                    seq <= in_rand_num;
                    if(b_seq == 1)
                        state <= gen1;
                    else
                        state <= gen2;
                end 
                gen1: begin
                    display <=1;
                    new_seq <=1;
                    seq <= in_rand_num;
                    state <= gen2;
                end
                gen2:begin
                    display <=0;
                    new_seq <=0;
                    seq <= in_rand_num;
                    state <= init;
                end
                default: begin
                    display <= 0;
                    new_seq <=0;
                    seq <= in_rand_num;
                    state <= init;
                end
            endcase
        end
    end
endmodule