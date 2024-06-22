module pic_DFF(
    input clk,
    input rst,
    input shift,
    input [159:0] D,
    output reg [159:0] Q
);

    always@(posedge clk or posedge rst)begin
        if(rst)
            Q <= 160'd0;
        else if(shift)
            Q[159:0] <= D[159:0];   
    end
    
endmodule


