module count_to_X (
    clk,rst, curLevel,enable, in, timeout
);
input clk, rst, in,enable;
input [2:0] curLevel;
output timeout;
reg timeout;
reg [3:0] count,countMax;

always @(*) begin
    case(curLevel)
    3'd1: countMax = 13;
    3'd2: countMax = 10; 
    3'd3: countMax = 8;
    3'd4: countMax = 5;
    3'd5: countMax = 3;
    default: countMax = 13;
    endcase
end
always @(posedge clk)begin
    if(rst ==1'b0)begin
        count <= 0;
        timeout <=0;
    end
    else if(enable == 1)begin
        if(in == 1'b1)begin
            if(count == countMax )begin 
                timeout <=1;
                count <= 0;
            end else begin
                timeout <= 0;
                count <= count +1;
            end
        end else
            timeout <=0;
    end
end  
endmodule
