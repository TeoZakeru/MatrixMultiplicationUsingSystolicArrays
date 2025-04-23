module RCA#(parameter N = 8)(
    input  signed [N-1:0] Y,
    output signed [N+1:0] x3_Y
);
    wire signed [N:0] x2_Y;       // Y << 1 (sign-extended)
    wire signed [N:0] arg1_reg;   // x2_Y
    wire signed [N:0] arg2_reg;   // sign-extended Y
    wire [N:0] sum;
    wire [N+1:0] carries;

    // Left shift Y and sign-extend: x2_Y = (Y <<< 1)
    assign x2_Y = {Y[N-1], Y} << 1;

    // Sign-extend Y to match x2_Y
    assign arg1_reg = x2_Y;
    assign arg2_reg = {Y[N-1], Y}; // Sign-extend Y to N+1 bits

    assign carries[0] = 1'b0;

    genvar i;
    generate
        for (i = 0; i <= N; i = i + 1) begin: cpa_loop
            assign sum[i] = arg1_reg[i] ^ arg2_reg[i] ^ carries[i];
            assign carries[i+1] = (arg1_reg[i] & arg2_reg[i]) |
                                  (arg1_reg[i] & carries[i])  |
                                  (arg2_reg[i] & carries[i]);
        end
    endgenerate

    // Combine final carry and sum bits; cast to signed
    assign x3_Y = {carries[N+1], sum};

endmodule

