//ECE 5440
//Thomas Vo 2179861
//Counter to 100 with timeout signal

module count_to_100 (
    clk,rst, enable, in, timeout
);
input clk, rst, in, enable;
output timeout;
reg timeout;
reg [6:0] count; // 7-bit counter to count up to 99

always @(posedge clk) begin
    if (rst == 1'b0) begin
        // Reset counter and timeout signal
        count <= 0;
        timeout <= 0;
    end
    else if (enable == 1'b1) begin
        // Only count when enabled
        if (in == 1) begin
            if (count == 99) begin
                timeout <= 1;    // Raise timeout when count reaches 99
                count <= 0;      // Reset count after reaching 99
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
