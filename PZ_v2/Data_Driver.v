module Data_diver(
    input clk,
    input rst,
    input R00in,
    input R01in,
    input R02in,
    input R03in,
    input R04in,
    input R05in,
    input R10in,
    input R11in,
    input R12in,
    input R13in,
    input R14in,
    input R15in,
    input gameover,
    output Ready,
    output Gaming,
    output R0,
    output R1,
    output B0,
    output B1,
    output G0,
    output G1,
    output M1Down,
    output M2Down,
    output M3Down,
);

parameter[3:0] IDLE = 3'd0, ready = 3'd1, Gaming = 3'd2, Finish = 3'd3;
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
    else if(CS == ready)
        setupcnt <= setupcnt + 3'd1;
end
//need_random
always @(posedge clk or posedge rst) begin
    if(rst)
        Ready <= 1'd0;
    else begin
        if(NS == ready)
            Ready <= 1'd1;
        else if(NS == Gaming)
            Ready <= 1'd0;    
    end
end

//tell now is Gaming
always @(posedge clk or posedge rst)begin
    if(rst)
        Gaming <= 1'd0;
    else begin
        if(NS == Gaming)
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
