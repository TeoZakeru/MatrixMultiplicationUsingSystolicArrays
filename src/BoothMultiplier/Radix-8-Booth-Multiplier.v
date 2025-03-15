module radix8_booth_multiplier #(parameter N = 8) (
    input  signed [N-1:0] a,  // Multiplicand
    input  signed [N-1:0] b,  // Multiplier
    input clk, 
    input reset,
    output reg signed [2*N-1:0] Prod // Product
);

    reg signed [2*N:0] partial_products [(N/3)-1:0]; // Array to store partial products
    reg signed [2*N+1:0] accum; // Accumulator for final sum
    wire signed [2*N-1:0] P; 
    reg [N-1:0] i;
    integer j;
    wire [N+3:0] Q;
    // Booth encoding control signals
    reg signed [3:0] booth_code;  // 4-bit group + extra sign bit
    reg signed [2*N:0] booth_multiple; // Holds Y, 2Y, 3Y, 4Y
    wire signed [N-1:0] neg_A;
    wire signed [N:0] x2_A;
    wire signed [N:0] x2_neg_A;
    wire signed [N+1:0] x3_A;
    wire signed [N+1:0] x3_neg_A;
    wire signed [N+1:0] x4_A;
    wire signed [N+1:0] x4_neg_A;
    wire signed [N-1:0] A,B;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            i = 0;
            accum = {2*N+1{1'b0}}; // Initialize accumulator
            booth_code = { Q[3], Q[2], Q[1], Q[0]};
            for (j = 0; j <(N/3); j = j + 1) begin
                partial_products[j] = 0;  // Reset each element to 0
            end
        end
        else begin
            if (i < N/3) begin
                case (booth_code)
                    4'b0000 : partial_products[i] = {2*N+1{1'b0}};
                    4'b0001 : partial_products[i] = A;
                    4'b0010 : partial_products[i] = A;
                    4'b0011 : partial_products[i] = x2_A;
                    4'b0100 : partial_products[i] = x2_A;
                    4'b0101 : partial_products[i] = x3_A;
                    4'b0110 : partial_products[i] = x3_A;
                    4'b0111 : partial_products[i] = x4_A;
                    4'b1000 : partial_products[i] = x4_neg_A;
                    4'b1001 : partial_products[i] = x3_neg_A;
                    4'b1010 : partial_products[i] = x3_neg_A;
                    4'b1011 : partial_products[i] = x2_neg_A;
                    4'b1100 : partial_products[i] = x2_neg_A;
                    4'b1101 : partial_products[i] = neg_A;
                    4'b1110 : partial_products[i] = neg_A;
                    4'b1111 : partial_products[i] = {2*N+1{1'b0}};
                endcase
    
                // Shift and accumulate
                accum = accum + (partial_products[i] << (3*(i)));
//                if( i < ((N/3)-1)) begin
//                    booth_code = {B[((i+1)*N/3)+3], B[((i+1)*N/3)+2], B[((i+1)*N/3+1)], B[((i+1)*N/3)]};
//                end
//                else begin
//                    booth_code = {1'd0, B[((i+1)*N/3)+2], B[((i+1)*N/3+1)], B[((i+1)*N/3)]};
//                end
                booth_code = {Q[((i+1)*N/3)+3], Q[((i+1)*N/3)+2], Q[((i+1)*N/3+1)], Q[((i+1)*N/3)]};
                i = i + 1;
            end
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            Prod = 'd0;
        end
        else begin
            if (i == N/3) begin
                Prod = accum[2*N-1:0];
            end         
        end
    end
    
    assign Q = {{3{B[N-1]}},B[N-1:0],1'b0};
    assign A = (a[N-1] & b[N-1]) ? (~a + 1) : (b[N-1] ? b : a);
    assign B = (a[N-1] & b[N-1]) ? (~b + 1) : (b[N-1] ? a : b);
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
        
    assign P = accum[2*N-1:0]; // Output the final product

endmodule
