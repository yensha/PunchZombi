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

    // Instantiate the DUT (Device Under Test)
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
        forever #4 clk = ~clk; // 125 MHz clock period (8 ns)
    end
    integer i, j;
    // Testbench logic
    initial begin
        
        
        // Initialize inputs
        rst = 1;
        btn1in = 0;
        btn2in = 0;
        btn3in = 0;

        // Reset pulse
        #20;
        rst = 0;

        // Wait for 7 clock cycles (56 ns)
        repeat (7) @(posedge clk);
        
        // Wait for 30 seconds of simulation time using nested for loops
        for (i = 0; i < 125000000; i = i + 1) begin
            #8; // 8 ns per iteration
        end

        // Provide signals to btn1in, btn2in, and btn3in
        #100;
        btn1in = 1;
        #10;
        btn1in = 0;

        #200;
        btn2in = 1;
        #10;
        btn2in = 0;

        #300;
        btn3in = 1;
        #10;
        btn3in = 0;

        // Wait for 30 seconds of simulation time using nested for loops
        for (i = 0; i < 125000000; i = i + 1) begin
            for (j = 0; j < 30; j = j + 1) begin 
                #8; // 8 ns per iteration
            end
        end

        // End simulation
        $stop;
    end

    // Optional: monitor signals
    initial begin
        $monitor("Time=%0t, rst=%b, btn1in=%b, btn2in=%b, btn3in=%b, led=%b, A=%b, B=%b, C=%b, D=%b, R0=%b, G0=%b, B0=%b, R1=%b, G1=%b, B1=%b, OE=%b, LAT=%b, clk_shft=%b, clk_game_shft=%b", 
                  $time, rst, btn1in, btn2in, btn3in, led, A, B, C, D, R0, G0, B0, R1, G1, B1, OE, LAT, clk_shft, clk_game_shft);
    end

endmodule
