module WallaceTreeMult(
	input clk,
	input rst,
    input [15:0] P1_in,
    input [13:0] P2_in,
    input [11:0] P3_in,
    input [9:0] P4_in,
    output reg [15:0] Out
);
    
    reg [15:0] P1, P1_double;
    reg [13:0] P2, P2_double;
    reg [11:0] P3, P3_double;
    reg [9:0] P4, P4_double;
    
    
    wire [15:0] sum;
    wire [16:0] carries; // Extra bit for the final carry
    wire [15:0] arg1, arg2;
   always @(posedge clk or negedge rst) begin
    	if(!rst) begin
    		P1 <= 0;
    		P2 <= 0;
    		P3 <= 0;
    		P4 <= 0;
    		Out <= 0;
    	end
    	else begin
    		P1 <= P1_in;
    		P2 <= P2_in;
    		P3 <= P3_in;
    		P4 <= P4_in;
    		Out <= sum;
    	end
    end
    
    reg HA1_sum_reg, HA1_carry_reg, HA1_sum_double_reg, HA1_carry_double_reg;
    wire HA1_sum, HA1_carry;
    
    reg HA_2_1_sum_reg, HA_2_1_carry_reg;
    wire HA_2_1_sum, HA_2_1_carry;
    
    wire [10:0] FA_sum;
    reg [10:0] FA_sum_reg;
    
    wire [10:0] FA_carry;
    reg [10:0] FA_carry_reg;
    
    wire FA1_sum, FA2_sum, FA3_sum, FA4_sum, FA5_sum, FA6_sum, FA7_sum, FA8_sum, FA9_sum, FA10_sum;
    wire FA1_carry, FA2_carry, FA3_carry, FA4_carry, FA5_carry, FA6_carry, FA7_carry, FA8_carry, FA9_carry, FA10_carry;

    // FA12 to FA14 outputs
    wire FA11_sum, FA11_carry;


    // Stage-2 HalfAdder output
    wire [8:0] FA_2_sum;
    wire [8:0] FA_2_carry;

    // Stage-2 FullAdder outputs
    wire FA_2_1_sum, FA_2_1_carry;
    wire FA_2_2_sum, FA_2_2_carry;
    wire FA_2_3_sum, FA_2_3_carry;
    wire FA_2_4_sum, FA_2_4_carry;
    wire FA_2_5_sum, FA_2_5_carry;
    wire FA_2_6_sum, FA_2_6_carry;
    wire FA_2_7_sum, FA_2_7_carry;
    wire FA_2_8_sum, FA_2_8_carry;
    wire FA_2_9_sum, FA_2_9_carry;


    //Step-1
    HalfAdder HA1 (P1[4], P2[2], HA1_sum, HA1_carry);
    FullAdder FA1 (P1[5], P2[3], P3[1], FA_sum[0], FA_carry[0]);
    FullAdder FA2 (P1[6], P2[4], P3[2], FA_sum[1], FA_carry[1]);
    FullAdder FA3 (P1[7], P2[5], P3[3], FA_sum[2],FA_carry[2]);
    FullAdder FA4 (P1[8], P2[6], P3[4], FA_sum[3], FA_carry[3]);
    FullAdder FA5 (P1[9], P2[7], P3[5], FA_sum[4], FA_carry[4]);
    FullAdder FA6 (P1[10], P2[8], P3[6], FA_sum[5], FA_carry[5]);
    FullAdder FA7 (P1[11], P2[9], P3[7], FA_sum[6],FA_carry[6]);
    FullAdder FA8 (P1[12], P2[10], P3[8], FA_sum[7], FA_carry[7]);
    FullAdder FA9 (P1[13], P2[11], P3[9], FA_sum[8], FA_carry[8]);
    FullAdder FA10 (P1[14], P2[12], P3[10], FA_sum[9], FA_carry[9]);
    FullAdder FA11 (P1[15], P2[13], P3[11], FA_sum[10], FA_carry[10]);

	always @(posedge clk or negedge rst) begin
		if(!rst) begin
			FA_sum_reg <= 0;
			FA_carry_reg <= 0;
			
			HA1_sum_reg <= 0;
			HA1_carry_reg <= 0;
			
						
			P1_double <= 0;
			P2_double <= 0;
			P3_double <= 0;
			P4_double <= 0;
		end
		else begin
		
			P1_double <= P1;
			P2_double <= P2;
			P3_double <= P3;
			P4_double <= P4;
			
			FA_sum_reg <= FA_sum;
			FA_carry_reg <= FA_carry;
			
			HA1_sum_reg <= HA1_sum;
			HA1_carry_reg <= HA1_carry;
		end
	end

// stage 2

    HalfAdder HA_2_1  (FA_sum_reg[1],  FA_carry_reg[0],  HA_2_1_sum, HA_2_1_carry);
    FullAdder FA_2_1  (FA_sum_reg[2],  FA_carry_reg[1],  P4_double[1], FA_2_sum[0],  FA_2_carry[0]);
    FullAdder FA_2_2  (FA_sum_reg[3],  FA_carry_reg[2],  P4_double[2], FA_2_sum[1],  FA_2_carry[1]);
    FullAdder FA_2_3  (FA_sum_reg[4],  FA_carry_reg[3],  P4_double[3], FA_2_sum[2],  FA_2_carry[2]);
    FullAdder FA_2_4  (FA_sum_reg[5],  FA_carry_reg[4],  P4_double[4], FA_2_sum[3],  FA_2_carry[3]);
    FullAdder FA_2_5  (FA_sum_reg[6],  FA_carry_reg[5],  P4_double[5], FA_2_sum[4],  FA_2_carry[4]);
    FullAdder FA_2_6  (FA_sum_reg[7],  FA_carry_reg[6],  P4_double[6], FA_2_sum[5],  FA_2_carry[5]);
    FullAdder FA_2_7  (FA_sum_reg[8],  FA_carry_reg[7],  P4_double[7], FA_2_sum[6],  FA_2_carry[6]);
    FullAdder FA_2_8  (FA_sum_reg[9],  FA_carry_reg[8],  P4_double[8], FA_2_sum[7],  FA_2_carry[7]);
    FullAdder FA_2_9  (FA_sum_reg[10], FA_carry_reg[9],  P4_double[9], FA_2_sum[8],  FA_2_carry[8]);
	
    assign arg1 = {FA_2_sum[8:0], HA_2_1_sum, FA_sum_reg[0], HA1_sum_reg, P1_double[3:0]};
    assign arg2 = {FA_2_carry[7:0], HA_2_1_carry, P4_double[0], HA1_carry_reg, P3_double[0], P2_double[1:0], 2'b0};
    assign carries[0] = 1'b0;
    
    genvar i;
    generate
      for (i = 0; i < 16; i = i + 1) begin: cpa_loop
        assign sum[i] = arg1[i] ^ arg2[i] ^ carries[i];
        assign carries[i+1] = (arg1[i] & arg2[i]) | (arg1[i] & carries[i]) | (arg2[i] & carries[i]);
      end
    endgenerate
    
endmodule

