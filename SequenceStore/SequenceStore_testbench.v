`timescale 1 ns/100 ps
module SequenceStore_testbench ( );
    reg clk, rst, newSequence;
    reg [19:0] Sequence;
    wire [19:0] S_out;
    wire [4:0] RAM_addr;
    wire RAM_W;

    always
      begin
        clk = 1'b0;
        #10;
        clk = 1'b1;
        #10;
      end

    SequenceStore DUT_SequenceStore(newSequence, Sequence, S_out, RAM_addr, RAM_W, clk, rst);

    initial
      begin
        rst = 1'b1;
        newSequence = 1'b0;
        @(posedge clk);
        @(posedge clk);
        #5 rst = 1'b0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        #5 rst = 1'b1;
        @(posedge clk);
        @(posedge clk);
        #5 Sequence = 20'h58EA3;
        #5 newSequence = 1'b1;
        @(posedge clk);
        #5 newSequence = 1'b0;

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        #5 Sequence = 20'h74DBA;
      end
endmodule