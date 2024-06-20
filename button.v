module button_to_led (
    input wire clk,
    input wire rst,       // Reset button
    input wire btn1,      // Button 1
    input wire btn2,      // Button 2
    input wire btn3,      // Button 3
    //output reg [3:0] output_val, // 4-bit output value
    output reg [3:1] led  // 3 LEDs
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
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

endmodule
