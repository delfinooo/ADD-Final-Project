
module SeqVerify(display_done, LVL, b_player, newSequence, Sequence, player_num, clk, rst, correct, incorrect);
  input display_done, b_player, newSequence, clk, rst;
  input [2:0] LVL;
  input [19:0] Sequence;
  input [3:0] player_num;
  output correct, incorrect;

  //internal signals
  wire [19:0] S_out, S_in;
  wire [4:0] RAM_addr_S, RAM_addr_C, RAM_addr;
  
  //RAM_addr will always be 5'd0
  assign RAM_addr = RAM_addr_S; //prevents connecting 2 outputs together
  

  //instantiation of the sequenceCheck module
  sequenceCheck seqCheck(player_num,
     b_player, clk, rst,
     S_in, RAM_addr_C, RAM_r, correct, LVL, display_done, incorrect);

  //instantiation of the SequenceStore module
  SequenceStore SeqStore(newSequence, Sequence, S_out, RAM_addr_S, RAM_W, clk, rst);

  //instantion of the RAM (RAM_Seq)
  RAM_Seq RAM_Seq1(RAM_addr, clk, S_out, RAM_r, RAM_W, S_in);

endmodule
