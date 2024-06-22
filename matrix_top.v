/*
LED_top
clk_div
clk_div_game
matrix
zombie
lfsr_random_v2
matrix_generate
*/
module LED_top (
    input clk,
    input rst,
    input btn1in,
    input btn2in,
    input btn3in,
    output A, 
    output B,
    output C,
    output D,
    output R0,
    output G0,
    output B0,
    output R1,
    output G1,
    output B1,
    output OE,
    output LAT,
    output clk_shft,
    output clk_game_shft,
    output [2:0] led
);

    wire clk_shift;
    assign clk_shft = clk_shift;

    clk_div clk_div_0(.clk(clk),
                .rst(rst),
                .clk_div(clk_shift)
                );
    clk_div_game clk_div_game0(
        .clk(clk),
        .rst(rst),
        .clk_div(clk_div_game_shift)
    );
    wire [3:0] row;
    wire [6:0] col;
    wire R0in, R1in, B0in, B1in, G0in, G1in;
    wire [159:0] R00in, R01in, R02in, R03in, R04in, R05in;
    wire [159:0] R10in, R11in, R12in, R13in, R14in, R15in;
    matrix m1(
    .clk(clk_shift),
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
    .R0in(R0in), //input
    .G0in(G0in),
    .B0in(B0in),
    .R1in(R1in),
    .G1in(G1in),
    .B1in(B1in),
    .col(col),
    .rows(row),
    .OE(OE),
    .LAT(LAT)
);
    wire clk_game_shift;
    assign clk_game_shft = clk_game_shift;
    wire Isgameover;
    Zombie zombie(
        .clk(clk_game_shift),
        .rst(rst),
        .btn1(btn1in),      // Button 1
        .btn2(btn2in),      // Button 2
        .btn3(btn3in),      // Button 3
        .gameover(Isgameover),
        .led(led)  
    );
    wire needs_random;
    wire [1:0] random_num;
    lfsr_random_v2  Random(
        .clk(clk_shift),
        .btn(needs_random),
        .rst(rst),
        .seed(2'd1),
        .rand_num(random_num) //output
    );
    //wire btn1in, btn2in, btn3in;
    wire MD1, MD2, MD3;
    wire ready, gaming;
    //Data_Driver
    Data_Driver DDR(
        .clk(clk_shift),
        .rst(rst),
        .col(col),
        .row(row),
        .R00in(R00in), //input
        .R01in(R01in),
        .R02in(R02in),
        .R03in(R03in),
        .R04in(R04in),
        .R05in(R05in),
        .R10in(R10in),
        .R11in(R11in),
        .R12in(R12in),
        .R13in(R13in),
        .R14in(R14in),
        .R15in(R15in),
        .gameover(Isgameover),//output
        .Ready(ready),
        .Gaming(gaming),
        .R0(R0in),
        .R1(R1in),
        .B0(B0in),
        .B1(B1in),
        .G0(G0in),
        .G1(G1in),
        .M1Down(MD1),
        .M2Down(MD2),
        .M3Down(MD3)
    );
    wire shift;
    
    //Detector
    Detector DTC(
        .clk(clk_shift), //input
        .btn1(btn1in), //btn1, btn2, btn3
        .btn2(btn2in),
        .btn3(btn3in),
        .MD1(MD1),
        .MD2(MD2),
        .MD3(MD3),
        .initial_(ready),
        .need_random(needs_random), //output
        .shift(shift)
    );

    //Picture_shift
    Picture_shifter PTS(
        .clk(clk_shift),
        .rst(rst),
        .random_num(random_num),
        .shift(shift),
        .Gaming(gaming),
        .ready(ready),
        .R00in(R00in),
        .R01in(R01in),
        .R02in(R02in),
        .R03in(R03in),
        .R04in(R04in),
        .R05in(R05in),
        .R10in(R10in),
        .R11in(R11in),
        .R12in(R12in),
        .R13in(R13in),
        .R14in(R14in),
        .R15in(R15in)
    );

endmodule 
