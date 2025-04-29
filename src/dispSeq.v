module dispSeq (
    clk,rst, curLvl, display, seq,
    seqDigit, displayDone, showSeq
);
input clk,rst, display;
input [2:0] curLvl;
input [19:0] seq;
output displayDone, showSeq;
output [3:0] seqDigit;
wire control_to_timer_enable,timeout;
progTimer myTimer(clk,rst,control_to_timer_enable,curLvl,timeout);
control_display_seq myDS(clk,rst,display,curLvl,seq,timeout,
seqDigit,displayDone,showSeq,control_to_timer_enable);
    
endmodule