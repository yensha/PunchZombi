module pic_DFF(
    input clk,
    input rst,
    input shift,
    input [159:0] D,
    output [159:0] Q
)

always@(posedge clk or posedge rst)begin
    if(rst)
        D <= 160'd0;
    else 
        Q <= D;
end
always@(*)begin
    if(shift)
        D = Q
end

endmodule