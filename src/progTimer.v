module progTimer (
    clk,rst, enable, curLvl, timeout
);
    input clk,rst, enable;
    input [2:0] curLvl;
    output timeout;

    wire one, two;
    LFSR_1msTimer A(enable,clk,rst,one); //generates 1ms
    count_to_100 B(clk,rst,enable,one,two); //generates .1s
    count_to_X C(clk,rst,curLvl, enable, two, timeout); //gens curLvl based timeout
endmodule
