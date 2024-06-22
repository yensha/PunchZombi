`timescale 1ns/1ps

module LED_top_tb;

    reg clk;
    reg rst;
    reg btn1in;
    reg btn2in;
    reg btn3in;
    wire A;
    wire B;
    wire C;
    wire D;
    wire R0;
    wire G0;
    wire B0;
    wire R1;
    wire G1;
    wire B1;
    wire OE;
    wire LAT;
    wire clk_shft;
    wire clk_game_shft;
    wire [2:0] led;

    // Instantiate the LED_top module
    LED_top uut (
        .clk(clk),
        .rst(rst),
        .btn1in(btn1in),
        .btn2in(btn2in),
        .btn3in(btn3in),
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .R0(R0),
        .G0(G0),
        .B0(B0),
        .R1(R1),
        .G1(G1),
        .B1(B1),
        .OE(OE),
        .LAT(LAT),
        .clk_shft(clk_shft),
        .clk_game_shft(clk_game_shft),
        .led(led)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        btn1in = 0;
        btn2in = 0;
        btn3in = 0;

        // Reset sequence
        #20;
        rst = 0;

        // Apply button inputs and observe outputs
        #100;
        btn1in = 1;
        #10;
        btn1in = 0;

        #100;
        btn2in = 1;
        #10;
        btn2in = 0;

        #100;
        btn3in = 1;
        #10;
        btn3in = 0;

        // Add more test sequences as needed
        #1000;

        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0dns, rst = %b, btn1in = %b, btn2in = %b, btn3in = %b, A = %b, B = %b, C = %b, D = %b, R0 = %b, G0 = %b, B0 = %b, R1 = %b, G1 = %b, B1 = %b, OE = %b, LAT = %b, clk_shft = %b, clk_game_shft = %b, led = %b", 
                 $time, rst, btn1in, btn2in, btn3in, A, B, C, D, R0, G0, B0, R1, G1, B1, OE, LAT, clk_shft, clk_game_shft, led);
    end

endmodule
