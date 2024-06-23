module Picture_Shifter (
    input clk,
    input rst,
    input [1:0] monster_num,
    input shift,
    input Gaming,
    input ready,
    input gameover,
    output reg [159:0] R00in,
    output reg [159:0] R01in,
    output reg [159:0] R02in,
    output reg [159:0] R03in,
    output reg [159:0] R04in,
    output reg [159:0] R05in,
    output reg [159:0] R10in,
    output reg [159:0] R11in,
    output reg [159:0] R12in,
    output reg [159:0] R13in,
    output reg [159:0] R14in,
    output reg [159:0] R15in

);
    
reg [159:0] R00, R01, R02, R03, R04, R05;// upper registers
reg [159:0] R10, R11, R12, R13, R14, R15; // lower registers
wire [159:0] WR00, WR01, WR02, WR03, WR04, WR05;
wire [159:0] WR10, WR11, WR12, WR13, WR14, WR15;
//picture registers
wire [159:0] down_pic = 
{ 160'b0000000000_0000100000_0101000110_0111101000_0010111110_0011110000_0010111110_0111101000_0101000110_0000100000_0000000000_0000000000_0000000000_0001111110_0011111000_0110101100};

wire [159:0] up_pic = 
{ 160'b0111101000_0110101100_0011111000_0001111110_0000000000_0000000000_0000100000_0001111100_0010111110_0110111000_0011001110_0110111000_0010111110_0001111100_0000100000_0000000000 };
wire Shift;
assign Shift = (shift|| ready)? 1 : 0;
//Register data controll
always@(posedge clk or posedge rst)begin
    if(rst)begin
       R00in <= 160'd0;
       R01in <= 160'd0;
       R02in <= 160'd0;
       R03in <= 160'd0;
       R04in <= 160'd0;
       R05in <= 160'd0;
       R10in <= 160'd0;
       R11in <= 160'd0;
       R12in <= 160'd0;
       R13in <= 160'd0;
       R14in <= 160'd0;
       R15in <= 160'd0;
       R05 <= 160'd0;
       R15 <= 160'd0;
    end
    //input data(picture)
    else if(gameover)begin
       R00in <= 160'd0;
       R01in <= 160'd0;
       R02in <= 160'd0;
       R03in <= 160'd0;
       R04in <= 160'd0;
       R05in <= 160'd0;
       R10in <= 160'd0;
       R11in <= 160'd0;
       R12in <= 160'd0;
       R13in <= 160'd0;
       R14in <= 160'd0;
       R15in <= 160'd0;
    end
    else begin
        if((Gaming && shift ) || ready)begin
            if (monster_num == 2'd0)begin
                R05in <= 160'd0;
                R15in <= 160'd0;
                R05 <= 160'd0;
                R15 <= 160'd0;
            end
            else if(monster_num == 2'd1)begin
                R05in <= { 60'd0, up_pic[99:0]};
                R15in <= 160'd0;
                R05 <= { 60'd0, up_pic[99:0]};
                R15 <= 160'd0;
            end
            else if(monster_num == 2'd2)begin
                R05in <= {up_pic[159:100] , 100'd0};
                R15in <= { 110'd0 ,down_pic[49:0]};
                R05 <= {up_pic[159:100] , 100'd0};
                R15 <= { 110'd0 ,down_pic[49:0]};
            end
            else if(monster_num == 2'd3)begin
                R05in <= 160'd0;
                R15in <= {down_pic[159:50], 40'd0};
                R05 <= 160'd0;
                R15 <= {down_pic[159:50], 40'd0};
            end
        end

        R04in <= WR04;
        R03in <= WR03;
        R02in <= WR02;
        R01in <= WR01;
        R00in <= WR00;

        R14in <= WR14;
        R13in <= WR13;
        R12in <= WR12;
        R11in <= WR11;
        R10in <= WR10;
        
    end
end

pic_DFF pic_DFF0( .clk(clk), .rst(rst), .shift(Shift), .D(R05), .Q(WR04));
pic_DFF pic_DFF1( .clk(clk), .rst(rst), .shift(Shift), .D(WR04), .Q(WR03));
pic_DFF pic_DFF2( .clk(clk), .rst(rst), .shift(Shift), .D(WR03), .Q(WR02));
pic_DFF pic_DFF3( .clk(clk), .rst(rst), .shift(Shift), .D(WR02), .Q(WR01));
pic_DFF pic_DFF4( .clk(clk), .rst(rst), .shift(Shift), .D(WR01), .Q(WR00));

pic_DFF pic_DFF5( .clk(clk), .rst(rst), .shift(Shift), .D(R15), .Q(WR14));
pic_DFF pic_DFF6( .clk(clk), .rst(rst), .shift(Shift), .D(WR14), .Q(WR13));
pic_DFF pic_DFF7( .clk(clk), .rst(rst), .shift(Shift), .D(WR13), .Q(WR12));
pic_DFF pic_DFF8( .clk(clk), .rst(rst), .shift(Shift), .D(WR12), .Q(WR11));
pic_DFF pic_DFF9( .clk(clk), .rst(rst), .shift(Shift), .D(WR11), .Q(WR10));


endmodule
