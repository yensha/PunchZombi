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
    output clk_shft
);

    wire clk_shift;
    assign clk_shft = clk_shift;

    clk_div clk_div_0(.clk(clk),
                .rst(rst),
                .clk_div(clk_shift)
                );

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
    .OE(OE),
    .LAT(LAT)
);
endmodule 
