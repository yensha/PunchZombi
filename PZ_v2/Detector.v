// module Detector(
//     input clk,
//     input btn1, //btn1, btn2, btn3
//     input btn2,
//     input btn3,
//     input MD1,
//     input MD2,
//     input MD3,
//     input initial_,
//     output reg need_random, 
//     output reg shift
// );
// reg btnpos;
// always@(posedge btn1 or posedge btn2 or posedge btn3)begin
//     if((MD1 & btn1) || (MD2 & btn2) || (MD3 & btn3))
//         btnpos <= 1'd1;
//     else 
//         btnpos <= 1'd0; 
// end

// always@(posedge clk)begin
//     if(initial_ || btnpos)begin
//         need_random <= 1'd1;
//         shift <= 1'd1;
//     end
//     else begin
//         need_random <= 1'd0;
//         shift <= 1'd0;
//     end

// end

// endmodule
module Detector(
    input clk,
    input rst,
    input btn1, //btn1, btn2, btn3
    input btn2,
    input btn3,
    input MD1,
    input MD2,
    input MD3,
    output reg need_random, 
    output reg shift
);

parameter state_bit=2;

reg [state_bit-1:0] cur_state;
reg [state_bit-1:0] next_state;

localparam [state_bit-1:0] DECTECTING = 0;
localparam [state_bit-1:0] DETECTED = 1;
localparam [state_bit-1:0] RESET = 2;

//clock要�?�快
//initial_ ?��?��給button_to_led
 always @(posedge clk or posedge rst) begin
    if(rst) 
        cur_state <= DECTECTING;
    else    
        cur_state <= next_state;
end
always @(*) begin
    case (cur_state)
        DECTECTING: begin
            if ((MD1 && btn1) || (MD2 && btn2) || (MD3 && btn3)) 
                next_state = DETECTED;
            else 
                next_state = DECTECTING;
        end
        DETECTED: begin
            next_state = RESET;
        end
        RESET: begin
            if (btn1 || btn2 || btn3) 
                next_state = RESET;
            else
                next_state = DECTECTING;
        end
    endcase
end

always @(posedge clk) begin
    case (cur_state)
        DECTECTING: begin
            shift <= 1'd0;
            need_random <= 1'd0;
        end
        DETECTED: begin
            shift <= 1'd1;
            need_random <= 1'd1;
        end
        RESET: begin
            shift <= 1'd0;
            need_random <= 1'd0;
        end
    endcase
end

endmodule