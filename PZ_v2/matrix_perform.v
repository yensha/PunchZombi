/*
---------------------------------------------------------------------------------------------------------------
LED matrix can light two rows of pixels per input, and it needs to input 64 pixels of RGB data to light one row.
Therefore, you need to input 128 RGB data in a cycle.
Before entering the data into the LED, OE needs to be pulled up to avoid mistakes.
After all the data is done, pull up LAT to light up the LED.
----------------------------------------------------------------------------------------------------------------
Three states control the LED matrix performance:
IDLE: Initial state.
GET: Retrieve the RGB data 64 times, and OE is pulled up in this state.
TRANSMIT: Perform the LED operation, and LAT is pulled up in this state. Also, the OE signal needs to be pulled down,or the LED matrix won't perform.

The test output for RGB:
Multiples of 2 are white.
Multiples of 4 are blue.
Multiples of 8 are green.
Multiples of 16 are red.
Others aren't beaming.

*/

module matrix (
    input clk,
    input rst,                //positive edge
    output reg A, 
    output reg B,
    output reg C,
    output reg D,
    input ready,
    input gaming,
    input R0in,
    input G0in,
    input B0in,
    input R1in,
    input G1in,
    input B1in,
    output reg  R0,
    output reg  G0,
    output reg  B0,
    output reg  R1,
    output reg  G1,
    output reg  B1,
    output reg [6:0] cols,
    output reg [3:0] rows,
    output reg OE,
    output reg LAT
);



reg [1:0] CS, NS;
reg [6:0] col;    // column count
reg [3:0] row;    // row count

localparam START = 2'd0, MENU = 2'd1, PLAY = 2'd2, FINISH = 2'd3;     // game   control
localparam IDLE = 2'd0, DELAY = 2'd1, GET = 2'd2, TRANSMIT = 2'd3;    // matrix perform

    //FSM
    always @(posedge clk or posedge rst) begin
        if(rst) CS <= IDLE;

        else       CS <= NS;
    end

    always @(*) begin
        case(CS)

            IDLE: NS = DELAY;

            DELAY: NS = GET;

            GET: NS = (col == 7'd64)? TRANSMIT : GET;    //count 64 column

            TRANSMIT: NS = IDLE;

            default: NS = IDLE;
        endcase
    end

//reg 

    //column count
    always @(posedge clk or posedge rst) begin
        if(rst)               col <= 7'd0;

        else if(CS == DELAY)  col <= 7'd0;

        else if(CS == GET)    col <= col + 7'd1;
        else                  col <= col;
    end


    //row count
    always @(posedge clk or posedge rst) begin
        if(rst) row <= 4'd0;

        else if(CS == TRANSMIT) row <= row + 4'd1;
    end

//output

    //row output
    always @(*) begin
        {D, C, B, A} = row - 4'd1;
    end
    
    // //column count
    // always @(posedge clk or posedge rst) begin
    //     if(rst)               cnt <= 7'd0;

    //     else if(cnt == 7'd64) cnt <= 7'd0;
        
    //     else if(CS == GET)    cnt <= cnt + 7'd1;
    //     else                  cnt <= cnt;
    // end



//output the signal of row and column
always @(*) begin
    if(rst)
        cols = 7'd0;
    else 
        cols = col;
end
always @(*) begin
    if(rst)
        rows = 4'd0;
    else 
        rows = row;
end
//output

     //RGB output
    always @(posedge clk or posedge rst) begin
        if(rst)begin
            R0 <= 1'd0;
            G0 <= 1'd0;
            B0 <= 1'd0;
            R1 <= 1'd0;
            G1 <= 1'd0;
            B1 <= 1'd0;
        end
        else begin
            R0 <= R0in;
            G0 <= G0in;
            B0 <= B0in;
            R1 <= R1in;
            G1 <= G1in;
            B1 <= B1in;
        end    
    end
     //OE, LAT output
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            OE  <= 1'd0;
            LAT <= 1'd0;
        end

        else begin

            if(NS == DELAY) begin
                OE  <= 1'd0;
                LAT <= 1'd0;
            end

            if(NS == GET) begin
                OE  <= 1'd1;
                LAT <= 1'd0;
            end
            else if(NS == TRANSMIT) begin
                OE  <= 1'd1;
                LAT <= 1'd1;
            end
            else if(NS == IDLE) begin
                OE  <= 1'd0;
                LAT <= 1'd0; 
            end
        end
    end

    endmodule

    

    

   