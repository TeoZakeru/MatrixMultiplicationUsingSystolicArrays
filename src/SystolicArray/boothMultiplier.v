module radix8_booth_multiplier #(parameter N = 8) (
    input  signed [N-1:0] a,  // Multiplicand
    input  signed [N-1:0] b,  // Multiplier
    output signed [2*N-1:0] Prod // Product
);

    localparam NUM_PARTIALS = (N + 2) / 3; // Compute ceil(N/3)
    
    reg signed [2*N:0] partial_products [NUM_PARTIALS-1:0]; // Array to store partial products
    wire signed [2*N+1:0] accum; // Final sum accumulation
    wire signed [N+3:0] Q;
    
    // Booth encoding control signals
    wire signed [3:0] booth_code [NUM_PARTIALS-1:0];  
    wire signed [N-1:0] neg_A;
    wire signed [N:0] x2_A, x2_neg_A;
    wire signed [N+1:0] x3_A, x3_neg_A, x4_A, x4_neg_A;
    wire signed [N-1:0] A, B;

    assign Q = {{3{B[N-1]}}, B, 1'b0}; // Extend sign for Booth encoding
    assign A = (a[N-1] & b[N-1]) ? (~a + 1) : (b[N-1] ? b : a);
    assign B = (a[N-1] & b[N-1]) ? (~b + 1) : (b[N-1] ? a : b);
    
    // Compute 2's complement negation
    assign neg_A = ~A + 1'b1;  
    
    // Compute positive multiples
    assign x2_A = {A[N-1], A} << 1;  // 2A
    assign x3_A = ({{2{A[N-1]}}, A} << 1) + {{2{A[N-1]}}, A}; // 3A = 2A + A
    assign x4_A = {{2{A[N-1]}}, A} << 2;  // 4A

    // Compute negative multiples
    assign x2_neg_A = (~{A[N-1], A} + 1'b1) << 1;  // -2A
    assign x3_neg_A = {x2_neg_A[N-1], x2_neg_A} + {{2{neg_A[N-1]}}, neg_A}; // -3A
    assign x4_neg_A = (~{{2{A[N-1]}}, A} + 1'b1) << 2;  // -4A

    // Generate booth codes
    genvar i;
    generate
        for (i = 0; i < NUM_PARTIALS; i = i + 1) begin
            assign booth_code[i] = {Q[(3*i+3)], Q[(3*i+2)], Q[(3*i+1)], Q[3*i]};
        end
    endgenerate

    // Generate partial products
    generate
        for (i = 0; i < NUM_PARTIALS; i = i + 1) begin : booth_gen
            always @(*) begin
                case (booth_code[i])
                    4'b0000, 4'b1111 : partial_products[i] = {2*N+1{1'b0}};
                    4'b0001, 4'b0010 : partial_products[i] = A;
                    4'b0011, 4'b0100 : partial_products[i] = x2_A;
                    4'b0101, 4'b0110 : partial_products[i] = x3_A;
                    4'b0111          : partial_products[i] = x4_A;
                    4'b1000          : partial_products[i] = x4_neg_A;
                    4'b1001, 4'b1010 : partial_products[i] = x3_neg_A;
                    4'b1011, 4'b1100 : partial_products[i] = x2_neg_A;
                    4'b1101, 4'b1110 : partial_products[i] = neg_A;
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
