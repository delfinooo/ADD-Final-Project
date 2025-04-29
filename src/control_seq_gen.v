//ECE 5440
//Thomas Vo 2179861
//Control logic for generating and outputting a random 20-bit sequence

module control_seq_gen (
    clk, rst, b_seq, in_rand_num,
    display, new_seq, seq
);
input clk, rst, b_seq;
input [19:0] in_rand_num;
output reg display, new_seq;
output reg [19:0] seq;

reg [2:0] state;

// FSM states
parameter init = 0, gen1 = 1, gen2 = 2;

always @(posedge clk) begin
    if (rst == 0) begin
        // On reset: clear outputs and set initial state
        display <= 0;
        new_seq <= 0;
        seq <= 20'd0;
        state <= init;
    end
    else begin
        case (state)
            init: begin
                // Default idle state: wait for b_seq trigger
                display <= 0;
                new_seq <= 0;
                seq <= in_rand_num; // Capture input random number
                if (b_seq == 1)
                    state <= gen1;  // Go to sequence generation
                else
                    state <= init;  // Bypass to next cycle
            end

            gen1: begin
                // Pulse display and new_seq high for one cycle
                display <= 1;
                new_seq <= 1;
                seq <= in_rand_num; // Update sequence again
                state <= gen2;      // Move to next state
            end

            gen2: begin
                // Lower control signals, wait before resetting FSM
                display <= 0;
                new_seq <= 0;
                seq <= in_rand_num;
                state <= init;
            end

            default: begin
                // Default fallback: reset FSM safely
                display <= 0;
                new_seq <= 0;
                seq <= in_rand_num;
                state <= init;
            end
        endcase
    end
end

endmodule
