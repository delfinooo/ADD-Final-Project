module progTimer (
    clk,rst, enable, curLvl, timeout
);
    input clk,rst, enable;
    input [2:0] curLvl;
    output timeout;

    wire one, two;
    timer_1ms_lfsr A(clk,rst,enable,one); //generates 1ms
    count_to_100 B(clk,rst,enable,one,two); //generates .1s
    count_to_X C(clk,rst,curLvl, enable, two, timeout); //gens curLvl based timeout
endmodule
