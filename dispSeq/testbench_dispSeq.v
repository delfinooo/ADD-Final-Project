`timescale 1ns/100ps

module testbench_dispSeq();
    reg clk, rst, display;
    reg [2:0] curLvl;
    reg [19:0] seq;
    wire [3:0] seqDigit;
    wire displayDone;
    wire enable_to_timer;

    reg timeout;

    // Instantiate just the control_display_seq
    control_display_seq DUT (
        .clk(clk),
        .rst(rst),
        .display(display),
        .curLvl(curLvl),
        .seq(seq),
        .timer(timeout),
        .seqDigit(seqDigit),
        .displayDone(displayDone),
        .enable_to_timer(enable_to_timer)
    );

    // Clock generation (50 MHz => 20ns period)
    always begin
        clk = 0;
        #10;
        clk = 1;
        #10;
    end

    // Manual timeout generator — faster if curLvl is higher
    integer timeout_counter = 0;
    integer delay;
    always @(posedge clk) begin
        if (!rst || !enable_to_timer) begin
            timeout <= 0;
            timeout_counter <= 0;
        end else begin
            // Calculate delay: curLvl 1 → slow, 5 → fast
            case (curLvl)
                3'd1: delay = 50;
                3'd2: delay = 40;
                3'd3: delay = 30;
                3'd4: delay = 20;
                3'd5: delay = 10;
                default: delay = 50;
            endcase

            if (timeout_counter >= delay) begin
                timeout <= 1;
                timeout_counter <= 0;
            end else begin
                timeout <= 0;
                timeout_counter <= timeout_counter + 1;
            end
        end
    end

    // Test sequence
    initial begin
        rst = 1;
        display = 0;
        curLvl = 5;
        seq = 20'h79BCC;
        timeout = 0;

        #20;
        rst = 0;
        @(posedge clk);
        rst = 1;

        // Wait a couple of clocks
        repeat(3) @(posedge clk);

        // Trigger display
        display = 1;
        @(posedge clk);
        display = 0;

        // Let the system run and display digits
        repeat(500) @(posedge clk);

        $finish;
    end

    // Optional live trace
    initial begin
        $monitor("T=%0t | state=%0d | seqDigit=%0h | timeout=%b | displayDone=%b", 
            $time, DUT.state, seqDigit, timeout, displayDone);
    end
endmodule
