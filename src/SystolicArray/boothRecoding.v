module boothRecoding #(parameter DATA_WIDTH = 8)(
	input [DATA_WIDTH-1:0] X,
	output reg [((DATA_WIDTH+2)/3)-1:0] s,
	output reg [((DATA_WIDTH+2)/3)-1:0] t,
	output reg [((DATA_WIDTH+2)/3)-1:0] d,
	output reg [((DATA_WIDTH+2)/3)-1:0] q,
	output reg [((DATA_WIDTH+2)/3)-1:0] n
);
	wire [DATA_WIDTH+3:0] Q;
	assign Q = {{3{X[DATA_WIDTH-1]}}, X, 1'b0}; // Extend sign for Booth encoding
	localparam NUM_PARTIALS = (DATA_WIDTH + 2) / 3; // Compute ceil(N/3)
	genvar i;
	wire [3:0] booth_code [NUM_PARTIALS-1:0];  
	generate
			for (i = 0; i < NUM_PARTIALS; i = i + 1) begin : booth_gen
				always @(*) begin
					s[i] = ~(Q[3*i+3]^Q[3*i+2])^(Q[3*i+1]^Q[3*i]);
					d[i] = (Q[3*i+2]^Q[3*i+1])^(~(Q[3*i+1]^Q[3*i]));
					t[i] = (Q[3*i+3]^Q[3*i+2])^(Q[3*i+1]^Q[3*i]);
					q[i] = (Q[3*i+3]^Q[3*i+2])^(~(Q[3*i+2]^Q[3*i+1]))^(~(Q[3*i+1]^Q[3*i]));
					n[i] = Q[3*i+3];
				end
			end
	endgenerate
endmodule
//module boothRecoding #(parameter DATA_WIDTH = 8)(
//	input [DATA_WIDTH-1:0] X,
//	input clk,
//	input rst,
//	output reg [((DATA_WIDTH+2)/3)-1:0] s,
//	output reg [((DATA_WIDTH+2)/3)-1:0] t,
//	output reg [((DATA_WIDTH+2)/3)-1:0] d,
//	output reg [((DATA_WIDTH+2)/3)-1:0] q,
//	output reg [((DATA_WIDTH+2)/3)-1:0] n
//);
//	wire signed [DATA_WIDTH+3:0] Q;
//	assign Q = {{3{X[DATA_WIDTH-1]}}, X, 1'b0}; // Extend sign for Booth encoding
//	localparam NUM_PARTIALS = (DATA_WIDTH + 2) / 3; // Compute ceil(N/3)
//	integer i;
//	wire signed [3:0] booth_code [NUM_PARTIALS-1:0];  
////	generate
//		always @(posedge clk or negedge rst) begin
//			if(!rst) begin
				
//			end
//			else begin
//				for (i = 0; i < NUM_PARTIALS; i = i + 1) begin : booth_gen
//						s[i] <= ~(Q[3*i+3]^Q[3*i+2])^(Q[3*i+1]^Q[3*i]);
//						d[i] <= (Q[3*i+2]^Q[3*i+1])^(~(Q[3*i+1]^Q[3*i]));
//						t[i] <= (Q[3*i+3]^Q[3*i+2])^(Q[3*i+1]^Q[3*i]);
//						q[i] <= (Q[3*i+3]^Q[3*i+2])^(~(Q[3*i+2]^Q[3*i+1]))^(~(Q[3*i+1]^Q[3*i]));
//						n[i] = Q[3*i+3];
//					end
//				end
//			end
////	endgenerate
//endmodule
