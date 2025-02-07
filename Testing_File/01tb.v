`timescale 1ns / 1ps

module LED_top_tb;

    // Inputs
    reg clk;
    reg rst;
    reg btn1;
    reg btn2;
    reg btn3;

    // Outputs
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
    wire [3:1] led;

    // Instantiate the Unit Under Test (UUT)
    LED_top uut (
        .clk(clk),
        .rst(rst),
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
    always #5 clk = ~clk; // 100 MHz clock

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        btn1 = 0;
        btn2 = 0;
        btn3 = 0;

        // Wait 100 ns for global reset to finish
        #100;
        rst = 0;

        // Add stimulus here
        // Simulate button press and release
        #50 btn1 = 1;
        #20 btn1 = 0;
        
        #50 btn2 = 1;
        #20 btn2 = 0;
        
        #50 btn3 = 1;
        #20 btn3 = 0;
        
        // Add more test cases as needed
        #200;
        
        // Finish simulation
        $stop;
    end

endmodule
