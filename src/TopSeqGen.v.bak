
module TopSeqGen(curLvl, b_seq, clk, rst, seqDigit, displayDone, seq, new_seq);
  input [2:0] curLvl;
  input b_seq, clk, rst;
  output [3:0] seqDigit;
  output [19:0] seq;
  output displayDone, new_seq;
  
  //internal signals
  wire display;
  wire [19:0] seq_internal; 

  //instantiation of the seqGen module
  seqGen seqGen1(clk, rst, b_seq, seq_internal, display, new_seq);
  
  //instantiation of the dispSeq module
  dispSeq dispSeq1(clk, rst, curLvl, display, seq_internal, seqDigit, displayDone); 
  
  //assign statement
  assign seq = seq_internal;
  
endmodule