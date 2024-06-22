module Picture_Shifter (
    input clk,
    input rst,
    input random_num,
    input shift,
    input Gaming,
    input ready,
    
    output R01in,
    output R02in,
    output R03in,
    output R04in,
    output R05in,
    output R10in,
    output R11in,
    output R12in,
    output R13in,
    output R14in,
    output R15in,

    output B00in,
    output B01in,
    output B02in,
    output B03in,
    output B04in,
    output B05in,
    output B10in,
    output B11in,
    output B12in,
    output B13in,
    output B14in,
    output B15in,

    output G00in,
    output G01in,
    output G02in,
    output G03in,
    output G04in,
    output G05in,
    output G10in,
    output G11in,
    output G12in,
    output G13in,
    output G14in,
    output G15in,
);
    
reg [159:0] R00, R01, R02, R03, R04, R05;// upper registers
reg [159:0] R10, R11, R12, R13, R14, R15; // lower registers
//picture registers
wire [159:0] up_pic = 
{ 160'b0111100100_0110101100_0001111100_0001111111_0000000000_0000000000_0000100000_0000111110_0000111111_0110101110_0110011110_0110111000_0101111111_0000111110_0000100000_0000000000 };

wire [159:0] down_pic = 
{ 160'b0000000000_0000100000_0010100011_0111101000_0001111000_0101111110_0000111111_0000000000_0000000000_0000000000_0000000000_0000001111_0000111111_0111101000_0010100011_0000100000 };

//Register data controll
always@(posedge clk or posedge rst)begin
    if(rst)begin
       R00 <= 160'd0;
       R01 <= 160'd0;
       R02 <= 160'd0;
       R03 <= 160'd0;
       R04 <= 160'd0;
       R05 <= 160'd0;
       R10 <= 160'd0;
       R11 <= 160'd0;
       R12 <= 160'd0;
       R13 <= 160'd0;
       R14 <= 160'd0;
       R15 <= 160'd0;
    end
    //input data(picture)
    else if((CS == Gaming || CS == ready) && shift)begin
        if(monster_num == 2'd0)begin
            R05 <= { 60'd0, up_pic[99:0]};
            R15 <= 160'd0;
        end
        else if(monster_num == 2'd1)begin
            R05 <= {up_pic[159:100] , 100'd0};
            R15 <= { 110'd0 ,down_pic[49:0]};
        end
        else if(monster_num == 2'd2)begin
            R05 <= 160'd0;
            R15 <= {down_pic[159:50], 40'd0};
        end

        R04 <= R05;
        R03 <= R04;
        R02 <= R03;
        R01 <= R02;
        R00 <= R01;

        R14 <= R15;
        R13 <= R14;
        R12 <= R13;
        R11 <= R12;
        R10 <= R11;

    end
    else if(CS == Finish)begin
       R00 <= 160'd0;
       R01 <= 160'd0;
       R02 <= 160'd0;
       R03 <= 160'd0;
       R04 <= 160'd0;
       R05 <= 160'd0;
       R10 <= 160'd0;
       R11 <= 160'd0;
       R12 <= 160'd0;
       R13 <= 160'd0;
       R14 <= 160'd0;
       R15 <= 160'd0;
    end

end

pic_DFF pic_DFF0( .clk(clk), .rst(rst), .shift(shift), .D(R05), .Q(R04));
pic_DFF pic_DFF1( .clk(clk), .rst(rst), .shift(shift), .D(R04), .Q(R03));
pic_DFF pic_DFF2( .clk(clk), .rst(rst), .shift(shift), .D(R03), .Q(R02));
pic_DFF pic_DFF3( .clk(clk), .rst(rst), .shift(shift), .D(R02), .Q(R01));
pic_DFF pic_DFF4( .clk(clk), .rst(rst), .shift(shift), .D(R01), .Q(R00));

pic_DFF pic_DFF5( .clk(clk), .rst(rst), .shift(shift), .D(R15), .Q(R14));
pic_DFF pic_DFF6( .clk(clk), .rst(rst), .shift(shift), .D(R14), .Q(R13));
pic_DFF pic_DFF7( .clk(clk), .rst(rst), .shift(shift), .D(R13), .Q(R12));
pic_DFF pic_DFF8( .clk(clk), .rst(rst), .shift(shift), .D(R12), .Q(R11));
pic_DFF pic_DFF9( .clk(clk), .rst(rst), .shift(shift), .D(R11), .Q(R10));


endmodule
