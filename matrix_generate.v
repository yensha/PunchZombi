module matrix_generate(
    input clk,
    input rst, 
    input col,
    input row,
    input shift,
    output R0,
    output B0,
    output G0,
    output R1,
    output B1,
    output G1
);
reg [159:0] R00, R01, R02, R03, R04, R05;// upper registers
reg [159:0] R10, R11, R12, R13, R14, R15; // lower registers

pic_DFF pic_DFF0( .clk(clk), .rst(rst), .shift(shift), .D(R00), .Q(R01));
pic_DFF pic_DFF1( .clk(clk), .rst(rst), .shift(shift), .D(R01), .Q(R02));
pic_DFF pic_DFF2( .clk(clk), .rst(rst), .shift(shift), .D(R02), .Q(R03));
pic_DFF pic_DFF3( .clk(clk), .rst(rst), .shift(shift), .D(R03), .Q(R04));
pic_DFF pic_DFF4( .clk(clk), .rst(rst), .shift(shift), .D(R04), .Q(R05));

pic_DFF pic_DFF5( .clk(clk), .rst(rst), .shift(shift), .D(R11), .Q(R12));
pic_DFF pic_DFF6( .clk(clk), .rst(rst), .shift(shift), .D(R12), .Q(R13));
pic_DFF pic_DFF7( .clk(clk), .rst(rst), .shift(shift), .D(R13), .Q(R14));
pic_DFF pic_DFF8( .clk(clk), .rst(rst), .shift(shift), .D(R14), .Q(R15));
pic_DFF pic_DFF9( .clk(clk), .rst(rst), .shift(shift), .D(R15), .Q(R16));



endmodule