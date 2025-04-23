module radix4_booth_multiplier #(parameter N = 8) (
    input  signed [N-1:0] a,  // Multiplicand
    input  signed [N-1:0] b,  // Multiplier
    input clk, 
    input rst,
    output reg signed [2*N-1:0] Prod // Product
);
    localparam NUM_PARTIALS = (N + 2) / 2; // Compute ceil(N/3)	
    reg signed [N-1:0] a_reg, b_reg;
    reg signed [2*N:0] partial_products [NUM_PARTIALS-1:0]; // Array to store partial products
    wire signed [2*N+1:0] accum; // Accumulator for final sum
    wire [N+3:0] Q;
    wire signed [N-1:0] neg_A;
    wire signed [N:0] x2_A;
    wire signed [N:0] x2_neg_A;
    wire signed [N+1:0] x3_A;
    wire signed [N+1:0] x3_neg_A;
    wire signed [N+1:0] x4_A;
    wire signed [N+1:0] x4_neg_A;
    wire signed [N-1:0] A,B;
    wire signed [2*N-1:0] Product;
    
    integer i;
	always @(*) begin
		for (i = 0; i < NUM_PARTIALS; i = i + 1) begin : booth_encoding
			if (!rst) begin
				partial_products[i] = 0;
			end else begin
				case ({Q[2*i+2], Q[2*i+1], Q[2*i]})
					3'b000, 3'b111: partial_products[i] = 0;
					3'b001, 3'b010: partial_products[i] = {{(2*N+1-N){A[N-1]}}, A};       // +A
					3'b011        : partial_products[i] = {{(2*N+1-(N+1)){x2_A[N]}}, x2_A};  // +2A
					3'b100        : partial_products[i] = {{(2*N+1-(N+1)){x2_neg_A[N]}}, x2_neg_A};   // -2A
					3'b101, 3'b110: partial_products[i] = {{(2*N+1-N){neg_A[N-1]}}, neg_A}; // -A
					default:        partial_products[i] = 0;
				endcase
			end
		end
	end
	
	always @(posedge clk or negedge rst) begin
		if(!rst) begin
			Prod <= 0;
			a_reg <= 0;
			b_reg <= 0;
		end
		else begin
			Prod <= Product;
			a_reg <= a;
			b_reg <= b;
		end
	end
	
	 WallaceTreeMult mult(
	 	.clk(clk),
	 	.rst(rst),
		.P1_in(partial_products[0][31:0]),
		.P2_in(partial_products[1][29:0]),
		.P3_in(partial_products[2][27:0]),
		.P4_in(partial_products[3][25:0]),
		.P5_in(partial_products[4][23:0]),
		.P6_in(partial_products[5][21:0]),
		.P7_in(partial_products[6][19:0]),
		.P8_in(partial_products[7][17:0]),
		.Out(Product)
    );
    
    assign Q = {{3{B[N-1]}},B[N-1:0],1'b0};
    assign A = (a_reg[N-1] & b_reg[N-1]) ? (~a_reg + 1) : (b_reg[N-1] ? b_reg : a_reg);
    assign B = (a_reg[N-1] & b_reg[N-1]) ? (~b_reg + 1) : (b_reg[N-1] ? a_reg : b_reg);
    // Compute 2's complement negation
    assign neg_A = ~A + 1'b1;  
    
    // Compute positive multiples with sign extension
    assign x2_A = {A[N-1], A} << 1;  // 2A
    assign x3_A = ({{2{A[N-1]}}, A} << 1) + {{2{A[N-1]}}, A}; // 3A = (2A + A)
    assign x4_A = {{2{A[N-1]}}, A} << 2;  // 4A
    // Compute negative multiples using 2's complement
    assign x2_neg_A = (~{A[N-1], A} + 1'b1) << 1;  // -2A
    assign x3_neg_A = {x2_neg_A[N-1],x2_neg_A} + {{2{neg_A[N-1]}},neg_A};// -3A
    assign x4_neg_A = (~{{2{A[N-1]}}, A} + 1'b1) << 2;  // -4A
        
endmodule