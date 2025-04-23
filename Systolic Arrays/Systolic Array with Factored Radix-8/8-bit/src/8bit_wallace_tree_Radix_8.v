module WallaceTreeMult(
	input clk,
	input rst,
    input [15:0] P1_in,
    input [12:0] P2_in,
    input [9:0] P3_in,
    output reg [15:0] Out
);
    
    reg [15:0] P1, P1_double;
    reg [12:0] P2, P2_double;
    reg [9:0] P3, P3_double;

	wire [15:0] sum;
    wire [16:0] carries; // Extra bit for the final carry
        
    always @(posedge clk or negedge rst) begin
    	if(!rst) begin
    		P1 <= 0;
    		P2 <= 0;
    		P3 <= 0;
    		Out <= 0;
    	end
    	else begin
    		P1 <= P1_in;
    		P2 <= P2_in;
    		P3 <= P3_in;
    		Out <= sum;
    	end
    end

    
    wire HA1_sum;
    wire HA1_carry;
    
    reg HA1_sum_reg;
    reg HA1_carry_reg;
    
    wire FA1_sum, FA2_sum, FA3_sum, FA4_sum, FA5_sum, FA6_sum, FA7_sum, FA8_sum, FA9_sum, FA10_sum;
    wire FA1_carry, FA2_carry, FA3_carry, FA4_carry, FA5_carry, FA6_carry, FA7_carry, FA8_carry, FA9_carry, FA10_carry;

	wire [8:0] FA_sum, FA_carry;
	reg [8:0] FA_sum_reg, FA_carry_reg;
    
    wire [15:0] arg1, arg2;
    reg [15:0] arg1_reg, arg2_reg;
    
    //Step-1
    HalfAdder HA1 (P1[6], P2[3], HA1_sum, HA1_carry);
    FullAdder FA1 (P1[7], P2[4], P3[1], FA_sum[0], FA_carry[0]);
    FullAdder FA2 (P1[8], P2[5], P3[2], FA_sum[1], FA_carry[1]);
    FullAdder FA3 (P1[9], P2[6], P3[3], FA_sum[2], FA_carry[2]);
    FullAdder FA4 (P1[10], P2[7], P3[4], FA_sum[3], FA_carry[3]);
    FullAdder FA5 (P1[11], P2[8], P3[5], FA_sum[4], FA_carry[4]);
    FullAdder FA6 (P1[12], P2[9], P3[6], FA_sum[5], FA_carry[5]);
    FullAdder FA7 (P1[13], P2[10], P3[7], FA_sum[6], FA_carry[6]);
    FullAdder FA8 (P1[14], P2[11], P3[8], FA_sum[7], FA_carry[7]);
    FullAdder FA9 (P1[15], P2[12], P3[9], FA_sum[8], FA_carry[8]);
    
    always @(posedge clk or negedge rst) begin
    	if(!rst) begin
    		HA1_sum_reg <= 0;
    		HA1_carry_reg <= 0;
    		
    		FA_sum_reg <= 0;
    		FA_carry_reg <= 0;
    		
    		P1_double <= 0;
			P2_double <= 0;
			P3_double <= 0;
    	end
    	else begin
    		HA1_sum_reg <= HA1_sum;
    		HA1_carry_reg <= HA1_carry;
    		
    		FA_sum_reg <= FA_sum;
    		FA_carry_reg <= FA_carry;
    		
    		P1_double <= P1;
			P2_double <= P2;
			P3_double <= P3;
    	end
    end
    
	assign arg1 = {FA_sum_reg[8:0], HA1_sum_reg, P1_double[5:0]};
	assign arg2 = {FA_carry_reg[7:0], HA1_carry_reg, P3_double[0], P2_double[2:0], 3'b0};
   
    assign carries[0] = 1'b0;
    genvar i;
    generate
      for (i = 0; i < 16; i = i + 1) begin: cpa_loop
        assign sum[i] = arg1[i] ^ arg2[i] ^ carries[i];
        assign carries[i+1] = (arg1[i] & arg2[i]) | (arg1[i] & carries[i]) | (arg2[i] & carries[i]);
      end
    endgenerate
    
endmodule



