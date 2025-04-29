
module seqGen (
    clk, rst, b_seq, seq, display, new_seq
);
input clk,rst,b_seq;
output display, new_seq;
output [19:0] seq;
wire [19:0] rand_num;
randnum_LFSR myLFSR(clk,rand_num);
control_seq_gen myC(clk,rst,b_seq,rand_num,display,new_seq,seq);    
    
endmodule