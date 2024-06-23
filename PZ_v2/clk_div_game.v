module clk_div_game (
    input wire clk,
    input wire rst,
    output reg clk_div
);

    reg [31:0] count;

    // Set the division factor for 1-second period
    parameter DIV_FACTOR = 62500000;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 32'd0;
            clk_div <= 1'b0;
        end else begin
            if (count == (DIV_FACTOR - 1)) begin
                count <= 32'd0;
                clk_div <= ~clk_div;
            end else begin
                count <= count + 1;
            end
        end
    end

endmodule
