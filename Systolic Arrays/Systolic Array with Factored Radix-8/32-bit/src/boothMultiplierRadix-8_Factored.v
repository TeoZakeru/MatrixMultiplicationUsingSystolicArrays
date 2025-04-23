module radix8_booth_multiplier #(parameter N = 16) (
	input clk,
	input rst,
	input [N-1:0] Y, 
	input [N+1:0] x3_Y, 
    input [((N+2)/3)-1:0] s_in,
	input [((N+2)/3)-1:0] t_in,
	input [((N+2)/3)-1:0] d_in,
	input [((N+2)/3)-1:0] q_in,
	input [((N+2)/3)-1:0] n_in,
    output reg [2*N-1:0] Prod // Product
);

    localparam NUM_PARTIALS = (N + 2) / 3; // Compute ceil(N/3)
    
    reg [2*N:0] partial_products [NUM_PARTIALS-1:0]; // Array to store partial products
    reg [2*N+1:0] accum; // Final sum accumulation
    reg [N-1:0] Y_in;
    reg [N+1:0] x3_Y_in;
    wire [2*N-1:0] Product;
    // Booth encoding control signals
    wire [N-1:0] neg_Y;
    wire [N:0] x2_Y, x2_neg_Y;
    wire [N+1:0] x3_neg_Y, x4_Y, x4_neg_Y;

    always @(posedge clk or negedge rst) begin
    	if(!rst) begin
    		Y_in <= 0;
    		x3_Y_in <= 0;
    		Prod <= 0;
    	end
    	else begin
    		Y_in <= Y;
    		x3_Y_in <= x3_Y;
    		Prod <= Product;
    	end
    end
    // Compute 2's complement negation
    assign neg_Y = ~Y_in + 1'b1;  
    
    // Compute positive multiples
    assign x2_Y = {Y_in[N-1], Y_in} << 1;  // 2A
    assign x4_Y = {{2{Y_in[N-1]}}, Y_in} << 2;  // 4A

    // Compute negative multiples
    assign x2_neg_Y = (~{Y_in[N-1], Y_in} + 1'b1) << 1;  // -2A
    assign x3_neg_Y = ~x3_Y_in + 1'b1; // -3A
    assign x4_neg_Y = (~{{2{Y_in[N-1]}}, Y_in} + 1'b1) << 2;  // -4A

//	always @(posedge clk or negedge rst) begin
//		Prod <= accum[2*N-1:0];
//	end
	
	integer i;
	always @(*) begin
		for (i = 0; i < NUM_PARTIALS; i = i + 1) begin : booth_gen
			case ({s_in[i],d_in[i],t_in[i],q_in[i],n_in[i]})
				5'b11000, 5'b11001 : partial_products[i] = {2*N+1{1'b0}};
				5'b00110, 5'b01100 : partial_products[i] = {{(N+1){Y_in[N-1]}},Y_in};
				5'b10010, 5'b00100 : partial_products[i] = {{(N){x2_Y[N]}},x2_Y};
				5'b11010, 5'b10000 : partial_products[i] = {{(N-1){x3_Y_in[N+1]}},x3_Y_in};
				5'b01110          : partial_products[i] = {{(N-1){x4_Y[N+1]}},x4_Y};
				5'b01111          : partial_products[i] = {{(N-1){x4_neg_Y[N+1]}},x4_neg_Y};
				5'b10001, 5'b11011 : partial_products[i] = {{(N-1){x3_neg_Y[N+1]}},x3_neg_Y};
				5'b00101, 5'b10011 : partial_products[i] = {{(N){x2_neg_Y[N]}},x2_neg_Y};
				5'b00111, 5'b01101 : partial_products[i] = {{(N+1){neg_Y[N-1]}},neg_Y};
				default          : partial_products[i] = {2*N+1{1'b0}}; 
			endcase
		end
	end
	WallaceTreeMult mul(
		.clk(clk),
		.rst(rst),
		.P1_in(partial_products[0][63:0]),
		.P2_in(partial_products[1][60:0]),
		.P3_in(partial_products[2][57:0]),
		.P4_in(partial_products[3][54:0]),
		.P5_in(partial_products[4][51:0]),
		.P6_in(partial_products[5][48:0]),
		.P7_in(partial_products[6][45:0]),
		.P8_in(partial_products[7][42:0]),
		.P9_in(partial_products[8][39:0]),
		.P10_in(partial_products[9][36:0]),
		.P11_in(partial_products[10][33:0]),
		.Out(Product)
    );
    // Assign final product
//    assign Prod = accum[2*N-1:0];

endmodule
