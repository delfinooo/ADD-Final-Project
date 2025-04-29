
//ECE 5440
//Tarek Bakeer 0491
//sequenceCheck
//Verifies if player input matches a stored sequence based on level.

module sequenceCheck
    (player_num,
     b_player, clk, rst,
     S_in, RAM_addr, RAM_r, correct, LVL, display_done, incorrect);

    input b_player, clk, rst, display_done;
    input [19 : 0] S_in;
    input [3 : 0] player_num;
    input [2 : 0] LVL;

    output correct, RAM_r, incorrect;
    output [4 : 0] RAM_addr;

    // State parameters
    parameter DD = 0, button = 1,
              storevals = 2, fetch = 3,
              cycle1 = 4, cycle2 = 5,
              catch = 6, compare = 7, verify = 8, success = 9, hold = 10, winner = 11, lost = 12;


    reg sofarsogood, correct, RAM_r, incorrect;

    reg [3 : 0] State;
    reg [4 : 0] RAM_addr;
    reg [2 : 0] count;
    reg [19 : 0] p_in;
    reg [19 : 0] seq_in;


    always @(posedge clk)
    begin
        if (rst == 1'b0)
        begin
            sofarsogood <= 1'b1;
            correct <= 1'b0;
            incorrect <= 1'b0;
            RAM_r <= 1'b0;
            count <= 3'b000;
            RAM_addr <= 5'b00000;
            p_in <= 20'd0;
            State <= DD;
        end
        else
        begin

            case (State)

            DD: begin
                if (display_done == 1'b1)
                begin
                    count <= 0;
                    State <= fetch;
                end
            end

            fetch: begin
                RAM_addr <= 5'b00000;
                RAM_r <= 1;
                State <= cycle1;
            end

            cycle1: begin
                RAM_r <= 0;
                State <= cycle2;
            end

            cycle2: begin
                State <= catch;
            end
            catch: begin
            seq_in <= S_in;
                State <= button;
            end

            button: begin
                if (b_player == 1'b1)
                begin
                count <= count + 1;

                    State <= storevals;
                end
            end

            storevals: begin

                if (count == 1)
                begin
                    p_in[19 : 16] <= player_num;
                end
                else if (count == 2)
                begin
                    p_in[15 : 12] <= player_num;
                end
                else if (count == 3)
                begin
                    p_in[11 : 8] <= player_num;
                end
                else if (count == 4)
                begin
                    p_in[7 : 4] <= player_num;
                end
                else if (count == 5)
                begin
                    p_in[3 : 0] <= player_num;
                end


                if (count == LVL)
                begin
                    State <= compare;
                end

                else
                begin
                    State <= button;
                end
            end

            compare: begin

                if (LVL == 3'd1)
                begin
                    if (p_in[19 : 16] != seq_in[19 : 16])
                        sofarsogood <= 1'b0;
                end
                else if (LVL == 3'd2)
                begin
                    if (p_in[19 : 12] != seq_in[19 : 12])
                        sofarsogood <= 1'b0;
                end
                else if (LVL == 3'd3)
                begin
                    if (p_in[19 : 8] != seq_in[19 : 8])
                        sofarsogood <= 1'b0;
                end
                else if (LVL == 3'd4)
                begin
                    if (p_in[19 : 4] != seq_in[19 : 4])
                        sofarsogood <= 1'b0;
                end
                else if (LVL == 3'd5)
                begin
                    if (p_in[19 : 0] != seq_in[19 : 0])
                        sofarsogood <= 1'b0;
                end

                State <= verify; // move to verify after checking
            end

            verify: begin
                if (sofarsogood == 1)
                begin
                    State <= success;
                end
                else

                    State <= lost;
            end

            success: begin
                correct <= 1;
                State <= hold;
            end

            hold: begin
                correct <= 0;
                incorrect <= 0;

                if (LVL != count)
                begin
                    State <= DD;
                end
                else if (LVL == 3'b101)
                begin
                    State <= DD;
                end
                else
                begin
                    State <= hold;
                end
            end

            
            lost: begin
                incorrect <= 1;
                State <= DD;
            end

            default: begin
                sofarsogood <= 1'b1;
                correct <= 1'b0;
                incorrect <= 1'b0;
                RAM_r <= 1'b0;
                count <= 3'b000;
                RAM_addr <= 5'b00000;
                p_in <= 20'd0;
                State <= DD;
            end
            endcase
        end
    end
endmodule
