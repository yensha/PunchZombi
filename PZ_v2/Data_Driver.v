module Data_diver(
    input clk,
    input rst,
    input [6:0]col,
    input [3:0] row,
    input [159:0] R00in,
    input [159:0] R01in,
    input [159:0] R02in,
    input [159:0] R03in,
    input [159:0] R04in,
    input [159:0] R05in,
    input [159:0] R10in,
    input [159:0] R11in,
    input [159:0] R12in,
    input [159:0] R13in,
    input [159:0] R14in,
    input [159:0] R15in,
    input gameover,
    output reg Ready,
    output reg Gaming,
    output reg R0,
    output reg R1,
    output reg B0,
    output reg B1,
    output reg G0,
    output reg G1,
    output reg M1Down,
    output reg M2Down,
    output reg M3Down
);

parameter[3:0] IDLE = 3'd0, ready = 3'd1, NowGaming = 3'd2, Finish = 3'd3;
reg [2:0] setupcnt;
reg [1:0] CS, NS;
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
    else if(CS == ready)begin
        if(setupcnt == 3'd6)
            setupcnt <= 3'd0;
        else
            setupcnt <= setupcnt + 3'd1;
    end
end
//need_random
always @(posedge clk or posedge rst) begin
    if(rst)
        Ready <= 1'd0;
    else begin
        if(NS == ready)
            Ready <= 1'd1;
        else if(NS == NowGaming)
            Ready <= 1'd0;    
    end
end

//tell now is Gaming
always @(posedge clk or posedge rst)begin
    if(rst)
        Gaming <= 1'd0;
    else begin
        if(NS == NowGaming)
            Gaming <= 1'd1;
        else if(NS == Finish)
            Gaming <= 1'd0;
    end
end

//change state
always@(*)begin
    case(CS)
        IDLE:begin
            NS <= ready;
        end
        ready:begin
            if(setupcnt == 3'd6)
                NS <= NowGaming;
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
//detect if the monster is on row 0
always@(posedge clk or posedge rst)begin
    if(rst)begin
        M1Down = 1'd0;
        M2Down = 1'd0;
        M3Down = 1'd0;
    end
    else begin
        if(R00in[31])
            M1Down = 1'd1;
        else
            M1Down = 1'd0;
        if(R00in[152]) //row 14 col 2
            M2Down = 1'd1;
        else
            M2Down = 1'd0;
        if(R10in[130])
            M3Down = 1'd1;
        else
            M3Down = 1'd0;
    end
end
//put the signals into matrix module
wire [5:0] register;
assign register =  col /6'd10;
wire [11:0] pixel;
assign pixel = col % 6'd10 + row * 6'd10;
always@(*)begin
    case(register)
        0:begin
            if(row < 4'd11)begin //row = 0 ~ 10
                if(row < 4'd6)begin
                    R1 = R10in[pixel];
                    B1 = 1'd0;
                    G1 = R10in[pixel];
                end
                R0 = R00in[pixel];
                B0 = 1'd0;
                G0 = R00in[pixel];
                R1 = 1'd0;
                B1 = R10in[pixel];
                G1 = 1'd0;
            end
            else begin
                R0 = 1'd0;
                B0 = 1'd0;
                G0 = R00in[pixel];
                R1 = 1'd0;
                B1 = R10in[pixel];
                G1 = 1'd0;
            end
        end
        1:begin
            if(row < 4'd11)begin //row = 0 ~ 10
                if(row < 4'd6)begin
                    R1 = R11in[pixel];
                    B1 = 1'd0;
                    G1 = R11in[pixel];
                end
                R0 = R01in[pixel];
                B0 = 1'd0;
                G0 = R01in[pixel];
                R1 = 1'd0;
                B1 = R11in[pixel];
                G1 = 1'd0;
            end
            else begin
                R0 = 1'd0;
                B0 = 1'd0;
                G0 = R01in[pixel];
                R1 = 1'd0;
                B1 = R11in[pixel];
                G1 = 1'd0;
            end
        end
        2:begin
            if(row < 4'd11)begin //row = 0 ~ 10
                if(row < 4'd6)begin
                    R1 = R12in[pixel];
                    B1 = 1'd0;
                    G1 = R12in[pixel];
                end
                R0 = R02in[pixel];
                B0 = 1'd0;
                G0 = R02in[pixel];
                R1 = 1'd0;
                B1 = R12in[pixel];
                G1 = 1'd0;
            end
            else begin
                R0 = 1'd0;
                B0 = 1'd0;
                G0 = R02in[pixel];
                R1 = 1'd0;
                B1 = R12in[pixel];
                G1 = 1'd0;
            end
        end
        3:begin
            if(row < 4'd11)begin //row = 0 ~ 10
                if(row < 4'd6)begin
                    R1 = R13in[pixel];
                    B1 = 1'd0;
                    G1 = R11in[pixel];
                end
                R0 = R03in[pixel];
                B0 = 1'd0;
                G0 = R03in[pixel];
                R1 = 1'd0;
                B1 = R13in[pixel];
                G1 = 1'd0;
            end
            else begin
                R0 = 1'd0;
                B0 = 1'd0;
                G0 = R03in[pixel];
                R1 = 1'd0;
                B1 = R13in[pixel];
                G1 = 1'd0;
            end
        end
        4:begin
            if(row < 4'd11)begin //row = 0 ~ 10
                if(row < 4'd6)begin
                    R1 = R14in[pixel];
                    B1 = 1'd0;
                    G1 = R14in[pixel];
                end
                R0 = R04in[pixel];
                B0 = 1'd0;
                G0 = R04in[pixel];
                R1 = 1'd0;
                B1 = R14in[pixel];
                G1 = 1'd0;
            end
            else begin
                R0 = 1'd0;
                B0 = 1'd0;
                G0 = R04in[pixel];
                R1 = 1'd0;
                B1 = R14in[pixel];
                G1 = 1'd0;
            end
        end
        5:begin
            if(row < 4'd11)begin //row = 0 ~ 10
                if(row < 4'd6)begin
                    R1 = R15in[pixel];
                    B1 = 1'd0;
                    G1 = R15in[pixel];
                end
                R0 = R05in[pixel];
                B0 = 1'd0;
                G0 = R05in[pixel];
                R1 = 1'd0;
                B1 = R15in[pixel];
                G1 = 1'd0;
            end
            else begin
                R0 = 1'd0;
                B0 = 1'd0;
                G0 = R05in[pixel];
                R1 = 1'd0;
                B1 = R15in[pixel];
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
