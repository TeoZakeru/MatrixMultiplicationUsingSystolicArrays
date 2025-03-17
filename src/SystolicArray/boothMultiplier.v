module radix8_booth_multiplier #(parameter N = 8) (
	input [N-1:0] Y_in, 
	input [N+1:0] x3_Y_in, 
    input [((N+2)/3)-1:0] s_in,
	input [((N+2)/3)-1:0] t_in,
	input [((N+2)/3)-1:0] d_in,
	input [((N+2)/3)-1:0] q_in,
	input [((N+2)/3)-1:0] n_in,
    output [2*N-1:0] Prod // Product
);

    localparam NUM_PARTIALS = (N + 2) / 3; // Compute ceil(N/3)
    
    reg [2*N:0] partial_products [NUM_PARTIALS-1:0]; // Array to store partial products
    wire [2*N+1:0] accum; // Final sum accumulation
    
    // Booth encoding control signals
    wire [N-1:0] neg_Y;
    wire [N:0] x2_Y, x2_neg_Y;
    wire [N+1:0] x3_neg_Y, x4_Y, x4_neg_Y;

    
    // Compute 2's complement negation
    assign neg_Y = ~Y_in + 1'b1;  
    
    // Compute positive multiples
    assign x2_Y = {Y_in[N-1], Y_in} << 1;  // 2A
    assign x4_Y = {{2{Y_in[N-1]}}, Y_in} << 2;  // 4A

    // Compute negative multiples
    assign x2_neg_Y = (~{Y_in[N-1], Y_in} + 1'b1) << 1;  // -2A
    assign x3_neg_Y = ~x3_Y_in + 1'b1; // -3A
    assign x4_neg_Y = (~{{2{Y_in[N-1]}}, Y_in} + 1'b1) << 2;  // -4A

	genvar i;
    // Generate partial products
    generate
        for (i = 0; i < NUM_PARTIALS; i = i + 1) begin : booth_gen
            always @(*) begin
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
    endgenerate

    // Combinational accumulation of all partial products
    assign accum = 
        (partial_products[0] << (3*0)) +
        (NUM_PARTIALS > 1 ? (partial_products[1] << (3*1)) : 0) +
        (NUM_PARTIALS > 2 ? (partial_products[2] << (3*2)) : 0) +
        (NUM_PARTIALS > 3 ? (partial_products[3] << (3*3)) : 0) +
        (NUM_PARTIALS > 4 ? (partial_products[4] << (3*4)) : 0);

    // Assign final product
    assign Prod = accum[2*N-1:0];

endmodule
