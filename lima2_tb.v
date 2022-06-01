// AURELIUS JUSTIN YUSO LIM S11
`timescale 1ns / 1ps
module lima2_tb();
    reg[7:0] t_X, t_Y;
    reg t_C0;

    wire[7:0] t_S;
    wire t_C8;
    lima2 dut(t_S, t_C8, t_X, t_Y, t_C0);
    
    initial 
        begin
        t_X = 8'b01100000;
        t_Y = 8'b01111111;
        t_C0 = 1'b0;

        #10
        t_X = 8'b11111111;
        t_Y = 8'b11111110;

        #10
        t_X = 8'b10101010;
        t_Y = 8'b01010101;

        #10
        t_X = 8'b00001000;
        t_Y = 8'b10000001;

        #10
        t_X = 8'b00001000;
        t_Y = 8'b10000001;
        t_C0 = 1'b1;

        #10
        t_X = 8'b00000001;
        t_Y = 8'b00000000;

        #10
        t_X = 8'b11110000;
        t_Y = 8'b10001000;
        end

    initial

    begin
        $display("Written by Aurelius Justin Lim");
        $display("Circuit: 3-bit ripple carry_ 2-bit carry lookahead_3-bit ripple carry");
        $monitor("time - %0d X = %b Y = %b C0 - %b output_S = %b output_C8 = %b", $time, t_X, t_Y, t_C0, t_S, t_C8);
        $dumpfile("lima2.vcd");
        $dumpvars();
    end
endmodule