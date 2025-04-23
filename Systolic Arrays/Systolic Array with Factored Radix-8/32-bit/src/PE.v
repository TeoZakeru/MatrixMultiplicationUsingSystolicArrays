module PE #(parameter DATA_WIDTH = 10)(
    input [DATA_WIDTH-1:0] Y_in, 
    input [DATA_WIDTH+1:0] x3_Y_in, 
    input [((DATA_WIDTH+2)/3)-1:0] s_in,
	input [((DATA_WIDTH+2)/3)-1:0] t_in,
	input [((DATA_WIDTH+2)/3)-1:0] d_in,
	input [((DATA_WIDTH+2)/3)-1:0] q_in,
	input [((DATA_WIDTH+2)/3)-1:0] n_in,
    input clk, rst,
    output reg [DATA_WIDTH-1:0] Y_out,
    output reg [DATA_WIDTH+1:0] x3_Y_out,
    output reg [((DATA_WIDTH+2)/3)-1:0] s_out,
	output reg [((DATA_WIDTH+2)/3)-1:0] t_out,
	output reg [((DATA_WIDTH+2)/3)-1:0] d_out,
	output reg [((DATA_WIDTH+2)/3)-1:0] q_out,
	output reg [((DATA_WIDTH+2)/3)-1:0] n_out,
    output reg [2*DATA_WIDTH-1:0] C_out
);
	reg [2*DATA_WIDTH-1:0] multi_reg;
	wire [2*DATA_WIDTH-1:0] multi;
	always @(posedge clk or negedge rst) begin
		if(!rst) begin
			C_out <= 0;
			s_out <= 0;
			t_out <= 0;
			d_out <= 0;
			q_out <= 0;
			n_out <= 0;
			Y_out <= 0;
			x3_Y_out <= 0;
		end
		else begin
			C_out <= C_out + multi;
			s_out <= s_in;
			t_out <= t_in;
			d_out <= d_in;
			q_out <= q_in;
			n_out <= n_in;
			x3_Y_out <= x3_Y_in;
			Y_out <= Y_in;
		end
	end
	
//	always @(posedge clk or negedge rst) begin
//		if (!rst)
//			multi_reg <= 0;
//		else
//			multi_reg <= multi;
//	end
//	assign multi = a*b;
	radix8_booth_multiplier #(.N(DATA_WIDTH)) radix(
		.clk(clk),
		.rst(rst),
		.Y(Y_in), 
		.x3_Y(x3_Y_in), 
		.s_in(s_in),
		.t_in(t_in),
		.d_in(d_in),
		.q_in(q_in),
		.n_in(n_in),
		.Prod(multi) 
	);
endmodule
//module PE #(parameter DATA_WIDTH = 10)(
//    input [DATA_WIDTH-1:0] Y_in, 
//    input [DATA_WIDTH+1:0] x3_Y_in, 
//    input [((DATA_WIDTH+2)/3)-1:0] s_in,
//	input [((DATA_WIDTH+2)/3)-1:0] t_in,
//	input [((DATA_WIDTH+2)/3)-1:0] d_in,
//	input [((DATA_WIDTH+2)/3)-1:0] q_in,
//	input [((DATA_WIDTH+2)/3)-1:0] n_in,
//    input clk, rst,
//    output reg [DATA_WIDTH-1:0] Y_out,
//    output reg [DATA_WIDTH+1:0] x3_Y_out,
//    output reg [((DATA_WIDTH+2)/3)-1:0] s_out,
//	output reg [((DATA_WIDTH+2)/3)-1:0] t_out,
//	output reg [((DATA_WIDTH+2)/3)-1:0] d_out,
//	output reg [((DATA_WIDTH+2)/3)-1:0] q_out,
//	output reg [((DATA_WIDTH+2)/3)-1:0] n_out,
//    output reg [2*DATA_WIDTH-1:0] C_out
//);
//	wire [2*DATA_WIDTH-1:0] multi_reg;
//	reg [2*DATA_WIDTH-1:0] multi;
//	reg [DATA_WIDTH-1:0] out_reg;
//	reg [DATA_WIDTH+1:0] x3_out_reg;
	
//	always @(posedge clk or negedge rst) begin
//		if(!rst) begin
//			C_out <= 0;
//			s_out <= 0;
//			t_out <= 0;
//			d_out <= 0;
//			q_out <= 0;
//			n_out <= 0;
//			Y_out <= 0;
//			x3_Y_out <= 0;
//			x3_out_reg <= 0;
//			out_reg <= 0;
//		end
//		else begin
//			C_out <= C_out + multi;
//			s_out <= s_in;
//			t_out <= t_in;
//			d_out <= d_in;
//			q_out <= q_in;
//			n_out <= n_in;
//			x3_out_reg <= x3_Y_in;
//			out_reg <= Y_in;
//		end
//	end
	
//	always @(posedge clk or negedge rst) begin
//		if(rst) begin
//			x3_Y_out <= x3_out_reg;
//			Y_out <= out_reg;
//		end
//	end
////	assign multi = a*b;
//	radix8_booth_multiplier #(.N(DATA_WIDTH)) radix(
//		.Y_in(Y_in), 
//		.x3_Y_in(x3_Y_in), 
//		.s_in(s_in),
//		.t_in(t_in),
//		.d_in(d_in),
//		.q_in(q_in),
//		.n_in(n_in),
//		.Prod(multi_reg) 
//	);
//	always @(posedge clk or negedge rst) begin
//    if (!rst)
//        multi <= 0;
//    else
//        multi <= multi_reg;
//end
//endmodule