module WallaceTreeMult(
	input clk,
	input rst,
    input [31:0] P1_in,
    input [29:0] P2_in,
    input [27:0] P3_in,
    input [25:0] P4_in,
    input [23:0] P5_in,
    input [21:0] P6_in,
    input [19:0] P7_in,
    input [17:0] P8_in,
    output reg [31:0] Out
    );
    
    reg [31:0] P1, P1_double, P1_triple;
	reg [29:0] P2, P2_double, P2_triple;
	reg [27:0] P3, P3_double, P3_triple;
	reg [25:0] P4, P4_double, P4_triple;
	reg [23:0] P5, P5_double, P5_triple;
	reg [21:0] P6, P6_double, P6_triple;
	reg [19:0] P7, P7_double, P7_triple;
	reg [17:0] P8, P8_double, P8_triple;
	
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
			P7 <= 0;
			P8 <= 0;
			Out <= 0;
    	end
    	else begin
    		P1 <= P1_in;
			P2 <= P2_in;
			P3 <= P3_in;
			P4 <= P4_in;
			P5 <= P5_in;
			P6 <= P6_in;
			P7 <= P7_in;
			P8 <= P8_in;
			Out <= sum;
    	end
    end
	
    // Stage 1 wires
    wire [21:1] HA_sum, HA_carry;  // Half Adder signals for stage 1
    wire [49:1] FA_sum, FA_carry;  // Full Adder signals for stage 1
    
    reg [21:1] HA_sum_reg, HA_carry_reg;
    reg [49:1] FA_sum_reg, FA_carry_reg;
    
    // Stage 2 wires
    wire [4:1] HA_2_sum, HA_2_carry;  // Half Adder signals for stage 2
    wire [42:1] FA_2_sum, FA_2_carry;  // Full Adder signals for stage 2
    
    reg [4:1] HA_2_sum_reg, HA_2_carry_reg;  // Half Adder signals for stage 2
    reg [42:1] FA_2_sum_reg, FA_2_carry_reg;  // Full Adder signals for stage 2
    
    // Stage 3 wires
    wire HA_3_1_sum, HA_3_1_carry;
    wire [22:1] FA_3_sum, FA_3_carry;  // Full Adder signals for stage 3
    
    // Stage 4 wires
    wire HA_4_1_sum, HA_4_1_carry;
    wire [18:1] FA_4_sum, FA_4_carry;  // Full Adder signals for stage 4
    
    //Step-1
    HalfAdder HA1 (P1[4], P2[2], HA_sum[1], HA_carry[1]);
    FullAdder FA1 (P1[5], P2[3], P3[1], FA_sum[1], FA_carry[1]);
    FullAdder FA2 (P1[6], P2[4], P3[2], FA_sum[2], FA_carry[2]);
    FullAdder FA3 (P1[7], P2[5], P3[3], FA_sum[3], FA_carry[3]);
    FullAdder FA4 (P1[8], P2[6], P3[4], FA_sum[4], FA_carry[4]);
    HalfAdder HA2 (P4[2], P5[0], HA_sum[2], HA_carry[2]);
    FullAdder FA5 (P1[9], P2[7], P3[5], FA_sum[5], FA_carry[5]);
    HalfAdder HA3 (P4[3], P5[1], HA_sum[3], HA_carry[3]);

    
    FullAdder FA6 (P1[10], P2[8], P3[6], FA_sum[6], FA_carry[6]);
    FullAdder FA7 (P4[4], P5[2], P6[0], FA_sum[7], FA_carry[7]);

    FullAdder FA8 (P1[11], P2[9], P3[7], FA_sum[8], FA_carry[8]);
    FullAdder FA9 (P4[5], P5[3], P6[1], FA_sum[9], FA_carry[9]);

    FullAdder FA10 (P1[12], P2[10], P3[8], FA_sum[10], FA_carry[10]);
    FullAdder FA11 (P4[6], P5[4], P6[2], FA_sum[11], FA_carry[11]);
    
    FullAdder FA12 (P1[13], P2[11], P3[9], FA_sum[12], FA_carry[12]);
    FullAdder FA13 (P4[7], P5[5], P6[3], FA_sum[13], FA_carry[13]);

    FullAdder FA14 (P1[14], P2[12], P3[10], FA_sum[14], FA_carry[14]);
    FullAdder FA15 (P4[8], P5[6], P6[4], FA_sum[15], FA_carry[15]);
    HalfAdder HA4 (P7[2], P8[0], HA_sum[4], HA_carry[4]);

    FullAdder FA16 (P1[15], P2[13], P3[11], FA_sum[16], FA_carry[16]);
    FullAdder FA17 (P4[9], P5[7], P6[5], FA_sum[17], FA_carry[17]);
    HalfAdder HA5 (P7[3], P8[1], HA_sum[5], HA_carry[5]);

    FullAdder FA18 (P1[16], P2[14], P3[12], FA_sum[18], FA_carry[18]);
    FullAdder FA19 (P4[10], P5[8], P6[6], FA_sum[19], FA_carry[19]);
    HalfAdder HA6 (P7[4], P8[2], HA_sum[6], HA_carry[6]);

    FullAdder FA20 (P1[17], P2[15], P3[13], FA_sum[20], FA_carry[20]);
    FullAdder FA21 (P4[11], P5[9], P6[7], FA_sum[21], FA_carry[21]);
    HalfAdder HA7 (P7[5], P8[3], HA_sum[7], HA_carry[7]);

    FullAdder FA22 (P1[18], P2[16], P3[14], FA_sum[22], FA_carry[22]);
    FullAdder FA23 (P4[12], P5[10], P6[8], FA_sum[23], FA_carry[23]);
    HalfAdder HA8 (P7[6], P8[4], HA_sum[8], HA_carry[8]);

    FullAdder FA24 (P1[19], P2[17], P3[15], FA_sum[24], FA_carry[24]);
    FullAdder FA25 (P4[13], P5[11], P6[9], FA_sum[25], FA_carry[25]);
    HalfAdder HA9 (P7[7], P8[5], HA_sum[9], HA_carry[9]);

    FullAdder FA26 (P1[20], P2[18], P3[16], FA_sum[26], FA_carry[26]);
    FullAdder FA27 (P4[14], P5[12], P6[10], FA_sum[27], FA_carry[27]);
    HalfAdder HA10 (P7[8], P8[6], HA_sum[10], HA_carry[10]);

    FullAdder FA28 (P1[21], P2[19], P3[17], FA_sum[28], FA_carry[28]);
    FullAdder FA29 (P4[15], P5[13], P6[11], FA_sum[29], FA_carry[29]);
    HalfAdder HA11 (P7[9], P8[7], HA_sum[11], HA_carry[11]);

    FullAdder FA30 (P1[22], P2[20], P3[18], FA_sum[30], FA_carry[30]);
    FullAdder FA31 (P4[16], P5[14], P6[12], FA_sum[31], FA_carry[31]);
    HalfAdder HA12 (P7[10], P8[8], HA_sum[12], HA_carry[12]);

    FullAdder FA32 (P1[23], P2[21], P3[19], FA_sum[32], FA_carry[32]);
    FullAdder FA33 (P4[17], P5[15], P6[13], FA_sum[33], FA_carry[33]);
    HalfAdder HA13 (P7[11], P8[9], HA_sum[13], HA_carry[13]);

    FullAdder FA34 (P1[24], P2[22], P3[20], FA_sum[34], FA_carry[34]);
    FullAdder FA35 (P4[18], P5[16], P6[14], FA_sum[35], FA_carry[35]);
    HalfAdder HA14 (P7[12], P8[10], HA_sum[14], HA_carry[14]);

    FullAdder FA36 (P1[25], P2[23], P3[21], FA_sum[36], FA_carry[36]);
    FullAdder FA37 (P4[19], P5[17], P6[15], FA_sum[37], FA_carry[37]);
    HalfAdder HA15 (P7[13], P8[11], HA_sum[15], HA_carry[15]);

    FullAdder FA38 (P1[26], P2[24], P3[22], FA_sum[38], FA_carry[38]);
    FullAdder FA39 (P4[20], P5[18], P6[16], FA_sum[39], FA_carry[39]);
    HalfAdder HA16 (P7[14], P8[12], HA_sum[16], HA_carry[16]);

    FullAdder FA40 (P1[27], P2[25], P3[23], FA_sum[40], FA_carry[40]);
    FullAdder FA41 (P4[21], P5[19], P6[17], FA_sum[41], FA_carry[41]);
    HalfAdder HA17 (P7[15], P8[13], HA_sum[17], HA_carry[17]);

    FullAdder FA42 (P1[28], P2[26], P3[24], FA_sum[42], FA_carry[42]);
    FullAdder FA43 (P4[22], P5[20], P6[18], FA_sum[43], FA_carry[43]);
    HalfAdder HA18 (P7[16], P8[14], HA_sum[18], HA_carry[18]);

    FullAdder FA44 (P1[29], P2[27], P3[25], FA_sum[44], FA_carry[44]);
    FullAdder FA45 (P4[23], P5[21], P6[19], FA_sum[45], FA_carry[45]);
    HalfAdder HA19 (P7[17], P8[15], HA_sum[19], HA_carry[19]);

    FullAdder FA46 (P1[30], P2[28], P3[26], FA_sum[46], FA_carry[46]);
    FullAdder FA47 (P4[24], P5[22], P6[20], FA_sum[47], FA_carry[47]);
    HalfAdder HA20 (P7[18], P8[16], HA_sum[20], HA_carry[20]);

    FullAdder FA48 (P1[31], P2[29], P3[27], FA_sum[48], FA_carry[48]);
    FullAdder FA49 (P4[25], P5[23], P6[21], FA_sum[49], FA_carry[49]);
    HalfAdder HA21 (P7[19], P8[17], HA_sum[21], HA_carry[21]);


	HalfAdder HA_2_1 (FA_sum[2], FA_carry[1], HA_2_sum[1], HA_2_carry[1]);
    FullAdder FA_2_1 (FA_sum[3], FA_carry[2], P4[1], FA_2_sum[1], FA_2_carry[1]);
    FullAdder FA_2_2 (FA_sum[4], FA_carry[3], HA_sum[2], FA_2_sum[2], FA_2_carry[2]);
    FullAdder FA_2_3 (FA_sum[5], FA_carry[4], HA_sum[3], FA_2_sum[3], FA_2_carry[3]);
    FullAdder FA_2_4 (FA_sum[6], FA_carry[5], FA_sum[7], FA_2_sum[4], FA_2_carry[4]);
    FullAdder FA_2_5 (FA_sum[8], FA_carry[6], FA_sum[9], FA_2_sum[5], FA_2_carry[5]);
    
    FullAdder FA_2_6 (FA_sum[10], FA_sum[11], FA_carry[8], FA_2_sum[6], FA_2_carry[6]);
    HalfAdder HA_2_2 (FA_carry[9], P7[0], HA_2_sum[2], HA_2_carry[2]);
    
    FullAdder FA_2_7 (FA_sum[12], FA_sum[13], FA_carry[10], FA_2_sum[7], FA_2_carry[7]);
    HalfAdder HA_2_3 (FA_carry[11], P7_double[1], HA_2_sum[3], HA_2_carry[3]);
    
    FullAdder FA_2_8 (FA_sum[14], FA_sum[15], HA_sum[4], FA_2_sum[8], FA_2_carry[8]);
    HalfAdder HA_2_4 (FA_carry[12], FA_carry[13], HA_2_sum[4], HA_2_carry[4]);

    FullAdder FA_2_9 (FA_sum[16], FA_sum[17], HA_sum[5], FA_2_sum[9], FA_2_carry[9]);
    FullAdder FA_2_10 (FA_carry[14], FA_carry[15], HA_carry[4], FA_2_sum[10], FA_2_carry[10]);

    FullAdder FA_2_11 (FA_sum[18], FA_sum[19], HA_sum[6], FA_2_sum[11], FA_2_carry[11]);
    FullAdder FA_2_12 (FA_carry[16], FA_carry[17], HA_carry[5], FA_2_sum[12], FA_2_carry[12]);
    
    FullAdder FA_2_13 (FA_sum[20], FA_sum[21], HA_sum[7], FA_2_sum[13], FA_2_carry[13]);
    FullAdder FA_2_14 (FA_carry[18], FA_carry[19], HA_carry[6], FA_2_sum[14], FA_2_carry[14]);

    FullAdder FA_2_15 (FA_sum[22], FA_sum[23], HA_sum[8], FA_2_sum[15], FA_2_carry[15]);
    FullAdder FA_2_16 (FA_carry[20], FA_carry[21], HA_carry[7], FA_2_sum[16], FA_2_carry[16]);

    FullAdder FA_2_17 (FA_sum[24], FA_sum[25], HA_sum[9], FA_2_sum[17], FA_2_carry[17]);
    FullAdder FA_2_18 (FA_carry[22], FA_carry[23], HA_carry[8], FA_2_sum[18], FA_2_carry[18]);

    FullAdder FA_2_19 (FA_sum[26], FA_sum[27], HA_sum[10], FA_2_sum[19], FA_2_carry[19]);
    FullAdder FA_2_20 (FA_carry[24], FA_carry[25], HA_carry[9], FA_2_sum[20], FA_2_carry[20]);

    FullAdder FA_2_21 (FA_sum[28], FA_sum[29], HA_sum[11], FA_2_sum[21], FA_2_carry[21]);
    FullAdder FA_2_22 (FA_carry[26], FA_carry[27], HA_carry[10], FA_2_sum[22], FA_2_carry[22]);

    FullAdder FA_2_23 (FA_sum[30], FA_sum[31], HA_sum[12], FA_2_sum[23], FA_2_carry[23]);
    FullAdder FA_2_24 (FA_carry[28], FA_carry[29], HA_carry[11], FA_2_sum[24], FA_2_carry[24]);

    FullAdder FA_2_25 (FA_sum[32], FA_sum[33], HA_sum[13], FA_2_sum[25], FA_2_carry[25]);
    FullAdder FA_2_26 (FA_carry[30], FA_carry[31], HA_carry[12], FA_2_sum[26], FA_2_carry[26]);

    FullAdder FA_2_27 (FA_sum[34], FA_sum[35], HA_sum[14], FA_2_sum[27], FA_2_carry[27]);
    FullAdder FA_2_28 (FA_carry[32], FA_carry[33], HA_carry[13], FA_2_sum[28], FA_2_carry[28]);

    FullAdder FA_2_29 (FA_sum[36], FA_sum[37], HA_sum[15], FA_2_sum[29], FA_2_carry[29]);
    FullAdder FA_2_30 (FA_carry[34], FA_carry[35], HA_carry[14], FA_2_sum[30], FA_2_carry[30]);

    FullAdder FA_2_31 (FA_sum[38], FA_sum[39], HA_sum[16], FA_2_sum[31], FA_2_carry[31]);
    FullAdder FA_2_32 (FA_carry[36], FA_carry[37], HA_carry[15], FA_2_sum[32], FA_2_carry[32]);

    FullAdder FA_2_33 (FA_sum[40], FA_sum[41], HA_sum[17], FA_2_sum[33], FA_2_carry[33]);
    FullAdder FA_2_34 (FA_carry[38], FA_carry[39], HA_carry[16], FA_2_sum[34], FA_2_carry[34]);

    FullAdder FA_2_35 (FA_sum[42], FA_sum[43], HA_sum[18], FA_2_sum[35], FA_2_carry[35]);
    FullAdder FA_2_36 (FA_carry[40], FA_carry[41], HA_carry[17], FA_2_sum[36], FA_2_carry[36]);

    FullAdder FA_2_37 (FA_sum[44], FA_sum[45], HA_sum[19], FA_2_sum[37], FA_2_carry[37]);
    FullAdder FA_2_38 (FA_carry[42], FA_carry[43], HA_carry[18], FA_2_sum[38], FA_2_carry[38]);

    FullAdder FA_2_39 (FA_sum[46], FA_sum[47], HA_sum[20], FA_2_sum[39], FA_2_carry[39]);
    FullAdder FA_2_40 (FA_carry[44], FA_carry[45], HA_carry[19], FA_2_sum[40], FA_2_carry[40]);

    FullAdder FA_2_41 (FA_sum[48], FA_sum[49], HA_sum[21], FA_2_sum[41], FA_2_carry[41]);
    FullAdder FA_2_42 (FA_carry[46], FA_carry[47], HA_carry[20], FA_2_sum[42], FA_2_carry[42]);
 
   
   always @(posedge clk or negedge rst) begin
    	if(!rst) begin
			FA_2_sum_reg <= 0;
			FA_2_carry_reg <= 0;
			    	
    		HA_sum_reg <= 0;
    		FA_sum_reg <= 0;
    		
    		HA_carry_reg <= 0;
    		FA_carry_reg <= 0;
    		
    		HA_2_sum_reg <= 0;
			HA_2_carry_reg <= 0;
    		
    		P1_double <= 0;
			P2_double <= 0;
			P3_double <= 0;
			P4_double <= 0;
			P5_double <= 0;
			P6_double <= 0;
			P7_double <= 0;
			P8_double <= 0;    		
    	end
    	else begin
			FA_2_sum_reg <= FA_2_sum;
			FA_2_carry_reg <= FA_2_carry;
			
			HA_2_sum_reg <= HA_2_sum;
			HA_2_carry_reg <= HA_2_carry;

    		HA_sum_reg <= HA_sum;
    		FA_sum_reg <= FA_sum;
    		
    		HA_carry_reg <= HA_carry;
    		FA_carry_reg <= FA_carry;
    		
    		P1_double <= P1;
			P2_double <= P2;
			P3_double <= P3;
			P4_double <= P4;
			P5_double <= P5;
			P6_double <= P6;
			P7_double <= P7;
			P8_double <= P8;  
    	end
    end


    HalfAdder HA_3_1 (FA_2_sum_reg[3], HA_carry_reg[2], HA_3_1_sum, HA_3_1_carry);
    FullAdder FA_3_1 (FA_2_sum_reg[4], FA_2_carry_reg[3], HA_carry_reg[3], FA_3_sum[1], FA_3_carry[1]);
    FullAdder FA_3_2 (FA_2_sum_reg[5], FA_2_carry_reg[4], FA_carry_reg[7], FA_3_sum[2], FA_3_carry[2]);
    FullAdder FA_3_3 (FA_2_sum_reg[6], FA_2_carry_reg[5], HA_2_sum_reg[2], FA_3_sum[3], FA_3_carry[3]);
    FullAdder FA_3_4 (FA_2_sum_reg[7], FA_2_carry_reg[6], HA_2_sum_reg[3], FA_3_sum[4], FA_3_carry[4]);
    FullAdder FA_3_5 (FA_2_sum_reg[8], FA_2_carry_reg[7], HA_2_sum_reg[4], FA_3_sum[5], FA_3_carry[5]);
    FullAdder FA_3_6 (FA_2_sum_reg[9], FA_2_carry_reg[8], FA_2_sum_reg[10], FA_3_sum[6], FA_3_carry[6]);
    FullAdder FA_3_7 (FA_2_sum_reg[11], FA_2_carry_reg[9], FA_2_sum_reg[12], FA_3_sum[7], FA_3_carry[7]);

    FullAdder FA_3_8 (FA_2_sum_reg[13], FA_2_carry_reg[11], FA_2_sum_reg[14], FA_3_sum[8], FA_3_carry[8]);
    FullAdder FA_3_9 (FA_2_sum_reg[15], FA_2_carry_reg[13], FA_2_sum_reg[16], FA_3_sum[9], FA_3_carry[9]);

    FullAdder FA_3_10 (FA_2_sum_reg[17], FA_2_carry_reg[15], FA_2_sum_reg[18], FA_3_sum[10], FA_3_carry[10]);
    FullAdder FA_3_11 (FA_2_sum_reg[19], FA_2_carry_reg[17], FA_2_sum_reg[20], FA_3_sum[11], FA_3_carry[11]);

    FullAdder FA_3_12 (FA_2_sum_reg[21], FA_2_carry_reg[19], FA_2_sum_reg[22], FA_3_sum[12], FA_3_carry[12]);
    FullAdder FA_3_13 (FA_2_sum_reg[23], FA_2_carry_reg[21], FA_2_sum_reg[24], FA_3_sum[13], FA_3_carry[13]);

    FullAdder FA_3_14 (FA_2_sum_reg[25], FA_2_carry_reg[23], FA_2_sum_reg[26], FA_3_sum[14], FA_3_carry[14]);
    FullAdder FA_3_15 (FA_2_sum_reg[27], FA_2_carry_reg[25], FA_2_sum_reg[28], FA_3_sum[15], FA_3_carry[15]);

    FullAdder FA_3_16 (FA_2_sum_reg[29], FA_2_carry_reg[27], FA_2_sum_reg[30], FA_3_sum[16], FA_3_carry[16]);
    FullAdder FA_3_17 (FA_2_sum_reg[31], FA_2_carry_reg[29], FA_2_sum_reg[32], FA_3_sum[17], FA_3_carry[17]);

    FullAdder FA_3_18 (FA_2_sum_reg[33], FA_2_carry_reg[31], FA_2_sum_reg[34], FA_3_sum[18], FA_3_carry[18]);
    FullAdder FA_3_19 (FA_2_sum_reg[35], FA_2_carry_reg[33], FA_2_sum_reg[36], FA_3_sum[19], FA_3_carry[19]);

    FullAdder FA_3_20 (FA_2_sum_reg[37], FA_2_carry_reg[35], FA_2_sum_reg[38], FA_3_sum[20], FA_3_carry[20]);
    FullAdder FA_3_21 (FA_2_sum_reg[39], FA_2_carry_reg[37], FA_2_sum_reg[40], FA_3_sum[21], FA_3_carry[21]);

    FullAdder FA_3_22 (FA_2_sum_reg[41], FA_2_carry_reg[39], FA_2_sum_reg[42], FA_3_sum[22], FA_3_carry[22]);

	HalfAdder HA_4_1 (FA_3_sum[4], FA_3_carry[3], HA_4_1_sum, HA_4_1_carry);
    FullAdder FA_4_1 (FA_3_sum[5], FA_3_carry[4], HA_2_carry_reg[3], FA_4_sum[1], FA_4_carry[1]);
    FullAdder FA_4_2 (FA_3_sum[6], FA_3_carry[5], HA_2_carry_reg[4], FA_4_sum[2], FA_4_carry[2]);
    FullAdder FA_4_3 (FA_3_sum[7], FA_3_carry[6], FA_2_carry_reg[10], FA_4_sum[3], FA_4_carry[3]);
    FullAdder FA_4_4 (FA_3_sum[8], FA_3_carry[7], FA_2_carry_reg[12], FA_4_sum[4], FA_4_carry[4]);
    FullAdder FA_4_5 (FA_3_sum[9], FA_3_carry[8], FA_2_carry_reg[14], FA_4_sum[5], FA_4_carry[5]);

    FullAdder FA_4_6 (FA_3_sum[10], FA_3_carry[9], FA_2_carry_reg[16], FA_4_sum[6], FA_4_carry[6]);
    FullAdder FA_4_7 (FA_3_sum[11], FA_3_carry[10], FA_2_carry_reg[18], FA_4_sum[7], FA_4_carry[7]);
    FullAdder FA_4_8 (FA_3_sum[12], FA_3_carry[11], FA_2_carry_reg[20], FA_4_sum[8], FA_4_carry[8]);
    FullAdder FA_4_9 (FA_3_sum[13], FA_3_carry[12], FA_2_carry_reg[22], FA_4_sum[9], FA_4_carry[9]);
    FullAdder FA_4_10 (FA_3_sum[14], FA_3_carry[13], FA_2_carry_reg[24], FA_4_sum[10], FA_4_carry[10]);
    FullAdder FA_4_11 (FA_3_sum[15], FA_3_carry[14], FA_2_carry_reg[26], FA_4_sum[11], FA_4_carry[11]);
    FullAdder FA_4_12 (FA_3_sum[16], FA_3_carry[15], FA_2_carry_reg[28], FA_4_sum[12], FA_4_carry[12]);
    FullAdder FA_4_13 (FA_3_sum[17], FA_3_carry[16], FA_2_carry_reg[30], FA_4_sum[13], FA_4_carry[13]);
    FullAdder FA_4_14 (FA_3_sum[18], FA_3_carry[17], FA_2_carry_reg[32], FA_4_sum[14], FA_4_carry[14]);
    FullAdder FA_4_15 (FA_3_sum[19], FA_3_carry[18], FA_2_carry_reg[34], FA_4_sum[15], FA_4_carry[15]);
    FullAdder FA_4_16 (FA_3_sum[20], FA_3_carry[19], FA_2_carry_reg[36], FA_4_sum[16], FA_4_carry[16]);
    FullAdder FA_4_17 (FA_3_sum[21], FA_3_carry[20], FA_2_carry_reg[38], FA_4_sum[17], FA_4_carry[17]);
    FullAdder FA_4_18 (FA_3_sum[22], FA_3_carry[21], FA_2_carry_reg[40], FA_4_sum[18], FA_4_carry[18]);

    // Final Addition Stage using Carry Propagate Adder
    wire [31:0] arg1 = {FA_4_sum[18], FA_4_sum[17], FA_4_sum[16], FA_4_sum[15], FA_4_sum[14], 
                        FA_4_sum[13], FA_4_sum[12], FA_4_sum[11], FA_4_sum[10], FA_4_sum[9], 
                        FA_4_sum[8], FA_4_sum[7], FA_4_sum[6], FA_4_sum[5], FA_4_sum[4], 
                        FA_4_sum[3], FA_4_sum[2], FA_4_sum[1], HA_4_1_sum, FA_3_sum[3], 
                        FA_3_sum[2], FA_3_sum[1], HA_3_1_sum, FA_2_sum_reg[2], FA_2_sum_reg[1], 
                        HA_2_sum_reg[1], FA_sum_reg[1], HA_sum_reg[1], P1_double[3], P1_double[2], P1_double[1], P1_double[0]};
    
    wire [31:0] arg2 = {FA_4_carry[17], FA_4_carry[16], FA_4_carry[15], FA_4_carry[14],
                        FA_4_carry[13], FA_4_carry[12], FA_4_carry[11], FA_4_carry[10], 
                        FA_4_carry[9], FA_4_carry[8], FA_4_carry[7], FA_4_carry[6], 
                        FA_4_carry[5], FA_4_carry[4], FA_4_carry[3], FA_4_carry[2], 
                        FA_4_carry[1], HA_4_1_carry, HA_2_carry_reg[2], FA_3_carry[2], 
                        FA_3_carry[1], HA_3_1_carry, FA_2_carry_reg[2], FA_2_carry_reg[1], 
                        HA_2_carry_reg[1], P4_double[0], HA_carry_reg[1], P3_double[0], P2_double[1], P2_double[0], 1'b0, 1'b0};
                        
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
    
endmodule
