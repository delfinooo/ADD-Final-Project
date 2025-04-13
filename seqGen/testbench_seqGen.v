`timescale 1ns/100ps
module testbench_seqGen();
reg clk,rst,b_seq;
wire [19:0] sequence;
wire display, new_seq;
// Clock generation
    always 
    begin
        clk = 1'b0;
        #10;
        clk = 1'b1;
        #10;
    end
seqGen myseqGen(clk,rst, b_seq, sequence,display,new_seq);

initial begin
    rst = 1;
    b_seq = 0;

    #20;
    rst = 0;
    @(posedge clk);
    rst = 1;
    @(posedge clk);

    @(posedge clk);
    b_seq = 1;
    @(posedge clk);
    b_seq =0;
end
endmodule