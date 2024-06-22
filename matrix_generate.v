module matrix_generate(
    input clk,
    input rst, 
    input col,
    input row,
    input [1:0] monster_num, // random
    input btn1, //btn1, btn2, btn3
    input btn2,
    input btn3,
    input gameover,
    output reg need_random, // tell Random module to generate random
    output reg R0,
    output reg B0,
    output reg G0,
    output reg R1,
    output reg B1,
    output reg G1
);
reg [159:0] R00, R01, R02, R03, R04, R05;// upper registers
reg [159:0] R10, R11, R12, R13, R14, R15; // lower registers
//picture registers
wire [159:0] up_pic = 
{ 160'b0111100100_0110101100_0001111100_0001111111_0000000000_0000000000_0000100000_0000111110_0000111111_0110101110_0110011110_0110111000_0101111111_0000111110_0000100000_0000000000 };

wire [159:0] down_pic = 
{ 160'b0000000000_0000100000_0010100011_0111101000_0001111000_0101111110_0000111111_0000000000_0000000000_0000000000_0000000000_0000001111_0000111111_0111101000_0010100011_0000100000 };


//picture of monster1, half of monster2
reg shift ;// tell the picture to shift

//------------------------detector------------------------------

always@(*)begin
     if(btn1)begin
            if(R00[31])
                shift = 1'd1;
            else
                shift = 1'd0;
    end
    else if(btn2)begin
        if(R00[152]) //row 14 col 2
            shift = 1'd1;
        else
            shift = 1'd0;
    end
    else if(btn3)begin
        if(R10[130])
            shift = 1'd1;
        else
            shift = 1'd0;
    end
    else begin
        shift = 1'd0;
    end
end
//tell random to generate random number
always@(*)begin
     if(btn1)begin
            if(R00[31])
                need_random = 1'd1;
            else
                need_random = 1'd0;
    end
    else if(btn2)begin
        if(R00[152])
            need_random = 1'd1;
        else
            need_random = 1'd0;
    end
    else if(btn3)begin
        if(R10[130])
            need_random = 1'd1;
        else
            need_random = 1'd0;
    end
    else begin
        need_random = 1'd0;
    end
end
//--------------------------------------------------------------

parameter[3:0] IDLE = 3'd0, ready = 3'd1, Gaming = 3'd2, Finish = 3'd3;
reg [2:0] setupcnt;
reg [1:0] CS, NS;
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
    R05 <= R04   
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

//state
always@(posedge clk or posedge rst)begin
    if(rst)
        CS <= IDLE;
    else
        CS <= NS;
end

//refresh setup counters(make 6 zombies)
always@(posedge clk or posedge rst)begin
    if(rst)
        setupcnt <= 3'd0;
    else if(CS == ready)
        setupcnt <= setupcnt + 3'd1;
end
//need_random
always @(posedge clk ) begin
    if(NS == ready)
        need_random <= 1'd1;
    else if(NS == Gaming)
        need_random <= 1'd0;    
end

//change state
always@(*)begin
    case(CS)
        IDLE:begin
            NS <= ready;
        end
        ready:begin
            if(setupcnt == 3'd6)
                NS <= Gaming;
            else
                NS <= ready;
        end
        Gaming:begin
            if(gameover)
                NS = Finish;
            else
                NS = Gaming;
        end
    endcase
end

        
//put the signals into matrix module
wire [5:0] register;
assign register =  col /6'd10;
wire [11:0] pixel;
assign pixel = col - register + row * 6'd6;
always@(*)begin
    case(register)
        0:begin
            if(row < 4'd11)begin //row = 0 ~ 10
                if(row < 4'd6)begin
                    R1 = R10[pixel];
                    B1 = 1'd0;
                    G1 = R10[pixel];
                end
                R0 = R00[pixel];
                B0 = 1'd0;
                G0 = R00[pixel];
                R1 = 1'd0;
                B1 = R10[pixel];
                G1 = 1'd0;
            end
            else begin
                R0 = 1'd0;
                B0 = 1'd0;
                G0 = R00[pixel];
                R1 = 1'd0;
                B1 = R10[pixel];
                G1 = 1'd0;
            end
        end
        1:begin
            if(row < 4'd11)begin //row = 0 ~ 10
                if(row < 4'd6)begin
                    R1 = R11[pixel];
                    B1 = 1'd0;
                    G1 = R11[pixel];
                end
                R0 = R01[pixel];
                B0 = 1'd0;
                G0 = R01[pixel];
                R1 = 1'd0;
                B1 = R11[pixel];
                G1 = 1'd0;
            end
            else begin
                R0 = 1'd0;
                B0 = 1'd0;
                G0 = R01[pixel];
                R1 = 1'd0;
                B1 = R11[pixel];
                G1 = 1'd0;
            end
        end
        2:begin
            if(row < 4'd11)begin //row = 0 ~ 10
                if(row < 4'd6)begin
                    R1 = R12[pixel];
                    B1 = 1'd0;
                    G1 = R12[pixel];
                end
                R0 = R02[pixel];
                B0 = 1'd0;
                G0 = R02[pixel];
                R1 = 1'd0;
                B1 = R12[pixel];
                G1 = 1'd0;
            end
            else begin
                R0 = 1'd0;
                B0 = 1'd0;
                G0 = R02[pixel];
                R1 = 1'd0;
                B1 = R12[pixel];
                G1 = 1'd0;
            end
        end
        3:begin
            if(row < 4'd11)begin //row = 0 ~ 10
                if(row < 4'd6)begin
                    R1 = R13[pixel];
                    B1 = 1'd0;
                    G1 = R11[pixel];
                end
                R0 = R03[pixel];
                B0 = 1'd0;
                G0 = R03[pixel];
                R1 = 1'd0;
                B1 = R13[pixel];
                G1 = 1'd0;
            end
            else begin
                R0 = 1'd0;
                B0 = 1'd0;
                G0 = R03[pixel];
                R1 = 1'd0;
                B1 = R13[pixel];
                G1 = 1'd0;
            end
        end
        4:begin
            if(row < 4'd11)begin //row = 0 ~ 10
                if(row < 4'd6)begin
                    R1 = R14[pixel];
                    B1 = 1'd0;
                    G1 = R14[pixel];
                end
                R0 = R04[pixel];
                B0 = 1'd0;
                G0 = R04[pixel];
                R1 = 1'd0;
                B1 = R14[pixel];
                G1 = 1'd0;
            end
            else begin
                R0 = 1'd0;
                B0 = 1'd0;
                G0 = R04[pixel];
                R1 = 1'd0;
                B1 = R14[pixel];
                G1 = 1'd0;
            end
        end
        5:begin
            if(row < 4'd11)begin //row = 0 ~ 10
                if(row < 4'd6)begin
                    R1 = R15[pixel];
                    B1 = 1'd0;
                    G1 = R15[pixel];
                end
                R0 = R05[pixel];
                B0 = 1'd0;
                G0 = R05[pixel];
                R1 = 1'd0;
                B1 = R15[pixel];
                G1 = 1'd0;
            end
            else begin
                R0 = 1'd0;
                B0 = 1'd0;
                G0 = R05[pixel];
                R1 = 1'd0;
                B1 = R15[pixel];
                G1 = 1'd0;
            end
        end
        default: begin
            R0 = 1'd0;
            B0 = 1'd0;
            G0 = 1'd0;
            R1 = 1'd0;
            B1 = 1'd0;
            G1 = 1'd0;
        end

        
    endcase
end

endmodule