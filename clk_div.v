module clk_div (
    input wire clk,
    input wire rst,
    output reg clk_div
);

    reg [31:0] count;

    // Set the division factor
    parameter DIV_FACTOR = 50; // Adjust this value according to your requirement

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

// module clk_div(
// input clk,
// input rst,
// output clk_div
// );
// reg clk_div;
// reg [25:0] cnt;

// always@(posedge clk or posedge rst) 
// begin
// 	if (rst) 
// 		cnt<=26'd0;
// 	else if(cnt==5000-1)
// 		cnt<=26'd0;
// 	else	
// 		cnt<=cnt+1;
// end

// always@(posedge clk or posedge rst)
// begin
// 	if(rst)
// 		clk_div<=1'b0;
// 	else if(cnt==25000-1)
// 		clk_div<=~clk_div;
// end

// endmodule