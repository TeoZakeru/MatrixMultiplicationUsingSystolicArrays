module WallaceTreeMult(
	input clk,
	input rst,
    input [31:0] P1_in,
    input [28:0] P2_in,
    input [25:0] P3_in,
    input [22:0] P4_in,
    input [19:0] P5_in,
    input [16:0] P6_in,
    output reg [31:0] Out
);
    reg [31:0] P1, P1_double;
    reg [28:0] P2, P2_double;
    reg [25:0] P3, P3_double;
    reg [22:0] P4, P4_double;
    reg [19:0] P5, P5_double;
    reg [16:0] P6, P6_double;
    
    // Implement CPA (CRA)
    wire [31:0] sum;
    wire [32:0] carries; // Extra bit for the final carry
        
    always @(posedge clk or negedge rst) begin
    	if(!rst) begin
    		P1 <= 0;
			P2 <= 0;
			P3 <= 0;
			P4 <= 0;
			P5 <= 0;
			P6 <= 0;	
			Out <= 0;	
    	end
    	else begin
    		P1 <= P1_in;
			P2 <= P2_in;
			P3 <= P3_in;
			P4 <= P4_in;
			P5 <= P5_in;
			P6 <= P6_in;
			Out <= sum;
    	end
    end
    
    // Stage 1 wires - using arrays
    wire [4:0] HA1_sum, HA1_carry;  // For half adders in stage 1
    wire [42:0] FA1_sum, FA1_carry; // For full adders in stage 1
    
    reg [4:0] HA1_sum_reg, HA1_carry_reg;  // For half adders in stage 1
    reg [42:0] FA1_sum_reg, FA1_carry_reg; // For full adders in stage 1
    
    // Stage 2 wires - using arrays
    wire HA_2_1_sum, HA_2_1_carry;  // Single half adder in stage 2
    wire [23:0] FA_2_sum, FA_2_carry; // For full adders in stage 2

	reg HA_2_1_sum_reg, HA_2_1_carry_reg;  // Single half adder in stage 2
    reg [23:0] FA_2_sum_reg, FA_2_carry_reg; // For full adders in stage 2
        
    // Stage 3 wires - using arrays 
    wire HA_3_1_sum, HA_3_1_carry;  // Single half adder in stage 3
    wire [18:0] FA_3_sum, FA_3_carry; // For full adders in stage 3

    //Stage 1 - Half adders and full adders
    HalfAdder HA1 (P1[6], P2[3], HA1_sum[1], HA1_carry[1]);
    FullAdder FA1 (P1[7], P2[4], P3[1], FA1_sum[1], FA1_carry[1]);
    FullAdder FA2 (P1[8], P2[5], P3[2], FA1_sum[2], FA1_carry[2]);
    FullAdder FA3 (P1[9], P2[6], P3[3], FA1_sum[3], FA1_carry[3]);
    FullAdder FA4 (P1[10], P2[7], P3[4], FA1_sum[4], FA1_carry[4]);
    FullAdder FA5 (P1[11], P2[8], P3[5], FA1_sum[5], FA1_carry[5]);
    FullAdder FA6 (P1[12], P2[9], P3[6], FA1_sum[6], FA1_carry[6]);
    HalfAdder HA2 (P4[3], P5[0], HA1_sum[2], HA1_carry[2]);
    FullAdder FA7 (P1[13], P2[10], P3[7], FA1_sum[7], FA1_carry[7]);
    HalfAdder HA3 (P4[4], P5[1], HA1_sum[3], HA1_carry[3]);
    FullAdder FA8 (P1[14], P2[11], P3[8], FA1_sum[8], FA1_carry[8]);
    HalfAdder HA4 (P4[5], P5[2], HA1_sum[4], HA1_carry[4]);
    FullAdder FA9 (P1[15], P2[12], P3[9], FA1_sum[9], FA1_carry[9]);
    FullAdder FA10 (P4[6], P5[3], P6[0], FA1_sum[10], FA1_carry[10]);
    FullAdder FA11 (P1[16], P2[13], P3[10], FA1_sum[11], FA1_carry[11]);
    FullAdder FA12 (P4[7], P5[4], P6[1], FA1_sum[12], FA1_carry[12]);
    FullAdder FA13 (P1[17], P2[14], P3[11], FA1_sum[13], FA1_carry[13]);
    FullAdder FA14 (P4[8],  P5[5],  P6[2],  FA1_sum[14], FA1_carry[14]);
    FullAdder FA15 (P1[18], P2[15], P3[12], FA1_sum[15], FA1_carry[15]);
    FullAdder FA16 (P4[9],  P5[6],  P6[3],  FA1_sum[16], FA1_carry[16]);
    FullAdder FA17 (P1[19], P2[16], P3[13], FA1_sum[17], FA1_carry[17]);
    FullAdder FA18 (P4[10], P5[7],  P6[4],  FA1_sum[18], FA1_carry[18]);
    FullAdder FA19 (P1[20], P2[17], P3[14], FA1_sum[19], FA1_carry[19]);
    FullAdder FA20 (P4[11], P5[8],  P6[5],  FA1_sum[20], FA1_carry[20]);
    FullAdder FA21 (P1[21], P2[18], P3[15], FA1_sum[21], FA1_carry[21]);
    FullAdder FA22 (P4[12], P5[9],  P6[6],  FA1_sum[22], FA1_carry[22]);
    FullAdder FA23 (P1[22], P2[19], P3[16], FA1_sum[23], FA1_carry[23]);
    FullAdder FA24 (P4[13], P5[10], P6[7],  FA1_sum[24], FA1_carry[24]);
    FullAdder FA25 (P1[23], P2[20], P3[17], FA1_sum[25], FA1_carry[25]);
    FullAdder FA26 (P4[14], P5[11], P6[8],  FA1_sum[26], FA1_carry[26]);
    FullAdder FA27 (P1[24], P2[21], P3[18], FA1_sum[27], FA1_carry[27]);
    FullAdder FA28 (P4[15], P5[12], P6[9],  FA1_sum[28], FA1_carry[28]);
    FullAdder FA29 (P1[25], P2[22], P3[19], FA1_sum[29], FA1_carry[29]);
    FullAdder FA30 (P4[16], P5[13], P6[10], FA1_sum[30], FA1_carry[30]);
    FullAdder FA31 (P1[26], P2[23], P3[20], FA1_sum[31], FA1_carry[31]);
    FullAdder FA32 (P4[17], P5[14], P6[11], FA1_sum[32], FA1_carry[32]);
    FullAdder FA33 (P1[27], P2[24], P3[21], FA1_sum[33], FA1_carry[33]);
    FullAdder FA34 (P4[18], P5[15], P6[12], FA1_sum[34], FA1_carry[34]);
    FullAdder FA35 (P1[28], P2[25], P3[22], FA1_sum[35], FA1_carry[35]);
    FullAdder FA36 (P4[19], P5[16], P6[13], FA1_sum[36], FA1_carry[36]);
    FullAdder FA37 (P1[29], P2[26], P3[23], FA1_sum[37], FA1_carry[37]);
    FullAdder FA38 (P4[20], P5[17], P6[14], FA1_sum[38], FA1_carry[38]);
    FullAdder FA39 (P1[30], P2[27], P3[24], FA1_sum[39], FA1_carry[39]);
    FullAdder FA40 (P4[21], P5[18], P6[15], FA1_sum[40], FA1_carry[40]);
    FullAdder FA41 (P1[31], P2[28], P3[25], FA1_sum[41], FA1_carry[41]);
    FullAdder FA42 (P4[22], P5[19], P6[16], FA1_sum[42], FA1_carry[42]);

    // Stage 2
    HalfAdder HA_2_1 (FA1_sum[3], FA1_carry[2], HA_2_1_sum, HA_2_1_carry);
    FullAdder FA_2_2 (FA1_sum[4], FA1_carry[3], P4[1], FA_2_sum[2], FA_2_carry[2]);
    FullAdder FA_2_3 (FA1_sum[5], FA1_carry[4], P4[2], FA_2_sum[3], FA_2_carry[3]);
    FullAdder FA_2_4 (FA1_sum[6], FA1_carry[5], HA1_sum[2], FA_2_sum[4], FA_2_carry[4]);
    FullAdder FA_2_5 (FA1_sum[7], FA1_carry[6], HA1_sum[3], FA_2_sum[5], FA_2_carry[5]);
    FullAdder FA_2_6 (FA1_sum[8], FA1_carry[7], HA1_sum[4], FA_2_sum[6], FA_2_carry[6]);
    FullAdder FA_2_7 (FA1_sum[9], FA1_sum[10], FA1_carry[8], FA_2_sum[7], FA_2_carry[7]);
    FullAdder FA_2_8 (FA1_sum[11], FA1_sum[12], FA1_carry[9], FA_2_sum[8], FA_2_carry[8]);
    FullAdder FA_2_9 (FA1_sum[13], FA1_sum[14], FA1_carry[11], FA_2_sum[9], FA_2_carry[9]);
    FullAdder FA_2_10 (FA1_sum[15], FA1_sum[16], FA1_carry[13], FA_2_sum[10], FA_2_carry[10]);
    FullAdder FA_2_11 (FA1_sum[17], FA1_sum[18], FA1_carry[15], FA_2_sum[11], FA_2_carry[11]);
    FullAdder FA_2_12 (FA1_sum[19], FA1_sum[20], FA1_carry[17], FA_2_sum[12], FA_2_carry[12]);
    FullAdder FA_2_13 (FA1_sum[21], FA1_sum[22], FA1_carry[19], FA_2_sum[13], FA_2_carry[13]);
    FullAdder FA_2_14 (FA1_sum[23], FA1_sum[24], FA1_carry[21], FA_2_sum[14], FA_2_carry[14]);
    FullAdder FA_2_15 (FA1_sum[25], FA1_sum[26], FA1_carry[23], FA_2_sum[15], FA_2_carry[15]);
    FullAdder FA_2_16 (FA1_sum[27], FA1_sum[28], FA1_carry[25], FA_2_sum[16], FA_2_carry[16]);
    FullAdder FA_2_17 (FA1_sum[29], FA1_sum[30], FA1_carry[27], FA_2_sum[17], FA_2_carry[17]);
    FullAdder FA_2_18 (FA1_sum[31], FA1_sum[32], FA1_carry[29], FA_2_sum[18], FA_2_carry[18]);
    FullAdder FA_2_19 (FA1_sum[33], FA1_sum[34], FA1_carry[31], FA_2_sum[19], FA_2_carry[19]);
    FullAdder FA_2_20 (FA1_sum[35], FA1_sum[36], FA1_carry[33], FA_2_sum[20], FA_2_carry[20]);
    FullAdder FA_2_21 (FA1_sum[37], FA1_sum[38], FA1_carry[35], FA_2_sum[21], FA_2_carry[21]);
    FullAdder FA_2_22 (FA1_sum[39], FA1_sum[40], FA1_carry[37], FA_2_sum[22], FA_2_carry[22]);
    FullAdder FA_2_23 (FA1_sum[41], FA1_sum[42], FA1_carry[39], FA_2_sum[23], FA_2_carry[23]);
    
    always @(posedge clk or negedge rst) begin
    	if(!rst) begin
    		FA1_sum_reg <= 0;
    		FA1_carry_reg <= 0;
    		
    		HA1_sum_reg <= 0;
    		HA1_carry_reg <= 0;
    		
    		HA_2_1_sum_reg <= 0;
    		HA_2_1_carry_reg <= 0;
    		
    		FA_2_sum_reg <= 0;
    		FA_2_carry_reg <= 0;
    		
    		P1_double <= 0;
    		P2_double <= 0;
    		P3_double <= 0;
    		P4_double <= 0;
    		P5_double <= 0;
    		P6_double <= 0;
    	end
    	else begin
    		FA1_sum_reg <= FA1_sum;
    		FA1_carry_reg <= FA1_carry;
    		
    		HA1_sum_reg <= HA1_sum;
    		HA1_carry_reg <= HA1_carry;
    		
    		HA_2_1_sum_reg <= HA_2_1_sum;
    		HA_2_1_carry_reg <= HA_2_1_carry;
    		
    		FA_2_sum_reg <= FA_2_sum;
    		FA_2_carry_reg <= FA_2_carry;
    		
    		P1_double <= P1;
    		P2_double <= P2;
    		P3_double <= P3;
    		P4_double <= P4;
    		P5_double <= P5;
    		P6_double <= P6;
    	end
   	end
    
    // Stage 3
    HalfAdder HA_3_1 (FA_2_sum_reg[5], HA1_carry_reg[2], HA_3_1_sum, HA_3_1_carry);
    FullAdder FA_3_1 (FA_2_sum_reg[6], FA_2_carry_reg[5], HA1_carry_reg[3], FA_3_sum[1], FA_3_carry[1]);
    FullAdder FA_3_2 (FA_2_sum_reg[7], FA_2_carry_reg[6], HA1_carry_reg[4], FA_3_sum[2], FA_3_carry[2]);
    FullAdder FA_3_3 (FA_2_sum_reg[8], FA_2_carry_reg[7], FA1_carry_reg[10], FA_3_sum[3], FA_3_carry[3]);
    FullAdder FA_3_4 (FA_2_sum_reg[9], FA_2_carry_reg[8], FA1_carry_reg[12], FA_3_sum[4], FA_3_carry[4]);
    FullAdder FA_3_5 (FA_2_sum_reg[10], FA_2_carry_reg[9], FA1_carry_reg[14], FA_3_sum[5], FA_3_carry[5]);
    FullAdder FA_3_6 (FA_2_sum_reg[11], FA_2_carry_reg[10], FA1_carry_reg[16], FA_3_sum[6], FA_3_carry[6]);
    FullAdder FA_3_7 (FA_2_sum_reg[12], FA_2_carry_reg[11], FA1_carry_reg[18], FA_3_sum[7], FA_3_carry[7]);
    FullAdder FA_3_8 (FA_2_sum_reg[13], FA_2_carry_reg[12], FA1_carry_reg[20], FA_3_sum[8], FA_3_carry[8]);
    FullAdder FA_3_9 (FA_2_sum_reg[14], FA_2_carry_reg[13], FA1_carry_reg[22], FA_3_sum[9], FA_3_carry[9]);
    FullAdder FA_3_10 (FA_2_sum_reg[15], FA_2_carry_reg[14], FA1_carry_reg[24], FA_3_sum[10], FA_3_carry[10]);
    FullAdder FA_3_11 (FA_2_sum_reg[16], FA_2_carry_reg[15], FA1_carry_reg[26], FA_3_sum[11], FA_3_carry[11]);
    FullAdder FA_3_12 (FA_2_sum_reg[17], FA_2_carry_reg[16], FA1_carry_reg[28], FA_3_sum[12], FA_3_carry[12]);
    FullAdder FA_3_13 (FA_2_sum_reg[18], FA_2_carry_reg[17], FA1_carry_reg[30], FA_3_sum[13], FA_3_carry[13]);
    FullAdder FA_3_14 (FA_2_sum_reg[19], FA_2_carry_reg[18], FA1_carry_reg[32], FA_3_sum[14], FA_3_carry[14]);
    FullAdder FA_3_15 (FA_2_sum_reg[20], FA_2_carry_reg[19], FA1_carry_reg[34], FA_3_sum[15], FA_3_carry[15]);
    FullAdder FA_3_16 (FA_2_sum_reg[21], FA_2_carry_reg[20], FA1_carry_reg[36], FA_3_sum[16], FA_3_carry[16]);
    FullAdder FA_3_17 (FA_2_sum_reg[22], FA_2_carry_reg[21], FA1_carry_reg[38], FA_3_sum[17], FA_3_carry[17]);
    FullAdder FA_3_18 (FA_2_sum_reg[23], FA_2_carry_reg[22], FA1_carry_reg[40], FA_3_sum[18], FA_3_carry[18]);

    // Final Addition Stage using Carry Propagate Adder
    wire [31:0] arg1 = {
        FA_3_sum[18], FA_3_sum[17], FA_3_sum[16], FA_3_sum[15], 
        FA_3_sum[14], FA_3_sum[13], FA_3_sum[12], FA_3_sum[11], 
        FA_3_sum[10], FA_3_sum[9], FA_3_sum[8], FA_3_sum[7], 
        FA_3_sum[6], FA_3_sum[5], FA_3_sum[4], FA_3_sum[3],
        FA_3_sum[2], FA_3_sum[1], HA_3_1_sum, FA_2_sum_reg[4], 
        FA_2_sum_reg[3], FA_2_sum_reg[2], HA_2_1_sum_reg, FA1_sum_reg[2], 
        FA1_sum_reg[1], HA1_sum_reg[1], P1_double[5], P1_double[4], P1_double[3], P1_double[2], P1_double[1], P1_double[0]
    };
    
    wire [31:0] arg2 = {
        FA_3_carry[17], FA_3_carry[16], FA_3_carry[15], 
        FA_3_carry[14], FA_3_carry[13], FA_3_carry[12], FA_3_carry[11],
        FA_3_carry[10], FA_3_carry[9], FA_3_carry[8], FA_3_carry[7],
        FA_3_carry[6], FA_3_carry[5], FA_3_carry[4], FA_3_carry[3],
        FA_3_carry[2], FA_3_carry[1], HA_3_1_carry, FA_2_carry_reg[4],
        FA_2_carry_reg[3], FA_2_carry_reg[2], HA_2_1_carry_reg, P4_double[0], 
        FA1_carry_reg[1], HA1_carry_reg[1], P3_double[0], P2_double[2], P2_double[1], P2_double[0], 1'b0, 1'b0, 1'b0
    };
    
    
    
    // Initialize first carry-in
    assign carries[0] = 1'b0;
    
    // Generate all the carries and sums
    genvar i;
    generate
      for (i = 0; i < 32; i = i + 1) begin: cpa_loop
        assign sum[i] = arg1[i] ^ arg2[i] ^ carries[i];
        assign carries[i+1] = (arg1[i] & arg2[i]) | (arg1[i] & carries[i]) | (arg2[i] & carries[i]);
      end
    endgenerate
    
    // Assign the final output
//    assign Out = sum;
    
endmodule