module WallaceTreeMult(
	input clk,
	input rst,
	input [63:0] P1_in,
    input [60:0] P2_in,
    input [57:0] P3_in,
    input [54:0] P4_in,
    input [51:0] P5_in,
    input [48:0] P6_in,
    input [45:0] P7_in,
    input [42:0] P8_in,
    input [39:0] P9_in,
    input [36:0] P10_in,
    input [33:0] P11_in,
    output reg [63:0] Out
    );
    
    reg [63:0] P1, P1_double, P1_triple;
    reg [60:0] P2, P2_double, P2_triple;
    reg [57:0] P3, P3_double, P3_triple;
    reg [54:0] P4, P4_double, P4_triple;
    reg [51:0] P5, P5_double, P5_triple;
    reg [48:0] P6, P6_double, P6_triple;
    reg [45:0] P7, P7_double, P7_triple;
    reg [42:0] P8, P8_double, P8_triple;
    reg [39:0] P9, P9_double, P9_triple;
    reg [36:0] P10, P10_double, P10_triple;
    reg [33:0] P11, P11_double, P11_triple;
    
    wire [63:0] sum;
    wire [64:0] carries; // Extra bit for the final carry
    
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
			P9 <= 0;
			P10 <= 0;
			P11 <= 0;
			
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
			P9 <= P9_in;
			P10 <= P10_in;
			P11 <= P11_in;
			
			Out <= sum;
    	end
    end
    
	wire [0:40] HA_sum, HA_carry;
	wire [0:145] FA_sum, FA_carry;
	
	reg [0:40] HA_sum_reg, HA_sum_double_reg, HA_carry_reg, HA_carry_double_reg;
	reg [0:145] FA_sum_reg, FA_sum_double_reg, FA_carry_reg, FA_carry_double_reg;

    wire [96:0] FA_2_sum;
    wire [96:0] FA_2_carry;
    wire [38:0] HA_2_sum;
    wire [38:0] HA_2_carry;

    reg [96:0] FA_2_sum_reg, FA_2_sum_double_reg;
    reg [96:0] FA_2_carry_reg, FA_2_carry_double_reg;
    reg [38:0] HA_2_sum_reg, HA_2_sum_double_reg;
    reg [38:0] HA_2_carry_reg, HA_2_carry_double_reg;

    wire [81:0] FA_3_sum;
    wire [81:0] FA_3_carry;
    wire [5:0] HA_3_sum;
    wire [5:0] HA_3_carry;

    reg [81:0] FA_3_sum_reg;
    reg [81:0] FA_3_carry_reg;
    reg [5:0] HA_3_sum_reg;
    reg [5:0] HA_3_carry_reg;
    
    wire [43:0] FA_4_sum;
    wire [43:0] FA_4_carry;
    wire HA_4_1_sum, HA_4_1_carry;

    reg [43:0] FA_4_sum_reg;
    reg [43:0] FA_4_carry_reg;
    reg HA_4_1_sum_reg, HA_4_1_carry_reg;

    wire [34:0] FA_5_sum, FA_5_carry;
    wire HA_5_1_sum, HA_5_1_carry;
 
	
    HalfAdder HA1 (P1[6], P2[3], HA_sum[0], HA_carry[0]);
    FullAdder FA1 (P1[7], P2[4], P3[1], FA_sum[0], FA_carry[0]);
    FullAdder FA2 (P1[8], P2[5], P3[2], FA_sum[1], FA_carry[1]);
    FullAdder FA3 (P1[9], P2[6], P3[3], FA_sum[2], FA_carry[2]);
    FullAdder FA4 (P1[10], P2[7], P3[4], FA_sum[3], FA_carry[3]);
    FullAdder FA5 (P1[11], P2[8], P3[5], FA_sum[4], FA_carry[4]);

    FullAdder FA6 (P1[12], P2[9], P3[6], FA_sum[5], FA_carry[5]);
    HalfAdder HA2 (P4[3], P5[0], HA_sum[1], HA_carry[1]);

    FullAdder FA7 (P1[13], P2[10], P3[7], FA_sum[6], FA_carry[6]);
    HalfAdder HA3 (P4[4], P5[1], HA_sum[2], HA_carry[2]);

    FullAdder FA8 (P1[14], P2[11], P3[8], FA_sum[7], FA_carry[7]);
    HalfAdder HA4 (P4[5], P5[2], HA_sum[3], HA_carry[3]);

    FullAdder FA9 (P1[15], P2[12], P3[9], FA_sum[8], FA_carry[8]);
    FullAdder FA10 (P4[6], P5[3], P6[0], FA_sum[9], FA_carry[9]);
    FullAdder FA11 (P1[16], P2[13], P3[10], FA_sum[10], FA_carry[10]);
    FullAdder FA12 (P4[7], P5[4], P6[1], FA_sum[11], FA_carry[11]);

    FullAdder FA13 (P1[17], P2[14], P3[11], FA_sum[12], FA_carry[12]);
    FullAdder FA14 (P4[8], P5[5], P6[2], FA_sum[13], FA_carry[13]);
    FullAdder FA15 (P1[18], P2[15], P3[12], FA_sum[14], FA_carry[14]);
    FullAdder FA16 (P4[9], P5[6], P6[3], FA_sum[15], FA_carry[15]);
    FullAdder FA17 (P1[19], P2[16], P3[13], FA_sum[16], FA_carry[16]);
    FullAdder FA18 (P4[10], P5[7], P6[4], FA_sum[17], FA_carry[17]);
    FullAdder FA19 (P1[20], P2[17], P3[14], FA_sum[18], FA_carry[18]);
    FullAdder FA20 (P4[11], P5[8], P6[5], FA_sum[19], FA_carry[19]);

    FullAdder FA21 (P1[21], P2[18], P3[15], FA_sum[20], FA_carry[20]);
    FullAdder FA22 (P4[12], P5[9], P6[6], FA_sum[21], FA_carry[21]);
    HalfAdder HA5 (P7[3], P8[0], HA_sum[4], HA_carry[4]);

    FullAdder FA23 (P1[22], P2[19], P3[16], FA_sum[22], FA_carry[22]);
    FullAdder FA24 (P4[13], P5[10], P6[7], FA_sum[23], FA_carry[23]);
    HalfAdder HA6 (P7[4], P8[1], HA_sum[5], HA_carry[5]);

    FullAdder FA25 (P1[23], P2[20], P3[17], FA_sum[24], FA_carry[24]);
    FullAdder FA26 (P4[14], P5[11], P6[8], FA_sum[25], FA_carry[25]);
    HalfAdder HA7 (P7[5], P8[2], HA_sum[6], HA_carry[6]);

    FullAdder FA27 (P1[24], P2[21], P3[18], FA_sum[26], FA_carry[26]);
    FullAdder FA28 (P4[15], P5[12], P6[9], FA_sum[27], FA_carry[27]);
    FullAdder FA29 (P7[6], P8[3], P9[0], FA_sum[28], FA_carry[28]);

    FullAdder FA30 (P1[25], P2[22], P3[19], FA_sum[29], FA_carry[29]);
    FullAdder FA31 (P4[16], P5[13], P6[10], FA_sum[30], FA_carry[30]);
    FullAdder FA32 (P7[7], P8[4], P9[1], FA_sum[31], FA_carry[31]);

    FullAdder FA33 (P1[26], P2[23], P3[20], FA_sum[32], FA_carry[32]);
    FullAdder FA34 (P4[17], P5[14], P6[11], FA_sum[33], FA_carry[33]);
    FullAdder FA35 (P7[8], P8[5], P9[2], FA_sum[34], FA_carry[34]);

    FullAdder FA36 (P1[27], P2[24], P3[21], FA_sum[35], FA_carry[35]);
    FullAdder FA37 (P4[18], P5[15], P6[12], FA_sum[36], FA_carry[36]);
    FullAdder FA38 (P7[9], P8[6], P9[3], FA_sum[37], FA_carry[37]);

    FullAdder FA39 (P1[28], P2[25], P3[22], FA_sum[38], FA_carry[38]);
    FullAdder FA40 (P4[19], P5[16], P6[13], FA_sum[39], FA_carry[39]);
    FullAdder FA41 (P7[10], P8[7], P9[4], FA_sum[40], FA_carry[40]);

    FullAdder FA42 (P1[29], P2[26], P3[23], FA_sum[41], FA_carry[41]);
    FullAdder FA43 (P4[20], P5[17], P6[14], FA_sum[42], FA_carry[42]);
    FullAdder FA44 (P7[11], P8[8], P9[5], FA_sum[43], FA_carry[43]);

    FullAdder FA45 (P1[30], P2[27], P3[24], FA_sum[44], FA_carry[44]);
    FullAdder FA46 (P4[21], P5[18], P6[15], FA_sum[45], FA_carry[45]);
    FullAdder FA47 (P7[12], P8[9], P9[6], FA_sum[46], FA_carry[46]);
    HalfAdder HA8 (P10[3], P11[0], HA_sum[7], HA_carry[7]);

    FullAdder FA48 (P1[31], P2[28], P3[25], FA_sum[47], FA_carry[47]);
    FullAdder FA49 (P4[22], P5[19], P6[16], FA_sum[48], FA_carry[48]);
    FullAdder FA50 (P7[13], P8[10], P9[7], FA_sum[49], FA_carry[49]);
    HalfAdder HA9 (P10[4], P11[1], HA_sum[8], HA_carry[8]);

    FullAdder FA51 (P1[32], P2[29], P3[26], FA_sum[50], FA_carry[50]);
    FullAdder FA52 (P4[23], P5[20], P6[17], FA_sum[51], FA_carry[51]);
    FullAdder FA53 (P7[14], P8[11], P9[8], FA_sum[52], FA_carry[52]);
    HalfAdder HA10 (P10[5], P11[2], HA_sum[9], HA_carry[9]);

    FullAdder FA54 (P1[33], P2[30], P3[27], FA_sum[53], FA_carry[53]);
    FullAdder FA55 (P4[24], P5[21], P6[18], FA_sum[54], FA_carry[54]);
    FullAdder FA56 (P7[15], P8[12], P9[9], FA_sum[55], FA_carry[55]);
    HalfAdder HA11 (P10[6], P11[3], HA_sum[10], HA_carry[10]);

    FullAdder FA57 (P1[34], P2[31], P3[28], FA_sum[56], FA_carry[56]);
    FullAdder FA58 (P4[25], P5[22], P6[19], FA_sum[57], FA_carry[57]);
    FullAdder FA59 (P7[16], P8[13], P9[10], FA_sum[58], FA_carry[58]);
    HalfAdder HA12 (P10[7], P11[4], HA_sum[11], HA_carry[11]);

    FullAdder FA60 (P1[35], P2[32], P3[29], FA_sum[59], FA_carry[59]);
    FullAdder FA61 (P4[26], P5[23], P6[20], FA_sum[60], FA_carry[60]);
    FullAdder FA62 (P7[17], P8[14], P9[11], FA_sum[61], FA_carry[61]);
    HalfAdder HA13 (P10[8], P11[5], HA_sum[12], HA_carry[12]);

    FullAdder FA63 (P1[36], P2[33], P3[30], FA_sum[62], FA_carry[62]);
    FullAdder FA64 (P4[27], P5[24], P6[21], FA_sum[63], FA_carry[63]);
    FullAdder FA65 (P7[18], P8[15], P9[12], FA_sum[64], FA_carry[64]);
    HalfAdder HA14 (P10[9], P11[6], HA_sum[13], HA_carry[13]);

    FullAdder FA66 (P1[37], P2[34], P3[31], FA_sum[65], FA_carry[65]);
    FullAdder FA67 (P4[28], P5[25], P6[22], FA_sum[66], FA_carry[66]);
    FullAdder FA68 (P7[19], P8[16], P9[13], FA_sum[67], FA_carry[67]);
    HalfAdder HA15 (P10[10], P11[7], HA_sum[14], HA_carry[14]);

    FullAdder FA69 (P1[38], P2[35], P3[32], FA_sum[68], FA_carry[68]);
    FullAdder FA70 (P4[29], P5[26], P6[23], FA_sum[69], FA_carry[69]);
    FullAdder FA71 (P7[20], P8[17], P9[14], FA_sum[70], FA_carry[70]);
    HalfAdder HA16 (P10[11], P11[8], HA_sum[15], HA_carry[15]);

    FullAdder FA72 (P1[39], P2[36], P3[33], FA_sum[71], FA_carry[71]);
    FullAdder FA73 (P4[30], P5[27], P6[24], FA_sum[72], FA_carry[72]);
    FullAdder FA74 (P7[21], P8[18], P9[15], FA_sum[73], FA_carry[73]);
    HalfAdder HA17 (P10[12], P11[9], HA_sum[16], HA_carry[16]);

    FullAdder FA75 (P1[40], P2[37], P3[34], FA_sum[74], FA_carry[74]);
    FullAdder FA76 (P4[31], P5[28], P6[25], FA_sum[75], FA_carry[75]);
    FullAdder FA77 (P7[22], P8[19], P9[16], FA_sum[76], FA_carry[76]);
    HalfAdder HA18 (P10[13], P11[10], HA_sum[17], HA_carry[17]);

    FullAdder FA78 (P1[41], P2[38], P3[35], FA_sum[77], FA_carry[77]);
    FullAdder FA79 (P4[32], P5[29], P6[26], FA_sum[78], FA_carry[78]);
    FullAdder FA80 (P7[23], P8[20], P9[17], FA_sum[79], FA_carry[79]);
    HalfAdder HA19 (P10[14], P11[11], HA_sum[18], HA_carry[18]);

    FullAdder FA81 (P1[42], P2[39], P3[36], FA_sum[80], FA_carry[80]);
    FullAdder FA82 (P4[33], P5[30], P6[27], FA_sum[81], FA_carry[81]);
    FullAdder FA83 (P7[24], P8[21], P9[18], FA_sum[82], FA_carry[82]);
    HalfAdder HA20 (P10[15], P11[12], HA_sum[19], HA_carry[19]);

    FullAdder FA84 (P1[43], P2[40], P3[37], FA_sum[83], FA_carry[83]);
    FullAdder FA85 (P4[34], P5[31], P6[28], FA_sum[84], FA_carry[84]);
    FullAdder FA86 (P7[25], P8[22], P9[19], FA_sum[85], FA_carry[85]);
    HalfAdder HA21 (P10[16], P11[13], HA_sum[20], HA_carry[20]);

    FullAdder FA87 (P1[44], P2[41], P3[38], FA_sum[86], FA_carry[86]);
    FullAdder FA88 (P4[35], P5[32], P6[29], FA_sum[87], FA_carry[87]);
    FullAdder FA89 (P7[26], P8[23], P9[20], FA_sum[88], FA_carry[88]);
    HalfAdder HA22 (P10[17], P11[14], HA_sum[21], HA_carry[21]);

    FullAdder FA90 (P1[45], P2[42], P3[39], FA_sum[89], FA_carry[89]);
    FullAdder FA91 (P4[36], P5[33], P6[30], FA_sum[90], FA_carry[90]);
    FullAdder FA92 (P7[27], P8[24], P9[21], FA_sum[91], FA_carry[91]);
    HalfAdder HA23 (P10[18], P11[15], HA_sum[22], HA_carry[22]);

    FullAdder FA93 (P1[46], P2[43], P3[40], FA_sum[92], FA_carry[92]);
    FullAdder FA94 (P4[37], P5[34], P6[31], FA_sum[93], FA_carry[93]);
    FullAdder FA95 (P7[28], P8[25], P9[22], FA_sum[94], FA_carry[94]);
    HalfAdder HA24 (P10[19], P11[16], HA_sum[23], HA_carry[23]);

    FullAdder FA96 (P1[47], P2[44], P3[41], FA_sum[95], FA_carry[95]);
    FullAdder FA97 (P4[38], P5[35], P6[32], FA_sum[96], FA_carry[96]);
    FullAdder FA98 (P7[29], P8[26], P9[23], FA_sum[97], FA_carry[97]);
    HalfAdder HA25 (P10[20], P11[17], HA_sum[24], HA_carry[24]);

    FullAdder FA99 (P1[48], P2[45], P3[42], FA_sum[98], FA_carry[98]);
    FullAdder FA100 (P4[39], P5[36], P6[33], FA_sum[99], FA_carry[99]);
    FullAdder FA101 (P7[30], P8[27], P9[24], FA_sum[100], FA_carry[100]);
    HalfAdder HA26 (P10[21], P11[18], HA_sum[25], HA_carry[25]);

    FullAdder FA102 (P1[49], P2[46], P3[43], FA_sum[101], FA_carry[101]);
    FullAdder FA103 (P4[40], P5[37], P6[34], FA_sum[102], FA_carry[102]);
    FullAdder FA104 (P7[31], P8[28], P9[25], FA_sum[103], FA_carry[103]);
    HalfAdder HA27 (P10[22], P11[19], HA_sum[26], HA_carry[26]);

    FullAdder FA105 (P1[50], P2[47], P3[44], FA_sum[104], FA_carry[104]);
    FullAdder FA106 (P4[41], P5[38], P6[35], FA_sum[105], FA_carry[105]);
    FullAdder FA107 (P7[32], P8[29], P9[26], FA_sum[106], FA_carry[106]);
    HalfAdder HA28 (P10[23], P11[20], HA_sum[27], HA_carry[27]);

    FullAdder FA108 (P1[51], P2[48], P3[45], FA_sum[107], FA_carry[107]);
    FullAdder FA109 (P4[42], P5[39], P6[36], FA_sum[108], FA_carry[108]);
    FullAdder FA110 (P7[33], P8[30], P9[27], FA_sum[109], FA_carry[109]);
    HalfAdder HA29 (P10[24], P11[21], HA_sum[28], HA_carry[28]);

    FullAdder FA111 (P1[52], P2[49], P3[46], FA_sum[110], FA_carry[110]);
    FullAdder FA112 (P4[43], P5[40], P6[37], FA_sum[111], FA_carry[111]);
    FullAdder FA113 (P7[34], P8[31], P9[28], FA_sum[112], FA_carry[112]);
    HalfAdder HA30 (P10[25], P11[22], HA_sum[29], HA_carry[29]);

    FullAdder FA114 (P1[53], P2[50], P3[47], FA_sum[113], FA_carry[113]);
    FullAdder FA115 (P4[44], P5[41], P6[38], FA_sum[114], FA_carry[114]);
    FullAdder FA116 (P7[35], P8[32], P9[29], FA_sum[115], FA_carry[115]);
    HalfAdder HA31 (P10[26], P11[23], HA_sum[30], HA_carry[30]);

    FullAdder FA117 (P1[54], P2[51], P3[48], FA_sum[116], FA_carry[116]);
    FullAdder FA118 (P4[45], P5[42], P6[39], FA_sum[117], FA_carry[117]);
    FullAdder FA119 (P7[36], P8[33], P9[30], FA_sum[118], FA_carry[118]);
    HalfAdder HA32 (P10[27], P11[24], HA_sum[31], HA_carry[31]);

    FullAdder FA120 (P1[55], P2[52], P3[49], FA_sum[119], FA_carry[119]);
    FullAdder FA121 (P4[46], P5[43], P6[40], FA_sum[120], FA_carry[120]);
    FullAdder FA122 (P7[37], P8[34], P9[31], FA_sum[121], FA_carry[121]);
    HalfAdder HA33 (P10[28], P11[25], HA_sum[32], HA_carry[32]);

    FullAdder FA123 (P1[56], P2[53], P3[50], FA_sum[122], FA_carry[122]);
    FullAdder FA124 (P4[47], P5[44], P6[41], FA_sum[123], FA_carry[123]);
    FullAdder FA125 (P7[38], P8[35], P9[32], FA_sum[124], FA_carry[124]);
    HalfAdder HA34 (P10[29], P11[26], HA_sum[33], HA_carry[33]);

    FullAdder FA126 (P1[57], P2[54], P3[51], FA_sum[125], FA_carry[125]);
    FullAdder FA127 (P4[48], P5[45], P6[42], FA_sum[126], FA_carry[126]);
    FullAdder FA128 (P7[39], P8[36], P9[33], FA_sum[127], FA_carry[127]);
    HalfAdder HA35 (P10[30], P11[27], HA_sum[34], HA_carry[34]);

    FullAdder FA129 (P1[58], P2[55], P3[52], FA_sum[128], FA_carry[128]);
    FullAdder FA130 (P4[49], P5[46], P6[43], FA_sum[129], FA_carry[129]);
    FullAdder FA131 (P7[40], P8[37], P9[34], FA_sum[130], FA_carry[130]);
    HalfAdder HA36 (P10[31], P11[28], HA_sum[35], HA_carry[35]);

    FullAdder FA132 (P1[59], P2[56], P3[53], FA_sum[131], FA_carry[131]);
    FullAdder FA133 (P4[50], P5[47], P6[44], FA_sum[132], FA_carry[132]);
    FullAdder FA134 (P7[41], P8[38], P9[35], FA_sum[133], FA_carry[133]);
    HalfAdder HA37 (P10[32], P11[29], HA_sum[36], HA_carry[36]);

    FullAdder FA135 (P1[60], P2[57], P3[54], FA_sum[134], FA_carry[134]);
    FullAdder FA136 (P4[51], P5[48], P6[45], FA_sum[135], FA_carry[135]);
    FullAdder FA137 (P7[42], P8[39], P9[36], FA_sum[136], FA_carry[136]);
    HalfAdder HA38 (P10[33], P11[30], HA_sum[37], HA_carry[37]);

    FullAdder FA138 (P1[61], P2[58], P3[55], FA_sum[137], FA_carry[137]);
    FullAdder FA139 (P4[52], P5[49], P6[46], FA_sum[138], FA_carry[138]);
    FullAdder FA140 (P7[43], P8[40], P9[37], FA_sum[139], FA_carry[139]);
    HalfAdder HA39 (P10[34], P11[31], HA_sum[38], HA_carry[38]);

    FullAdder FA141 (P1[62], P2[59], P3[56], FA_sum[140], FA_carry[140]);
    FullAdder FA142 (P4[53], P5[50], P6[47], FA_sum[141], FA_carry[141]);
    FullAdder FA143 (P7[44], P8[41], P9[38], FA_sum[142], FA_carry[142]);
    HalfAdder HA40 (P10[35], P11[32], HA_sum[39], HA_carry[39]);

    FullAdder FA144 (P1[63], P2[60], P3[57], FA_sum[143], FA_carry[143]);
    FullAdder FA145 (P4[54], P5[51], P6[48], FA_sum[144], FA_carry[144]);
    FullAdder FA146 (P7[45], P8[42], P9[39], FA_sum[145], FA_carry[145]);
    HalfAdder HA41 (P10[36], P11[33], HA_sum[40], HA_carry[40]);

	HalfAdder HA_2_0 (FA_sum[2], FA_carry[1], HA_2_sum[0], HA_2_carry[0]);
    FullAdder FA_2_0 (FA_sum[3], FA_carry[2], P4[1], FA_2_sum[0], FA_2_carry[0]);
    FullAdder FA_2_1 (FA_sum[4], FA_carry[3], P4[2], FA_2_sum[1], FA_2_carry[1]);
    FullAdder FA_2_2 (FA_sum[5], FA_carry[4], HA_sum[1], FA_2_sum[2], FA_2_carry[2]);
    FullAdder FA_2_3 (FA_sum[6], FA_carry[5], HA_sum[2], FA_2_sum[3], FA_2_carry[3]);
    FullAdder FA_2_4 (FA_sum[7], FA_carry[6], HA_sum[3], FA_2_sum[4], FA_2_carry[4]);
    FullAdder FA_2_5 (FA_sum[8], FA_sum[9], FA_carry[7], FA_2_sum[5], FA_2_carry[5]);
    FullAdder FA_2_6 (FA_sum[10], FA_sum[11], FA_carry[8], FA_2_sum[6], FA_2_carry[6]);
    FullAdder FA_2_7 (FA_sum[12], FA_sum[13], FA_carry[10], FA_2_sum[7], FA_2_carry[7]);

    FullAdder FA_2_8 (FA_sum[14], FA_sum[15], FA_carry[12], FA_2_sum[8], FA_2_carry[8]);
    HalfAdder HA_2_1 (FA_carry[13], P7[0], HA_2_sum[1], HA_2_carry[1]);

    FullAdder FA_2_9 (FA_sum[16], FA_sum[17], FA_carry[14], FA_2_sum[9], FA_2_carry[9]);
    HalfAdder HA_2_2 (FA_carry[15], P7[1], HA_2_sum[2], HA_2_carry[2]);

    FullAdder FA_2_10 (FA_sum[18], FA_sum[19], FA_carry[16], FA_2_sum[10], FA_2_carry[10]);
    HalfAdder HA_2_3 (FA_carry[17], P7[2], HA_2_sum[3], HA_2_carry[3]);

    FullAdder FA_2_11 (FA_sum[20], FA_sum[21], FA_carry[18], FA_2_sum[11], FA_2_carry[11]);
    HalfAdder HA_2_4 (HA_sum[4], FA_carry[19], HA_2_sum[4], HA_2_carry[4]);

    FullAdder FA_2_12 (FA_sum[22], FA_sum[23], FA_carry[20], FA_2_sum[12], FA_2_carry[12]);
    FullAdder FA_2_13 (HA_sum[5], FA_carry[21], HA_carry[4], FA_2_sum[13], FA_2_carry[13]);

    FullAdder FA_2_14 (FA_sum[24], FA_sum[25], FA_carry[22], FA_2_sum[14], FA_2_carry[14]);
    FullAdder FA_2_15 (HA_sum[6], FA_carry[23], HA_carry[5], FA_2_sum[15], FA_2_carry[15]);

    FullAdder FA_2_16 (FA_sum[26], FA_sum[27], FA_carry[24], FA_2_sum[16], FA_2_carry[16]);
    FullAdder FA_2_17 (FA_sum[28], FA_carry[25], HA_carry[6], FA_2_sum[17], FA_2_carry[17]);

    FullAdder FA_2_18 (FA_sum[29], FA_sum[30], FA_sum[31], FA_2_sum[18], FA_2_carry[18]);
    FullAdder FA_2_19 (FA_carry[26], FA_carry[27], FA_carry[28], FA_2_sum[19], FA_2_carry[19]);

    FullAdder FA_2_20 (FA_sum[32], FA_sum[33], FA_sum[34], FA_2_sum[20], FA_2_carry[20]);
    FullAdder FA_2_21 (FA_carry[29], FA_carry[30], FA_carry[31], FA_2_sum[21], FA_2_carry[21]);

    FullAdder FA_2_22 (FA_sum[35], FA_sum[36], FA_sum[37], FA_2_sum[22], FA_2_carry[22]);
    FullAdder FA_2_23 (FA_carry[32], FA_carry[33], FA_carry[34], FA_2_sum[23], FA_2_carry[23]);

    FullAdder FA_2_24 (FA_sum[38], FA_sum[39], FA_sum[40], FA_2_sum[24], FA_2_carry[24]);
    FullAdder FA_2_25 (FA_carry[35], FA_carry[36], FA_carry[37], FA_2_sum[25], FA_2_carry[25]);

    FullAdder FA_2_26 (FA_sum[41], FA_sum[42], FA_sum[43], FA_2_sum[26], FA_2_carry[26]);
    FullAdder FA_2_27 (FA_carry[38], FA_carry[39], FA_carry[40], FA_2_sum[27], FA_2_carry[27]);

    FullAdder FA_2_28 (FA_sum[44], FA_sum[45], FA_sum[46], FA_2_sum[28], FA_2_carry[28]);
    FullAdder FA_2_29 (HA_sum[7], FA_carry[41], FA_carry[42], FA_2_sum[29], FA_2_carry[29]);

    FullAdder FA_2_30 (FA_sum[47], FA_sum[48], FA_sum[49], FA_2_sum[30], FA_2_carry[30]);
    FullAdder FA_2_31 (HA_sum[8], FA_carry[44], FA_carry[45], FA_2_sum[31], FA_2_carry[31]);
    HalfAdder HA_2_5 (FA_carry[46], HA_carry[7], HA_2_sum[5], HA_2_carry[5]);

    FullAdder FA_2_32 (FA_sum[50], FA_sum[51], FA_sum[52], FA_2_sum[32], FA_2_carry[32]);
    FullAdder FA_2_33 (HA_sum[9], FA_carry[47], FA_carry[48], FA_2_sum[33], FA_2_carry[33]);
    HalfAdder HA_2_6 (FA_carry[49], HA_carry[8], HA_2_sum[6], HA_2_carry[6]);

    FullAdder FA_2_34 (FA_sum[53], FA_sum[54], FA_sum[55], FA_2_sum[34], FA_2_carry[34]);
    FullAdder FA_2_35 (HA_sum[10], FA_carry[50], FA_carry[51], FA_2_sum[35], FA_2_carry[35]);
    HalfAdder HA_2_7 (FA_carry[52], HA_carry[9], HA_2_sum[7], HA_2_carry[7]);

    FullAdder FA_2_36 (FA_sum[56], FA_sum[57], FA_sum[58], FA_2_sum[36], FA_2_carry[36]);
    FullAdder FA_2_37 (HA_sum[11], FA_carry[53], FA_carry[54], FA_2_sum[37], FA_2_carry[37]);
    HalfAdder HA_2_8 (FA_carry[55], HA_carry[10], HA_2_sum[8], HA_2_carry[8]);

    FullAdder FA_2_38 (FA_sum[59], FA_sum[60], FA_sum[61], FA_2_sum[38], FA_2_carry[38]);
    FullAdder FA_2_39 (HA_sum[12], FA_carry[56], FA_carry[57], FA_2_sum[39], FA_2_carry[39]);
    HalfAdder HA_2_9 (FA_carry[58], HA_carry[11], HA_2_sum[9], HA_2_carry[9]);

    FullAdder FA_2_40 (FA_sum[62], FA_sum[63], FA_sum[64], FA_2_sum[40], FA_2_carry[40]);
    FullAdder FA_2_41 (HA_sum[13], FA_carry[59], FA_carry[60], FA_2_sum[41], FA_2_carry[41]);
    HalfAdder HA_2_10 (FA_carry[61], HA_carry[12], HA_2_sum[10], HA_2_carry[10]);

    FullAdder FA_2_42 (FA_sum[65], FA_sum[66], FA_sum[67], FA_2_sum[42], FA_2_carry[42]);
    FullAdder FA_2_43 (HA_sum[14], FA_carry[62], FA_carry[63], FA_2_sum[43], FA_2_carry[43]);
    HalfAdder HA_2_11 (FA_carry[64], HA_carry[13], HA_2_sum[11], HA_2_carry[11]);

    FullAdder FA_2_44 (FA_sum[68], FA_sum[69], FA_sum[70], FA_2_sum[44], FA_2_carry[44]);
    FullAdder FA_2_45 (HA_sum[15], FA_carry[65], FA_carry[66], FA_2_sum[45], FA_2_carry[45]);
    HalfAdder HA_2_12 (FA_carry[67], HA_carry[14], HA_2_sum[12], HA_2_carry[12]);

    FullAdder FA_2_46 (FA_sum[71], FA_sum[72], FA_sum[73], FA_2_sum[46], FA_2_carry[46]);
    FullAdder FA_2_47 (HA_sum[16], FA_carry[68], FA_carry[69], FA_2_sum[47], FA_2_carry[47]);
    HalfAdder HA_2_13 (FA_carry[70], HA_carry[15], HA_2_sum[13], HA_2_carry[13]);

    FullAdder FA_2_48 (FA_sum[74], FA_sum[75], FA_sum[76], FA_2_sum[48], FA_2_carry[48]);
    FullAdder FA_2_49 (HA_sum[17], FA_carry[71], FA_carry[72], FA_2_sum[49], FA_2_carry[49]);
    HalfAdder HA_2_14 (FA_carry[73], HA_carry[16], HA_2_sum[14], HA_2_carry[14]);

    FullAdder FA_2_50 (FA_sum[77], FA_sum[78], FA_sum[79], FA_2_sum[50], FA_2_carry[50]);
    FullAdder FA_2_51 (HA_sum[18], FA_carry[74], FA_carry[75], FA_2_sum[51], FA_2_carry[51]);
    HalfAdder HA_2_15 (FA_carry[76], HA_carry[17], HA_2_sum[15], HA_2_carry[15]);

    FullAdder FA_2_52 (FA_sum[80], FA_sum[81], FA_sum[82], FA_2_sum[52], FA_2_carry[52]);
    FullAdder FA_2_53 (HA_sum[19], FA_carry[77], FA_carry[78], FA_2_sum[53], FA_2_carry[53]);
    HalfAdder HA_2_16 (FA_carry[79], HA_carry[18], HA_2_sum[16], HA_2_carry[16]);

    FullAdder FA_2_54 (FA_sum[83], FA_sum[84], FA_sum[85], FA_2_sum[54], FA_2_carry[54]);
    FullAdder FA_2_55 (HA_sum[20], FA_carry[80], FA_carry[81], FA_2_sum[55], FA_2_carry[55]);
    HalfAdder HA_2_17 (FA_carry[82], HA_carry[19], HA_2_sum[17], HA_2_carry[17]);

    FullAdder FA_2_56 (FA_sum[86], FA_sum[87], FA_sum[88], FA_2_sum[56], FA_2_carry[56]);
    FullAdder FA_2_57 (HA_sum[21], FA_carry[83], FA_carry[84], FA_2_sum[57], FA_2_carry[57]);
    HalfAdder HA_2_18 (FA_carry[85], HA_carry[20], HA_2_sum[18], HA_2_carry[18]);

    FullAdder FA_2_58 (FA_sum[89], FA_sum[90], FA_sum[91], FA_2_sum[58], FA_2_carry[58]);
    FullAdder FA_2_59 (HA_sum[22], FA_carry[86], FA_carry[87], FA_2_sum[59], FA_2_carry[59]);
    HalfAdder HA_2_19 (FA_carry[88], HA_carry[21], HA_2_sum[19], HA_2_carry[19]);

    FullAdder FA_2_60 (FA_sum[92], FA_sum[93], FA_sum[94], FA_2_sum[60], FA_2_carry[60]);
    FullAdder FA_2_61 (HA_sum[23], FA_carry[89], FA_carry[90], FA_2_sum[61], FA_2_carry[61]);
    HalfAdder HA_2_20 (FA_carry[91], HA_carry[22], HA_2_sum[20], HA_2_carry[20]);

    FullAdder FA_2_62 (FA_sum[95], FA_sum[96], FA_sum[97], FA_2_sum[62], FA_2_carry[62]);
    FullAdder FA_2_63 (HA_sum[24], FA_carry[92], FA_carry[93], FA_2_sum[63], FA_2_carry[63]);
    HalfAdder HA_2_21 (FA_carry[94], HA_carry[23], HA_2_sum[21], HA_2_carry[21]);

    FullAdder FA_2_64 (FA_sum[98], FA_sum[99], FA_sum[100], FA_2_sum[64], FA_2_carry[64]);
    FullAdder FA_2_65 (HA_sum[25], FA_carry[95], FA_carry[96], FA_2_sum[65], FA_2_carry[65]);
    HalfAdder HA_2_22 (FA_carry[97], HA_carry[24], HA_2_sum[22], HA_2_carry[22]);

    FullAdder FA_2_66 (FA_sum[101], FA_sum[102], FA_sum[103], FA_2_sum[66], FA_2_carry[66]);
    FullAdder FA_2_67 (HA_sum[26], FA_carry[98], FA_carry[99], FA_2_sum[67], FA_2_carry[67]);
    HalfAdder HA_2_23 (FA_carry[100], HA_carry[25], HA_2_sum[23], HA_2_carry[23]);

    FullAdder FA_2_68 (FA_sum[104], FA_sum[105], FA_sum[106], FA_2_sum[68], FA_2_carry[68]);
    FullAdder FA_2_69 (HA_sum[27], FA_carry[101], FA_carry[102], FA_2_sum[69], FA_2_carry[69]);
    HalfAdder HA_2_24 (FA_carry[103], HA_carry[26], HA_2_sum[24], HA_2_carry[24]);

    FullAdder FA_2_70 (FA_sum[107], FA_sum[108], FA_sum[109], FA_2_sum[70], FA_2_carry[70]);
    FullAdder FA_2_71 (HA_sum[28], FA_carry[104], FA_carry[105], FA_2_sum[71], FA_2_carry[71]);
    HalfAdder HA_2_25 (FA_carry[106], HA_carry[27], HA_2_sum[25], HA_2_carry[25]);

    FullAdder FA_2_72 (FA_sum[110], FA_sum[111], FA_sum[112], FA_2_sum[72], FA_2_carry[72]);
    FullAdder FA_2_73 (HA_sum[29], FA_carry[107], FA_carry[108], FA_2_sum[73], FA_2_carry[73]);
    HalfAdder HA_2_26 (FA_carry[109], HA_carry[28], HA_2_sum[26], HA_2_carry[26]);

    FullAdder FA_2_74 (FA_sum[113], FA_sum[114], FA_sum[115], FA_2_sum[74], FA_2_carry[74]);
    FullAdder FA_2_75 (HA_sum[30], FA_carry[110], FA_carry[111], FA_2_sum[75], FA_2_carry[75]);
    HalfAdder HA_2_27 (FA_carry[112], HA_carry[29], HA_2_sum[27], HA_2_carry[27]);

    FullAdder FA_2_76 (FA_sum[116], FA_sum[117], FA_sum[118], FA_2_sum[76], FA_2_carry[76]);
    FullAdder FA_2_77 (HA_sum[31], FA_carry[113], FA_carry[114], FA_2_sum[77], FA_2_carry[77]);
    HalfAdder HA_2_28 (FA_carry[115], HA_carry[30], HA_2_sum[28], HA_2_carry[28]);

    FullAdder FA_2_78 (FA_sum[119], FA_sum[120], FA_sum[121], FA_2_sum[78], FA_2_carry[78]);
    FullAdder FA_2_79 (HA_sum[32], FA_carry[116], FA_carry[117], FA_2_sum[79], FA_2_carry[79]);
    HalfAdder HA_2_29 (FA_carry[118], HA_carry[31], HA_2_sum[29], HA_2_carry[29]);

    FullAdder FA_2_80 (FA_sum[122], FA_sum[123], FA_sum[124], FA_2_sum[80], FA_2_carry[80]);
    FullAdder FA_2_81 (HA_sum[33], FA_carry[119], FA_carry[120], FA_2_sum[81], FA_2_carry[81]);
    HalfAdder HA_2_30 (FA_carry[121], HA_carry[32], HA_2_sum[30], HA_2_carry[30]);

    FullAdder FA_2_82 (FA_sum[125], FA_sum[126], FA_sum[127], FA_2_sum[82], FA_2_carry[82]);
    FullAdder FA_2_83 (HA_sum[34], FA_carry[122], FA_carry[123], FA_2_sum[83], FA_2_carry[83]);
    HalfAdder HA_2_31 (FA_carry[124], HA_carry[33], HA_2_sum[31], HA_2_carry[31]);

    FullAdder FA_2_84 (FA_sum[128], FA_sum[129], FA_sum[130], FA_2_sum[84], FA_2_carry[84]);
    FullAdder FA_2_85 (HA_sum[35], FA_carry[125], FA_carry[126], FA_2_sum[85], FA_2_carry[85]);
    HalfAdder HA_2_32 (FA_carry[127], HA_carry[34], HA_2_sum[32], HA_2_carry[32]);

    FullAdder FA_2_86 (FA_sum[131], FA_sum[132], FA_sum[133], FA_2_sum[86], FA_2_carry[86]);
    FullAdder FA_2_87 (HA_sum[36], FA_carry[128], FA_carry[129], FA_2_sum[87], FA_2_carry[87]);
    HalfAdder HA_2_33 (FA_carry[130], HA_carry[35], HA_2_sum[33], HA_2_carry[33]);

    FullAdder FA_2_88 (FA_sum[134], FA_sum[135], FA_sum[136], FA_2_sum[88], FA_2_carry[88]);
    FullAdder FA_2_89 (HA_sum[37], FA_carry[131], FA_carry[132], FA_2_sum[89], FA_2_carry[89]);
    HalfAdder HA_2_34 (FA_carry[133], HA_carry[36], HA_2_sum[34], HA_2_carry[34]);

    FullAdder FA_2_90 (FA_sum[137], FA_sum[138], FA_sum[139], FA_2_sum[90], FA_2_carry[90]);
    FullAdder FA_2_91 (HA_sum[38], FA_carry[134], FA_carry[135], FA_2_sum[91], FA_2_carry[91]);
    HalfAdder HA_2_35 (FA_carry[136], HA_carry[37], HA_2_sum[35], HA_2_carry[35]);

    FullAdder FA_2_92 (FA_sum[140], FA_sum[141], FA_sum[142], FA_2_sum[92], FA_2_carry[92]);
    FullAdder FA_2_93 (HA_sum[39], FA_carry[137], FA_carry[138], FA_2_sum[93], FA_2_carry[93]);
    HalfAdder HA_2_36 (FA_carry[139], HA_carry[38], HA_2_sum[36], HA_2_carry[36]);

    FullAdder FA_2_94 (FA_sum[143], FA_sum[144], FA_sum[145], FA_2_sum[94], FA_2_carry[94]);
    FullAdder FA_2_95 (HA_sum[40], FA_carry[140], FA_carry[141], FA_2_sum[95], FA_2_carry[95]);
    HalfAdder HA_2_37 (FA_carry[142], HA_carry[39], HA_2_sum[37], HA_2_carry[37]);

    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            P1_double <= 0;
			P2_double <= 0;
			P3_double <= 0;
			P4_double <= 0;
			P5_double <= 0;
			P6_double <= 0;
			P7_double <= 0;
			P8_double <= 0;
			P9_double <= 0;
			P10_double <= 0;
			P11_double <= 0;

            FA_sum_reg <= 0;
            FA_carry_reg <= 0;

            HA_sum_reg <= 0;
            HA_carry_reg <= 0;

            FA_2_sum_reg <= 0;
            FA_2_carry_reg <= 0;

            HA_2_sum_reg <= 0;
            HA_2_carry_reg <= 0;
        end
        else begin
            P1_double <= P1;
			P2_double <= P2;
			P3_double <= P3;
			P4_double <= P4;
			P5_double <= P5;
			P6_double <= P6;
			P7_double <= P7;
			P8_double <= P8;
			P9_double <= P9;
			P10_double <= P10;
			P11_double <= P11;

            FA_sum_reg <= FA_sum;
            FA_carry_reg <= FA_carry;

            HA_sum_reg <= HA_sum;
            HA_carry_reg <= HA_carry;

            FA_2_sum_reg <= FA_2_sum;
            FA_2_carry_reg <= FA_2_carry;

            HA_2_sum_reg <= HA_2_sum;
            HA_2_carry_reg <= HA_2_carry;
        end
    end

    HalfAdder HA3_0 (FA_2_sum_reg[3], HA_carry_reg[1], HA_3_sum[0], HA_3_carry[0]);
    HalfAdder HA3_1 (FA_2_carry_reg[21], FA_2_carry_reg[22], HA_3_sum[1], HA_3_carry[1]);
    HalfAdder HA3_2 (FA_2_carry_reg[23], FA_2_carry_reg[24], HA_3_sum[2], HA_3_carry[2]);
    HalfAdder HA3_3 (FA_2_carry_reg[25], FA_2_carry_reg[26], HA_3_sum[3], HA_3_carry[3]);
    HalfAdder HA3_4 (FA_2_carry_reg[27], FA_2_carry_reg[28], HA_3_sum[4], HA_3_carry[4]);
    HalfAdder HA3_5 (FA_2_carry_reg[29], FA_2_carry_reg[30], HA_3_sum[5], HA_3_carry[5]);

    FullAdder FA_3_0 (FA_2_sum_reg[4], FA_2_carry_reg[3], HA_3_carry[0], FA_3_sum[0], FA_3_carry[0]);
    FullAdder FA_3_1 (FA_2_sum_reg[5], FA_2_carry_reg[4], HA_carry_reg[3], FA_3_sum[1], FA_3_carry[1]);
    FullAdder FA_3_2 (FA_2_sum_reg[6], FA_2_carry_reg[5], FA_carry_reg[9], FA_3_sum[2], FA_3_carry[2]);
    FullAdder FA_3_3 (FA_2_sum_reg[7], FA_2_carry_reg[6], FA_carry_reg[11], FA_3_sum[3], FA_3_carry[3]);
    FullAdder FA_3_4 (FA_2_sum_reg[8], FA_2_carry_reg[7], HA_2_sum_reg[1], FA_3_sum[4], FA_3_carry[4]);
    FullAdder FA_3_5 (FA_2_sum_reg[9], FA_2_carry_reg[8], HA_2_sum_reg[2], FA_3_sum[5], FA_3_carry[5]);
    FullAdder FA_3_6 (FA_2_sum_reg[10], FA_2_carry_reg[9], HA_2_sum_reg[3], FA_3_sum[6], FA_3_carry[6]);
    FullAdder FA_3_7 (FA_2_sum_reg[11], FA_2_carry_reg[10], HA_2_sum_reg[4], FA_3_sum[7], FA_3_carry[7]);
    FullAdder FA_3_8 (FA_2_sum_reg[12], FA_2_carry_reg[11], FA_2_sum_reg[13], FA_3_sum[8], FA_3_carry[8]);
    FullAdder FA_3_9 (FA_2_sum_reg[14], FA_2_carry_reg[12], FA_2_sum_reg[15], FA_3_sum[9], FA_3_carry[9]);
    FullAdder FA_3_10 (FA_2_sum_reg[16], FA_2_carry_reg[14], FA_2_sum_reg[17], FA_3_sum[10], FA_3_carry[10]);
    FullAdder FA_3_11 (FA_2_sum_reg[18], FA_2_carry_reg[16], FA_2_sum_reg[19], FA_3_sum[11], FA_3_carry[11]);
    FullAdder FA_3_12 (FA_2_sum_reg[20], FA_2_carry_reg[18], FA_2_sum_reg[21], FA_3_sum[12], FA_3_carry[12]);
    FullAdder FA_3_13 (FA_2_sum_reg[22], P10_double[0], FA_2_sum_reg[23], FA_3_sum[13], FA_3_carry[13]);

    FullAdder FA_3_14 (FA_2_sum_reg[24], P10_double[1], FA_2_sum_reg[25], FA_3_sum[14], FA_3_carry[14]);
    FullAdder FA_3_15 (FA_2_sum_reg[26], P10_double[2], FA_2_sum_reg[27], FA_3_sum[15], FA_3_carry[15]);
    FullAdder FA_3_16 (FA_2_sum_reg[28], FA_carry_reg[43], FA_2_sum_reg[29], FA_3_sum[16], FA_3_carry[16]);
    FullAdder FA_3_17 (FA_2_sum_reg[30], HA_2_sum_reg[5], FA_2_sum_reg[31], FA_3_sum[17], FA_3_carry[17]);
    FullAdder FA_3_18 (FA_2_sum_reg[32], HA_2_sum_reg[6], FA_2_sum_reg[33], FA_3_sum[18], FA_3_carry[18]);

    FullAdder FA_3_19 (FA_2_carry_reg[30], HA_2_carry_reg[5], FA_2_carry_reg[31], FA_3_sum[19], FA_3_carry[19]);
    FullAdder FA_3_20 (FA_2_sum_reg[34], HA_2_sum_reg[7], FA_2_sum_reg[35], FA_3_sum[20], FA_3_carry[20]);
    FullAdder FA_3_21 (FA_2_carry_reg[32], HA_2_carry_reg[6], FA_2_carry_reg[33], FA_3_sum[21], FA_3_carry[21]);

    FullAdder FA_3_22 (FA_2_sum_reg[36], HA_2_sum_reg[8], FA_2_sum_reg[37], FA_3_sum[22], FA_3_carry[22]);
    FullAdder FA_3_23 (FA_2_carry_reg[34], HA_2_carry_reg[7], FA_2_carry_reg[35], FA_3_sum[23], FA_3_carry[23]);

    FullAdder FA_3_24 (FA_2_sum_reg[38], HA_2_sum_reg[9], FA_2_sum_reg[39], FA_3_sum[24], FA_3_carry[24]);
    FullAdder FA_3_25 (FA_2_carry_reg[36], HA_2_carry_reg[8], FA_2_carry_reg[37], FA_3_sum[25], FA_3_carry[25]);

    FullAdder FA_3_26 (FA_2_sum_reg[40], HA_2_sum_reg[10], FA_2_sum_reg[41], FA_3_sum[26], FA_3_carry[26]);
    FullAdder FA_3_27 (FA_2_carry_reg[38], HA_2_carry_reg[9], FA_2_carry_reg[39], FA_3_sum[27], FA_3_carry[27]);

    FullAdder FA_3_28 (FA_2_sum_reg[42], HA_2_sum_reg[11], FA_2_sum_reg[43], FA_3_sum[28], FA_3_carry[28]);
    FullAdder FA_3_29 (FA_2_carry_reg[40], HA_2_carry_reg[10], FA_2_carry_reg[41], FA_3_sum[29], FA_3_carry[29]);

    FullAdder FA_3_30 (FA_2_sum_reg[44], HA_2_sum_reg[12], FA_2_sum_reg[45], FA_3_sum[30], FA_3_carry[30]);
    FullAdder FA_3_31 (FA_2_carry_reg[42], HA_2_carry_reg[11], FA_2_carry_reg[43], FA_3_sum[31], FA_3_carry[31]);

    FullAdder FA_3_32 (FA_2_sum_reg[46], HA_2_sum_reg[13], FA_2_sum_reg[47], FA_3_sum[32], FA_3_carry[32]);
    FullAdder FA_3_33 (FA_2_carry_reg[44], HA_2_carry_reg[12], FA_2_carry_reg[45], FA_3_sum[33], FA_3_carry[33]);

    FullAdder FA_3_34 (FA_2_sum_reg[48], HA_2_sum_reg[14], FA_2_sum_reg[49], FA_3_sum[34], FA_3_carry[34]);
    FullAdder FA_3_35 (FA_2_carry_reg[46], HA_2_carry_reg[13], FA_2_carry_reg[47], FA_3_sum[35], FA_3_carry[35]);

    FullAdder FA_3_36 (FA_2_sum_reg[50], HA_2_sum_reg[15], FA_2_sum_reg[51], FA_3_sum[36], FA_3_carry[36]);
    FullAdder FA_3_37 (FA_2_carry_reg[48], HA_2_carry_reg[14], FA_2_carry_reg[49], FA_3_sum[37], FA_3_carry[37]);

    FullAdder FA_3_38 (FA_2_sum_reg[52], HA_2_sum_reg[16], FA_2_sum_reg[53], FA_3_sum[38], FA_3_carry[38]);
    FullAdder FA_3_39 (FA_2_carry_reg[50], HA_2_carry_reg[15], FA_2_carry_reg[51], FA_3_sum[39], FA_3_carry[39]);

    FullAdder FA_3_40 (FA_2_sum_reg[54], HA_2_sum_reg[17], FA_2_sum_reg[55], FA_3_sum[40], FA_3_carry[40]);
    FullAdder FA_3_41 (FA_2_carry_reg[52], HA_2_carry_reg[16], FA_2_carry_reg[53], FA_3_sum[41], FA_3_carry[41]);

    FullAdder FA_3_42 (FA_2_sum_reg[56], HA_2_sum_reg[18], FA_2_sum_reg[57], FA_3_sum[42], FA_3_carry[42]);
    FullAdder FA_3_43 (FA_2_carry_reg[54], HA_2_carry_reg[17], FA_2_carry_reg[55], FA_3_sum[43], FA_3_carry[43]);

    FullAdder FA_3_44 (FA_2_sum_reg[58], HA_2_sum_reg[19], FA_2_sum_reg[59], FA_3_sum[44], FA_3_carry[44]);
    FullAdder FA_3_45 (FA_2_carry_reg[56], HA_2_carry_reg[18], FA_2_carry_reg[57], FA_3_sum[45], FA_3_carry[45]);

    FullAdder FA_3_46 (FA_2_sum_reg[60], HA_2_sum_reg[20], FA_2_sum_reg[61], FA_3_sum[46], FA_3_carry[46]);
    FullAdder FA_3_47 (FA_2_carry_reg[58], HA_2_carry_reg[19], FA_2_carry_reg[59], FA_3_sum[47], FA_3_carry[47]);

    FullAdder FA_3_48 (FA_2_sum_reg[62], HA_2_sum_reg[21], FA_2_sum_reg[63], FA_3_sum[48], FA_3_carry[48]);
    FullAdder FA_3_49 (FA_2_carry_reg[60], HA_2_carry_reg[20], FA_2_carry_reg[61], FA_3_sum[49], FA_3_carry[49]);

    FullAdder FA_3_50 (FA_2_sum_reg[64], HA_2_sum_reg[22], FA_2_sum_reg[65], FA_3_sum[50], FA_3_carry[50]);
    FullAdder FA_3_51 (FA_2_carry_reg[62], HA_2_carry_reg[21], FA_2_carry_reg[63], FA_3_sum[51], FA_3_carry[51]);

    FullAdder FA_3_52 (FA_2_sum_reg[66], HA_2_sum_reg[23], FA_2_sum_reg[67], FA_3_sum[52], FA_3_carry[52]);
    FullAdder FA_3_53 (FA_2_carry_reg[64], HA_2_carry_reg[22], FA_2_carry_reg[65], FA_3_sum[53], FA_3_carry[53]);

    FullAdder FA_3_54 (FA_2_sum_reg[68], HA_2_sum_reg[24], FA_2_sum_reg[69], FA_3_sum[54], FA_3_carry[54]);
    FullAdder FA_3_55 (FA_2_carry_reg[66], HA_2_carry_reg[23], FA_2_carry_reg[67], FA_3_sum[55], FA_3_carry[55]);

    FullAdder FA_3_56 (FA_2_sum_reg[70], HA_2_sum_reg[25], FA_2_sum_reg[71], FA_3_sum[56], FA_3_carry[56]);
    FullAdder FA_3_57 (FA_2_carry_reg[68], HA_2_carry_reg[24], FA_2_carry_reg[69], FA_3_sum[57], FA_3_carry[57]);

    FullAdder FA_3_58 (FA_2_sum_reg[72], HA_2_sum_reg[26], FA_2_sum_reg[73], FA_3_sum[58], FA_3_carry[58]);
    FullAdder FA_3_59 (FA_2_carry_reg[70], HA_2_carry_reg[25], FA_2_carry_reg[71], FA_3_sum[59], FA_3_carry[59]);

    FullAdder FA_3_60 (FA_2_sum_reg[74], HA_2_sum_reg[27], FA_2_sum_reg[75], FA_3_sum[60], FA_3_carry[60]);
    FullAdder FA_3_61 (FA_2_carry_reg[72], HA_2_carry_reg[26], FA_2_carry_reg[73], FA_3_sum[61], FA_3_carry[61]);

    FullAdder FA_3_62 (FA_2_sum_reg[76], HA_2_sum_reg[28], FA_2_sum_reg[77], FA_3_sum[62], FA_3_carry[62]);
    FullAdder FA_3_63 (FA_2_carry_reg[74], HA_2_carry_reg[27], FA_2_carry_reg[75], FA_3_sum[63], FA_3_carry[63]);

    FullAdder FA_3_64 (FA_2_sum_reg[78], HA_2_sum_reg[29], FA_2_sum_reg[79], FA_3_sum[64], FA_3_carry[64]);
    FullAdder FA_3_65 (FA_2_carry_reg[76], HA_2_carry_reg[28], FA_2_carry_reg[77], FA_3_sum[65], FA_3_carry[65]);

    FullAdder FA_3_66 (FA_2_sum_reg[80], HA_2_sum_reg[30], FA_2_sum_reg[81], FA_3_sum[66], FA_3_carry[66]);
    FullAdder FA_3_67 (FA_2_carry_reg[78], HA_2_carry_reg[29], FA_2_carry_reg[79], FA_3_sum[67], FA_3_carry[67]);

    FullAdder FA_3_68 (FA_2_sum_reg[82], HA_2_sum_reg[31], FA_2_sum_reg[83], FA_3_sum[68], FA_3_carry[68]);
    FullAdder FA_3_69 (FA_2_carry_reg[80], HA_2_carry_reg[30], FA_2_carry_reg[81], FA_3_sum[69], FA_3_carry[69]);

    FullAdder FA_3_70 (FA_2_sum_reg[84], HA_2_sum_reg[32], FA_2_sum_reg[85], FA_3_sum[70], FA_3_carry[70]);
    FullAdder FA_3_71 (FA_2_carry_reg[82], HA_2_carry_reg[31], FA_2_carry_reg[83], FA_3_sum[71], FA_3_carry[71]);

    FullAdder FA_3_72 (FA_2_sum_reg[86], HA_2_sum_reg[33], FA_2_sum_reg[87], FA_3_sum[72], FA_3_carry[72]);
    FullAdder FA_3_73 (FA_2_carry_reg[84], HA_2_carry_reg[32], FA_2_carry_reg[85], FA_3_sum[73], FA_3_carry[73]);

    FullAdder FA_3_74 (FA_2_sum_reg[88], HA_2_sum_reg[34], FA_2_sum_reg[89], FA_3_sum[74], FA_3_carry[74]);
    FullAdder FA_3_75 (FA_2_carry_reg[86], HA_2_carry_reg[33], FA_2_carry_reg[87], FA_3_sum[75], FA_3_carry[75]);

    FullAdder FA_3_76 (FA_2_sum_reg[90], HA_2_sum_reg[35], FA_2_sum_reg[91], FA_3_sum[76], FA_3_carry[76]);
    FullAdder FA_3_77 (FA_2_carry_reg[88], HA_2_carry_reg[34], FA_2_carry_reg[89], FA_3_sum[77], FA_3_carry[77]);

    FullAdder FA_3_78 (FA_2_sum_reg[92], HA_2_sum_reg[36], FA_2_sum_reg[93], FA_3_sum[78], FA_3_carry[78]);
    FullAdder FA_3_79 (FA_2_carry_reg[90], HA_2_carry_reg[35], FA_2_carry_reg[91], FA_3_sum[79], FA_3_carry[79]);

    FullAdder FA_3_80 (FA_2_sum_reg[94], HA_2_sum_reg[37], FA_2_sum_reg[95], FA_3_sum[80], FA_3_carry[80]);
    FullAdder FA_3_81 (FA_2_carry_reg[92], HA_2_carry_reg[36], FA_2_carry_reg[93], FA_3_sum[81], FA_3_carry[81]);

    HalfAdder HA_4_1 (FA_3_sum[5], HA_2_carry_reg[1], HA_4_1_sum, HA_4_1_carry);
    FullAdder FA_4_1 (FA_3_sum[6], HA_2_carry_reg[2], FA_3_carry[5], FA_4_sum[0], FA_4_carry[0]);
    FullAdder FA_4_2 (FA_3_sum[7], HA_2_carry_reg[3], FA_3_carry[6], FA_4_sum[1], FA_4_carry[1]);
    FullAdder FA_4_3 (FA_3_sum[8], HA_2_carry_reg[4], FA_3_carry[7], FA_4_sum[2], FA_4_carry[2]);
    FullAdder FA_4_4 (FA_3_sum[9], FA_2_carry_reg[13], FA_3_carry[8], FA_4_sum[3], FA_4_carry[3]);
    FullAdder FA_4_5 (FA_3_sum[10], FA_2_carry_reg[15], FA_3_carry[9], FA_4_sum[4], FA_4_carry[4]);
    FullAdder FA_4_6 (FA_3_sum[11], FA_2_carry_reg[17], FA_3_carry[10], FA_4_sum[5], FA_4_carry[5]);
    FullAdder FA_4_7 (FA_3_sum[12], FA_2_carry_reg[19], FA_3_carry[11], FA_4_sum[6], FA_4_carry[6]);
    FullAdder FA_4_8 (FA_3_sum[13], HA_3_sum[1], FA_3_carry[12], FA_4_sum[7], FA_4_carry[7]);
    FullAdder FA_4_9 (FA_3_sum[14], HA_3_sum[2], FA_3_carry[13], FA_4_sum[8], FA_4_carry[8]);
    FullAdder FA_4_10 (FA_3_sum[15], HA_3_sum[3], FA_3_carry[14], FA_4_sum[9], FA_4_carry[9]);

    FullAdder FA_4_11 (FA_3_sum[16], HA_3_sum[4], FA_3_carry[15], FA_4_sum[10], FA_4_carry[10]);
    FullAdder FA_4_12 (FA_3_sum[17], HA_3_sum[5], FA_3_carry[16], FA_4_sum[11], FA_4_carry[11]);
    FullAdder FA_4_13 (FA_3_sum[18], FA_3_sum[19], FA_3_carry[17], FA_4_sum[12], FA_4_carry[12]);
    FullAdder FA_4_14 (FA_3_sum[20], FA_3_sum[21], FA_3_carry[18], FA_4_sum[13], FA_4_carry[13]);
    FullAdder FA_4_15 (FA_3_sum[22], FA_3_sum[23], FA_3_carry[20], FA_4_sum[14], FA_4_carry[14]);

    FullAdder FA_4_16 (FA_3_sum[24], FA_3_sum[25], FA_3_carry[22], FA_4_sum[15], FA_4_carry[15]);
    FullAdder FA_4_17 (FA_3_sum[26], FA_3_sum[27], FA_3_carry[24], FA_4_sum[16], FA_4_carry[16]);
    FullAdder FA_4_18 (FA_3_sum[28], FA_3_sum[29], FA_3_carry[26], FA_4_sum[17], FA_4_carry[17]);
    FullAdder FA_4_19 (FA_3_sum[30], FA_3_sum[31], FA_3_carry[28], FA_4_sum[18], FA_4_carry[18]);
    FullAdder FA_4_20 (FA_3_sum[32], FA_3_sum[33], FA_3_carry[30], FA_4_sum[19], FA_4_carry[19]);
    FullAdder FA_4_21 (FA_3_sum[34], FA_3_sum[35], FA_3_carry[32], FA_4_sum[20], FA_4_carry[20]);
    FullAdder FA_4_22 (FA_3_sum[36], FA_3_sum[37], FA_3_carry[34], FA_4_sum[21], FA_4_carry[21]);
    FullAdder FA_4_23 (FA_3_sum[38], FA_3_sum[39], FA_3_carry[36], FA_4_sum[22], FA_4_carry[22]);
    FullAdder FA_4_24 (FA_3_sum[40], FA_3_sum[41], FA_3_carry[38], FA_4_sum[23], FA_4_carry[23]);
    FullAdder FA_4_25 (FA_3_sum[42], FA_3_sum[43], FA_3_carry[40], FA_4_sum[24], FA_4_carry[24]);
    FullAdder FA_4_26 (FA_3_sum[44], FA_3_sum[45], FA_3_carry[42], FA_4_sum[25], FA_4_carry[25]);
    FullAdder FA_4_27 (FA_3_sum[46], FA_3_sum[47], FA_3_carry[44], FA_4_sum[26], FA_4_carry[26]);
    FullAdder FA_4_28 (FA_3_sum[48], FA_3_sum[49], FA_3_carry[46], FA_4_sum[27], FA_4_carry[27]);
    FullAdder FA_4_29 (FA_3_sum[50], FA_3_sum[51], FA_3_carry[48], FA_4_sum[28], FA_4_carry[28]);
    FullAdder FA_4_30 (FA_3_sum[52], FA_3_sum[53], FA_3_carry[50], FA_4_sum[29], FA_4_carry[29]);
    FullAdder FA_4_31 (FA_3_sum[54], FA_3_sum[55], FA_3_carry[52], FA_4_sum[30], FA_4_carry[30]);
    FullAdder FA_4_32 (FA_3_sum[56], FA_3_sum[57], FA_3_carry[54], FA_4_sum[31], FA_4_carry[31]);
    FullAdder FA_4_33 (FA_3_sum[58], FA_3_sum[59], FA_3_carry[56], FA_4_sum[32], FA_4_carry[32]);
    FullAdder FA_4_34 (FA_3_sum[60], FA_3_sum[61], FA_3_carry[58], FA_4_sum[33], FA_4_carry[33]);
    FullAdder FA_4_35 (FA_3_sum[62], FA_3_sum[63], FA_3_carry[60], FA_4_sum[34], FA_4_carry[34]);
    FullAdder FA_4_36 (FA_3_sum[64], FA_3_sum[65], FA_3_carry[62], FA_4_sum[35], FA_4_carry[35]);
    FullAdder FA_4_37 (FA_3_sum[66], FA_3_sum[67], FA_3_carry[64], FA_4_sum[36], FA_4_carry[36]);
    FullAdder FA_4_38 (FA_3_sum[68], FA_3_sum[69], FA_3_carry[66], FA_4_sum[37], FA_4_carry[37]);
    FullAdder FA_4_39 (FA_3_sum[70], FA_3_sum[71], FA_3_carry[68], FA_4_sum[38], FA_4_carry[38]);
    FullAdder FA_4_40 (FA_3_sum[72], FA_3_sum[73], FA_3_carry[70], FA_4_sum[39], FA_4_carry[39]);
    FullAdder FA_4_41 (FA_3_sum[74], FA_3_sum[75], FA_3_carry[72], FA_4_sum[40], FA_4_carry[40]);
    FullAdder FA_4_42 (FA_3_sum[76], FA_3_sum[77], FA_3_carry[74], FA_4_sum[41], FA_4_carry[41]);
    FullAdder FA_4_43 (FA_3_sum[78], FA_3_sum[79], FA_3_carry[76], FA_4_sum[42], FA_4_carry[42]);
    FullAdder FA_4_44 (FA_3_sum[80], FA_3_sum[81], FA_3_carry[78], FA_4_sum[43], FA_4_carry[43]);


    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            P1_triple <= 0;
            P2_triple <= 0;
            P3_triple <= 0;
            P4_triple <= 0;
            P5_triple <= 0;
            P6_triple <= 0;
            P7_triple <= 0;
            P8_triple <= 0;
            P9_triple <= 0;
            P10_triple <= 0;
            P11_triple <= 0;

            FA_3_sum_reg <= 0;
            FA_3_carry_reg <= 0;

            FA_4_sum_reg <= 0;
            FA_4_carry_reg <= 0;

            FA_2_sum_double_reg <= 0;
            FA_2_carry_double_reg <= 0;

            FA_sum_double_reg <= 0;
            FA_carry_double_reg <= 0;

            HA_4_1_sum_reg <= 0;
            HA_4_1_carry_reg <= 0;

            HA_3_sum_reg <= 0;
            HA_3_carry_reg <= 0;

            HA_2_sum_double_reg <= 0;
            HA_2_carry_double_reg <= 0;

            HA_sum_double_reg <= 0;
            HA_carry_double_reg <= 0;
        end
        else begin
            P1_triple <= P1_double;
            P2_triple <= P2_double;
            P3_triple <= P3_double;
            P4_triple <= P4_double;
            P5_triple <= P5_double;
            P6_triple <= P6_double;
            P7_triple <= P7_double;
            P8_triple <= P8_double;
            P9_triple <= P9_double;
            P10_triple <= P10_double;
            P11_triple <= P11_double;

            FA_3_sum_reg <= FA_3_sum;
            FA_3_carry_reg <= FA_3_carry;

            FA_4_sum_reg <= FA_4_sum;
            FA_4_carry_reg <= FA_4_carry;

            FA_2_sum_double_reg <= FA_2_sum_reg;
            FA_2_carry_double_reg <= FA_2_carry_reg;

            FA_sum_double_reg <= FA_sum_reg;
            FA_carry_double_reg <= FA_carry_reg;

            HA_4_1_sum_reg <= HA_4_1_sum;
            HA_4_1_carry_reg <= HA_4_1_carry;

            HA_3_sum_reg <= HA_3_sum;
            HA_3_carry_reg <= HA_3_carry;

            HA_2_sum_double_reg <= HA_2_sum_reg;
            HA_2_carry_double_reg <= HA_2_carry_reg;

            HA_sum_double_reg <= HA_sum_reg;
            HA_carry_double_reg <= HA_carry_reg;
        end
    end

    HalfAdder HA_5_1 (FA_4_sum_reg[8], HA_3_carry_reg[1], HA_5_1_sum, HA_5_1_carry);
    FullAdder FA_5_1 (FA_4_sum_reg[9], FA_3_carry_reg[2], FA_4_carry_reg[8], FA_5_sum[0], FA_5_carry[0]);
    FullAdder FA_5_2 (FA_4_sum_reg[10], FA_3_carry_reg[3], FA_4_carry_reg[9], FA_5_sum[1], FA_5_carry[1]);
    FullAdder FA_5_3 (FA_4_sum_reg[11], FA_3_carry_reg[4], FA_4_carry_reg[10], FA_5_sum[2], FA_5_carry[2]);
    FullAdder FA_5_4 (FA_4_sum_reg[12], FA_3_carry_reg[5], FA_4_carry_reg[11], FA_5_sum[3], FA_5_carry[3]);
    FullAdder FA_5_5 (FA_4_sum_reg[13], FA_3_carry_reg[19], FA_4_carry_reg[12], FA_5_sum[4], FA_5_carry[4]);
    FullAdder FA_5_6 (FA_4_sum_reg[14], FA_3_carry_reg[21], FA_4_carry_reg[13], FA_5_sum[5], FA_5_carry[5]);
    FullAdder FA_5_7 (FA_4_sum_reg[15], FA_3_carry_reg[23], FA_4_carry_reg[14], FA_5_sum[6], FA_5_carry[6]);
    FullAdder FA_5_8 (FA_4_sum_reg[16], FA_3_carry_reg[25], FA_4_carry_reg[15], FA_5_sum[7], FA_5_carry[7]);
    FullAdder FA_5_9 (FA_4_sum_reg[17], FA_3_carry_reg[27], FA_4_carry_reg[16], FA_5_sum[8], FA_5_carry[8]);
    FullAdder FA_5_10 (FA_4_sum_reg[18], FA_3_carry_reg[29], FA_4_carry_reg[17], FA_5_sum[9], FA_5_carry[9]);
    FullAdder FA_5_11 (FA_4_sum_reg[19], FA_3_carry_reg[31], FA_4_carry_reg[18], FA_5_sum[10], FA_5_carry[10]);
    FullAdder FA_5_12 (FA_4_sum_reg[20], FA_3_carry_reg[33], FA_4_carry_reg[19], FA_5_sum[11], FA_5_carry[11]);
    FullAdder FA_5_13 (FA_4_sum_reg[21], FA_3_carry_reg[35], FA_4_carry_reg[20], FA_5_sum[12], FA_5_carry[12]);
    FullAdder FA_5_14 (FA_4_sum_reg[22], FA_3_carry_reg[37], FA_4_carry_reg[21], FA_5_sum[13], FA_5_carry[13]);
    FullAdder FA_5_15 (FA_4_sum_reg[23], FA_3_carry_reg[39], FA_4_carry_reg[22], FA_5_sum[14], FA_5_carry[14]);
    FullAdder FA_5_16 (FA_4_sum_reg[24], FA_3_carry_reg[41], FA_4_carry_reg[23], FA_5_sum[15], FA_5_carry[15]);
    FullAdder FA_5_17 (FA_4_sum_reg[25], FA_3_carry_reg[43], FA_4_carry_reg[24], FA_5_sum[16], FA_5_carry[16]);
    FullAdder FA_5_18 (FA_4_sum_reg[26], FA_3_carry_reg[45], FA_4_carry_reg[25], FA_5_sum[17], FA_5_carry[17]);
    FullAdder FA_5_19 (FA_4_sum_reg[27], FA_3_carry_reg[47], FA_4_carry_reg[26], FA_5_sum[18], FA_5_carry[18]);
    FullAdder FA_5_20 (FA_4_sum_reg[28], FA_3_carry_reg[49], FA_4_carry_reg[27], FA_5_sum[19], FA_5_carry[19]);
    FullAdder FA_5_21 (FA_4_sum_reg[29], FA_3_carry_reg[51], FA_4_carry_reg[28], FA_5_sum[20], FA_5_carry[20]);
    FullAdder FA_5_22 (FA_4_sum_reg[30], FA_3_carry_reg[53], FA_4_carry_reg[29], FA_5_sum[21], FA_5_carry[21]);
    FullAdder FA_5_23 (FA_4_sum_reg[31], FA_3_carry_reg[55], FA_4_carry_reg[30], FA_5_sum[22], FA_5_carry[22]);
    FullAdder FA_5_24 (FA_4_sum_reg[32], FA_3_carry_reg[57], FA_4_carry_reg[31], FA_5_sum[23], FA_5_carry[23]);
    FullAdder FA_5_25 (FA_4_sum_reg[33], FA_3_carry_reg[59], FA_4_carry_reg[32], FA_5_sum[24], FA_5_carry[24]);
    FullAdder FA_5_26 (FA_4_sum_reg[34], FA_3_carry_reg[61], FA_4_carry_reg[33], FA_5_sum[25], FA_5_carry[25]);
    FullAdder FA_5_27 (FA_4_sum_reg[35], FA_3_carry_reg[63], FA_4_carry_reg[34], FA_5_sum[26], FA_5_carry[26]);
    FullAdder FA_5_28 (FA_4_sum_reg[36], FA_3_carry_reg[65], FA_4_carry_reg[35], FA_5_sum[27], FA_5_carry[27]);
    FullAdder FA_5_29 (FA_4_sum_reg[37], FA_3_carry_reg[67], FA_4_carry_reg[36], FA_5_sum[28], FA_5_carry[28]);
    FullAdder FA_5_30 (FA_4_sum_reg[38], FA_3_carry_reg[69], FA_4_carry_reg[37], FA_5_sum[29], FA_5_carry[29]);
    FullAdder FA_5_31 (FA_4_sum_reg[39], FA_3_carry_reg[71], FA_4_carry_reg[38], FA_5_sum[30], FA_5_carry[30]);
    FullAdder FA_5_32 (FA_4_sum_reg[40], FA_3_carry_reg[73], FA_4_carry_reg[39], FA_5_sum[31], FA_5_carry[31]);
    FullAdder FA_5_33 (FA_4_sum_reg[41], FA_3_carry_reg[75], FA_4_carry_reg[40], FA_5_sum[32], FA_5_carry[32]);
    FullAdder FA_5_34 (FA_4_sum_reg[42], FA_3_carry_reg[77], FA_4_carry_reg[41], FA_5_sum[33], FA_5_carry[33]);
    FullAdder FA_5_35 (FA_4_sum_reg[43], FA_3_carry_reg[79], FA_4_carry_reg[42], FA_5_sum[34], FA_5_carry[34]);

    wire [63:0] arg1 = {
    FA_5_sum[34], FA_5_sum[33], FA_5_sum[32], FA_5_sum[31],
    FA_5_sum[30], FA_5_sum[29], FA_5_sum[28], FA_5_sum[27],
    FA_5_sum[26], FA_5_sum[25], FA_5_sum[24], FA_5_sum[23],
    FA_5_sum[22], FA_5_sum[21], FA_5_sum[20], FA_5_sum[19],
    FA_5_sum[18], FA_5_sum[17], FA_5_sum[16], FA_5_sum[15],
    FA_5_sum[14], FA_5_sum[13], FA_5_sum[12], FA_5_sum[11],
    FA_5_sum[10], FA_5_sum[9], FA_5_sum[8],  FA_5_sum[7],
    FA_5_sum[6],  FA_5_sum[5],  FA_5_sum[4],  FA_5_sum[3],
    FA_5_sum[2], FA_5_sum[1], FA_5_sum[0], HA_5_1_sum,
    FA_4_sum_reg[7], FA_4_sum_reg[6], FA_4_sum_reg[5], FA_4_sum_reg[4],
    FA_4_sum_reg[3], FA_4_sum_reg[2],  FA_4_sum_reg[1],  FA_4_sum_reg[0],
    HA_4_1_sum_reg,  FA_3_sum_reg[4],  FA_3_sum_reg[3],  FA_3_sum_reg[2],
    FA_3_sum_reg[1],  FA_3_sum_reg[0],  HA_3_sum_reg[0],  FA_2_sum_double_reg[2],
    FA_2_sum_double_reg[1],  FA_2_sum_double_reg[0],  HA_2_sum_double_reg[0],  FA_sum_double_reg[1],
    FA_sum_double_reg[0],     HA_sum_double_reg[0],     P1_triple[5],       P1_triple[4],
    P1_triple[3],       P1_triple[2],       P1_triple[1],       P1_triple[0]
};

    wire [63:0] arg2 = {
    FA_5_carry[33], FA_5_carry[32], FA_5_carry[31], FA_5_carry[30],
    FA_5_carry[29], FA_5_carry[28], FA_5_carry[27], FA_5_carry[26],
    FA_5_carry[25], FA_5_carry[24], FA_5_carry[23], FA_5_carry[22],
    FA_5_carry[21], FA_5_carry[20], FA_5_carry[19], FA_5_carry[18],
    FA_5_carry[17], FA_5_carry[16], FA_5_carry[15], FA_5_carry[14],
    FA_5_carry[13], FA_5_carry[12], FA_5_carry[11], FA_5_carry[10],
    FA_5_carry[9], FA_5_carry[8],  FA_5_carry[7],  FA_5_carry[6],
    FA_5_carry[5],  FA_5_carry[4],  FA_5_carry[3],
    FA_5_carry[2], FA_5_carry[1], FA_5_carry[0], HA_5_1_carry,
    FA_4_carry_reg[7], FA_4_carry_reg[6], FA_4_carry_reg[5], FA_4_carry_reg[4],
    FA_4_carry_reg[3], FA_4_carry_reg[2], FA_4_carry_reg[1], FA_4_carry_reg[0],
    HA_4_1_carry_reg,  FA_3_carry_reg[4],  FA_3_carry_reg[3],  FA_3_carry_reg[2],
    FA_3_carry_reg[1],  FA_3_carry_reg[0],  HA_3_carry_reg[0],  FA_2_carry_double_reg[2],
    FA_2_carry_double_reg[1],  FA_2_carry_double_reg[0],  HA_2_carry_double_reg[0],  P4_triple[0],
    FA_carry_double_reg[0], HA_carry_double_reg[0], P3_triple[0],P2_triple[2],P2_triple[1],P2_triple[0],1'b0,1'b0,1'b0
};

    assign carries[0] = 1'b0;
    
    genvar i;
    generate
      for (i = 0; i < 64; i = i + 1) begin: cpa_loop
        assign sum[i] = arg1[i] ^ arg2[i] ^ carries[i];
        assign carries[i+1] = (arg1[i] & arg2[i]) | (arg1[i] & carries[i]) | (arg2[i] & carries[i]);
      end
    endgenerate
endmodule

