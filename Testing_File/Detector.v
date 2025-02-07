module Detector(
    input clk,
    input btn1, //btn1, btn2, btn3
    input btn2,
    input btn3,
    input MD1,
    input MD2,
    input MD3,
    input initial_,
    output need_random, 
    output shift
);
reg btnpos;
always@(posedge btn1 or posedge btn2 or posedge btn3)begin
    if((MD1 & btn1) || (MD2 & btn2) || (MD3 & btn3))
        btnpos <= 1'd1;
    else 
        btnpos <= 1'd0; 
end

always@(posedge clk)begin
    if(initial_ || btnpos)begin
        need_random <= 1'd1;
        shift <= 1'd1;
    end
    else begin
        need_random <= 1'd0;
        shift <= 1'd0;
    end

end

endmodule