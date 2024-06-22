module lfsr_random_v2 (
    input clk,
    input wire generate_random,
    input wire rst,
    input wire [1:0] seed,
    output reg [1:0] rand_num
);
reg clk_div;       
reg [25:0] cnt;    

	always@(posedge clk or posedge rst)
	begin
		if (rst)
			cnt <= 26'd0;                  
		else if (cnt == 31250000-1)//31250000 means clk change about every half second
			cnt <= 26'd0;                  
		else
			cnt <= cnt + 1;                
	end

	always@(posedge clk or posedge rst)
	begin
		if (rst)
			clk_div <= 1'b0;                
		else if (cnt == 0)
			clk_div <= ~clk_div;            
	    else if (cnt == 15625000-1)//half time of the clk change from 1 to 0
			clk_div <= ~clk_div;
	end
    reg [1:0] lfsr;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            lfsr <= seed;
        end else if(generate_random)begin
            // LFSR feedback polynomial for 2-bit: x^2 + x + 1
            lfsr <= {lfsr[0], lfsr[1]^clk_div};
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rand_num <= 2'b00;
        end else if(generate_random)begin
            // Ensure rand_num is between 1 and 3
            rand_num <= (lfsr % 3) + 1;
        end
    end

endmodule
/*
module button_to_led (
    input wire clk,
    input wire rst,       // Reset button
    input wire btn1,      // Button 1
    input wire btn2,      // Button 2
    input wire btn3,      // Button 3
    output reg [3:0] led  // 4 LEDs
);

    wire [1:0] rand_num;
    reg btn1_d, btn2_d, btn3_d;
    
    // Registering button states to detect edges
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            btn1_d <= 1'b0;
            btn2_d <= 1'b0;
            btn3_d <= 1'b0;
        end else begin
            btn1_d <= btn1;
            btn2_d <= btn2;
            btn3_d <= btn3;
        end
    end
    
    // Connect LFSR module for random number generation

        lfsr_random lfsr_inst (
            .clk(clk),
            .btn(btn1_d | btn2_d | btn3_d),  // Generate random number on any button press
            .rst(rst),
            .seed(2'b01),  // Concatenate btn1_d and btn2_d to form seed
            .rand_num(rand_num)
        );

    // Assign LEDs based on generated random number
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            led <= 4'b0000; // Reset LEDs on reset
        end else begin
            case(rand_num)
                2'b01: led <= 4'b0010;  // LED 1
                2'b10: led <= 4'b0100;  // LED 2
                2'b11: led <= 4'b1000;  // LED 3
                default: led <= 4'b0000; // All LEDs off for random number 0
            endcase
        end
    end

endmodule
*/