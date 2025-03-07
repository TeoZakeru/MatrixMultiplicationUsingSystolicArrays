module PE #(parameter DATA_WIDTH = 8)(
    input [DATA_WIDTH-1:0] a, b, 
    input clk, rst, done, 
    output reg [DATA_WIDTH-1:0] c, d, C_out
);
	wire [2*DATA_WIDTH-1:0] multi;
	always @(posedge rst or posedge clk) begin
		if(rst) begin
			C_out <= 0;
			c <= 0;
			d <= 0;
		end
//		else if(done) begin
//		    C_out <= C_out;
//		    c <= a;
//			d <= b;
//		end
		else begin
			C_out <= C_out + multi;
			c <= a;
			d <= b;
		end
	end
	assign multi = a*b;
endmodule
