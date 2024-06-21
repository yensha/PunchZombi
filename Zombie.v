module Zombie (
    input  clk,
    input  rst,       // Reset button
    input  btn1,      // Button 1
    input  btn2,      // Button 2
    input  btn3,      // Button 3
    //output reg [3:0] output_val, // 4-bit output value
    input gameover,
    output reg [3:1] led  // 3 LEDs
);

parameter[2:0] IDLE = 3'd0, Gaming = 3'd1, Finish = 3'd2; 
reg[1:0] CS,NS;
reg [4:0] timer;
always@(posedge clk or posedge rst)begin
    if(rst)begin
        CS <= IDLE;
    end
    else begin
        CS <= NS;
    end
end
always@(posedge clk or posedge rst)begin
    if(rst)begin
        timer <= 5'd0;
    end
    else if(CS == Gaming)
        timer <= timer + 1'd1;
end
//controll button & led signals
always @(posedge clk or posedge rst) begin
    if (rst) begin // give random "seed"
        if(btn1)
            led <= 3'd1;
        else if(btn2)
            led <= 3'd2;
        else if(btn3)
            led <= 3'd3;
        else
        //output_val <= 4'b0000; // Reset output value
            led <= 3'b000;         // Reset LEDs

    end else begin
        if (btn1) begin
            //output_val <= 4'b0001;
            led <= 3'b001; // Light up the first LED
        end else if (btn2) begin
            //output_val <= 4'b0010;
            led <= 3'b010; // Light up the second LED
        end else if (btn3) begin
            //output_val <= 4'b0100;
            led <= 3'b100; // Light up the third LED
        end else begin
            //output_val <= 4'b0000;
            led <= 3'b000; // Turn off all LEDs
        end
    end
end
//寫遊戲機致

endmodule
