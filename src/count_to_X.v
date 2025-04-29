//ECE 5440
//Thomas Vo 2179861
//Counter to dynamic value based on current level

module count_to_X (
    clk,rst, curLevel, enable, in, timeout
);
input clk, rst, in, enable;
input [2:0] curLevel;
output timeout;
reg timeout;
reg [3:0] count, countMax; // 4-bit registers for counting and maximum value

// Determine the maximum count based on the current level
always @(*) begin
    case(curLevel)
        3'd1: countMax = 13; // Level 1: count to 13
        3'd2: countMax = 10; // Level 2: count to 10
        3'd3: countMax = 8;  // Level 3: count to 8
        3'd4: countMax = 5;  // Level 4: count to 5
        3'd5: countMax = 3;  // Level 5: count to 3
        default: countMax = 13; // Default maximum count
    endcase
end

always @(posedge clk) begin
    if (rst == 1'b0) begin
        // Reset counter and timeout
        count <= 0;
        timeout <= 0;
    end
    else if (enable == 1) begin
        // Only count when enabled
        if (in == 1'b1) begin
            if (count == countMax) begin
                timeout <= 1;    // Raise timeout when max count reached
                count <= 0;      // Reset count after reaching max
            end else begin
                timeout <= 0;    // Keep timeout low while counting
                count <= count + 1; // Increment counter
            end
        end else begin
            timeout <= 0;        // Keep timeout low if input 'in' is not high
        end
    end
end  

endmodule
