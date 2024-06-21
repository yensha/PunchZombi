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
    output reg [3:1]led
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
    .R0in(R0in),
    .G0in(G0in),
    .B0in(B0in),
    .R1in(R1in),
    .G1in(G1in),
    .B1in(B1in),
    .cnt(col),
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
        .btn1(btn1),      // Button 1
        .btn2(btn2),      // Button 2
        .btn3(btn3),      // Button 3
        .gameover(Isgameover),
        .led(led)  
    );
    wire needs_random;
    lfsr_random_v2  Random(
        .clk(clk),
        .btn(need_random),
        .rst(rst),
        .seed(2'd1),
        .rand_num(rand_num)
    );
    wire btn1, btn2, btn3;
    wire [1:0] rand_num;
    wire R0in, R1in, B0in, B1in, G0in, G1in;
    matrix_generate MG(
        .clk(clk),
        .rst(rst), 
        .col(col),
        .row(row),
        .monster_num(rand_num), // random
        .need_random(needs_random),
        .btn1(btn1), //btn1, btn2, btn3
        .btn2(btn2),
        .btn3(btn3),
        .R0(R0in),
        .B0(B0in),
        .G0(G0in),
        .R1(R1in),
        .B1(B1in),
        .G1(G1in),
        .gameover(Isgameover)
    );
endmodule 
