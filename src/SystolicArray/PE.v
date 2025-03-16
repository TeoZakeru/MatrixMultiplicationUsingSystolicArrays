module PE #(parameter DATA_WIDTH = 10)(
    input [DATA_WIDTH-1:0] a, b, 
    input clk, rst,
    output reg [DATA_WIDTH-1:0] c, d,
    output reg [2*DATA_WIDTH-1:0] C_out
);
	wire [2*DATA_WIDTH-1:0] multi;
	always @(posedge clk or negedge rst) begin
		if(!rst) begin
			C_out <= 0;
			c <= 0;
			d <= 0;
		end
		else begin
			C_out <= C_out + multi;
			c <= a;
			d <= b;
		end
	end
	assign multi = a*b;
endmodule
