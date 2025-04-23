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
    
    reg [63:0] P1;
    reg [60:0] P2;
    reg [57:0] P3;
    reg [54:0] P4;
    reg [51:0] P5;
    reg [48:0] P6;
    reg [45:0] P7;
    reg [42:0] P8;
    reg [39:0] P9;
    reg [36:0] P10;
    reg [33:0] P11;
    
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
    
    // Stage 1 wires
    wire HA1_sum, HA2_sum, HA3_sum, HA4_sum;
    wire HA1_carry, HA2_carry, HA3_carry, HA4_carry;
    wire FA1_sum, FA2_sum, FA3_sum, FA4_sum, FA5_sum, FA6_sum, FA7_sum, FA8_sum, FA9_sum, FA10_sum;
    wire FA1_carry, FA2_carry, FA3_carry, FA4_carry, FA5_carry, FA6_carry, FA7_carry, FA8_carry, FA9_carry, FA10_carry;
    wire FA11_sum, FA12_sum, FA13_sum, FA14_sum, FA15_sum, FA16_sum, FA17_sum, FA18_sum, FA19_sum, FA20_sum;
    wire FA11_carry, FA12_carry, FA13_carry, FA14_carry, FA15_carry, FA16_carry, FA17_carry, FA18_carry, FA19_carry, FA20_carry;
    wire FA21_sum, FA22_sum, FA23_sum, FA24_sum, FA25_sum, FA26_sum, FA27_sum, FA28_sum, FA29_sum, FA30_sum;
    wire FA21_carry, FA22_carry, FA23_carry, FA24_carry, FA25_carry, FA26_carry, FA27_carry, FA28_carry, FA29_carry, FA30_carry;
    wire FA31_sum, FA32_sum, FA33_sum, FA34_sum, FA35_sum, FA36_sum, FA37_sum, FA38_sum, FA39_sum, FA40_sum, FA41_sum, FA42_sum;
    wire FA31_carry, FA32_carry, FA33_carry, FA34_carry, FA35_carry, FA36_carry, FA37_carry, FA38_carry, FA39_carry, FA40_carry, FA41_carry, FA42_carry;
    
    // Half Adders for Stage 1
    wire HA5_sum, HA5_carry, HA6_sum, HA6_carry, HA7_sum, HA7_carry;
    wire HA8_sum, HA8_carry, HA9_sum, HA9_carry, HA10_sum, HA10_carry;
    wire HA11_sum, HA11_carry, HA12_sum, HA12_carry, HA13_sum, HA13_carry;
    wire HA14_sum, HA14_carry, HA15_sum, HA15_carry, HA16_sum, HA16_carry;
    wire HA17_sum, HA17_carry, HA18_sum, HA18_carry, HA19_sum, HA19_carry;
    wire HA20_sum, HA20_carry, HA21_sum, HA21_carry, HA22_sum, HA22_carry;
    wire HA23_sum, HA23_carry, HA24_sum, HA24_carry, HA25_sum, HA25_carry;
    wire HA26_sum, HA26_carry, HA27_sum, HA27_carry, HA28_sum, HA28_carry;
    wire HA29_sum, HA29_carry, HA30_sum, HA30_carry, HA31_sum, HA31_carry;
    wire HA32_sum, HA32_carry, HA33_sum, HA33_carry, HA34_sum, HA34_carry;
    wire HA35_sum, HA35_carry, HA36_sum, HA36_carry, HA37_sum, HA37_carry;
    wire HA38_sum, HA38_carry, HA39_sum, HA39_carry, HA40_sum, HA40_carry;
    wire HA41_sum, HA41_carry;
    
    // Additional Full Adder wires
    wire FA43_sum, FA43_carry, FA44_sum, FA44_carry, FA45_sum, FA45_carry;
    wire FA46_sum, FA46_carry, FA47_sum, FA47_carry, FA48_sum, FA48_carry;
    wire FA49_sum, FA49_carry, FA50_sum, FA50_carry, FA51_sum, FA51_carry;
    wire FA52_sum, FA52_carry, FA53_sum, FA53_carry, FA54_sum, FA54_carry;
    wire FA55_sum, FA55_carry, FA56_sum, FA56_carry, FA57_sum, FA57_carry;
    wire FA58_sum, FA58_carry, FA59_sum, FA59_carry, FA60_sum, FA60_carry;
    wire FA61_sum, FA61_carry, FA62_sum, FA62_carry, FA63_sum, FA63_carry;
    wire FA64_sum, FA64_carry, FA65_sum, FA65_carry, FA66_sum, FA66_carry;
    wire FA67_sum, FA67_carry, FA68_sum, FA68_carry, FA69_sum, FA69_carry;
    wire FA70_sum, FA70_carry, FA71_sum, FA71_carry, FA72_sum, FA72_carry;
    wire FA73_sum, FA73_carry, FA74_sum, FA74_carry, FA75_sum, FA75_carry;
    wire FA76_sum, FA76_carry, FA77_sum, FA77_carry, FA78_sum, FA78_carry;
    wire FA79_sum, FA79_carry, FA80_sum, FA80_carry, FA81_sum, FA81_carry;
    wire FA82_sum, FA82_carry, FA83_sum, FA83_carry, FA84_sum, FA84_carry;
    wire FA85_sum, FA85_carry, FA86_sum, FA86_carry, FA87_sum, FA87_carry;
    wire FA88_sum, FA88_carry, FA89_sum, FA89_carry, FA90_sum, FA90_carry;
    wire FA91_sum, FA91_carry, FA92_sum, FA92_carry, FA93_sum, FA93_carry;
    wire FA94_sum, FA94_carry, FA95_sum, FA95_carry, FA96_sum, FA96_carry;
    wire FA97_sum, FA97_carry, FA98_sum, FA98_carry, FA99_sum, FA99_carry;
    wire FA100_sum, FA100_carry, FA101_sum, FA101_carry, FA102_sum, FA102_carry;
    wire FA103_sum, FA103_carry, FA104_sum, FA104_carry, FA105_sum, FA105_carry;
    wire FA106_sum, FA106_carry, FA107_sum, FA107_carry, FA108_sum, FA108_carry;
    wire FA109_sum, FA109_carry, FA110_sum, FA110_carry, FA111_sum, FA111_carry;
    wire FA112_sum, FA112_carry, FA113_sum, FA113_carry, FA114_sum, FA114_carry;
    wire FA115_sum, FA115_carry, FA116_sum, FA116_carry, FA117_sum, FA117_carry;
    wire FA118_sum, FA118_carry, FA119_sum, FA119_carry, FA120_sum, FA120_carry;
    wire FA121_sum, FA121_carry, FA122_sum, FA122_carry, FA123_sum, FA123_carry;
    wire FA124_sum, FA124_carry, FA125_sum, FA125_carry, FA126_sum, FA126_carry;
    wire FA127_sum, FA127_carry, FA128_sum, FA128_carry, FA129_sum, FA129_carry;
    wire FA130_sum, FA130_carry, FA131_sum, FA131_carry, FA132_sum, FA132_carry;
    wire FA133_sum, FA133_carry, FA134_sum, FA134_carry, FA135_sum, FA135_carry;
    wire FA136_sum, FA136_carry, FA137_sum, FA137_carry, FA138_sum, FA138_carry;
    wire FA139_sum, FA139_carry, FA140_sum, FA140_carry, FA141_sum, FA141_carry;
    wire FA142_sum, FA142_carry, FA143_sum, FA143_carry, FA144_sum, FA144_carry;
    wire FA145_sum, FA145_carry, FA146_sum, FA146_carry;
    
    // Stage 2 wires
    wire HA_2_1_sum, HA_2_1_carry, HA_2_2_sum, HA_2_2_carry, HA_2_3_sum, HA_2_3_carry;
    wire HA_2_4_sum, HA_2_4_carry, HA_2_5_sum, HA_2_5_carry, HA_2_6_sum, HA_2_6_carry;
    wire HA_2_7_sum, HA_2_7_carry, HA_2_8_sum, HA_2_8_carry, HA_2_9_sum, HA_2_9_carry;
    wire HA_2_10_sum, HA_2_10_carry, HA_2_11_sum, HA_2_11_carry, HA_2_12_sum, HA_2_12_carry;
    wire HA_2_13_sum, HA_2_13_carry, HA_2_14_sum, HA_2_14_carry, HA_2_15_sum, HA_2_15_carry;
    wire HA_2_16_sum, HA_2_16_carry, HA_2_17_sum, HA_2_17_carry, HA_2_18_sum, HA_2_18_carry;
    wire HA_2_19_sum, HA_2_19_carry, HA_2_20_sum, HA_2_20_carry, HA_2_21_sum, HA_2_21_carry;
    wire HA_2_22_sum, HA_2_22_carry, HA_2_23_sum, HA_2_23_carry, HA_2_24_sum, HA_2_24_carry;
    wire HA_2_25_sum, HA_2_25_carry, HA_2_26_sum, HA_2_26_carry, HA_2_27_sum, HA_2_27_carry;
    wire HA_2_28_sum, HA_2_28_carry, HA_2_29_sum, HA_2_29_carry, HA_2_30_sum, HA_2_30_carry;
    wire HA_2_31_sum, HA_2_31_carry, HA_2_32_sum, HA_2_32_carry, HA_2_33_sum, HA_2_33_carry;
    wire HA_2_34_sum, HA_2_34_carry, HA_2_35_sum, HA_2_35_carry, HA_2_36_sum, HA_2_36_carry;
    wire HA_2_37_sum, HA_2_37_carry, HA_2_38_sum, HA_2_38_carry;
    
    // Full Adder wires for stage 2
    wire FA_2_1_sum, FA_2_1_carry, FA_2_2_sum, FA_2_2_carry, FA_2_3_sum, FA_2_3_carry;
    wire FA_2_4_sum, FA_2_4_carry, FA_2_5_sum, FA_2_5_carry, FA_2_6_sum, FA_2_6_carry;
    wire FA_2_7_sum, FA_2_7_carry, FA_2_8_sum, FA_2_8_carry, FA_2_9_sum, FA_2_9_carry;
    wire FA_2_10_sum, FA_2_10_carry, FA_2_11_sum, FA_2_11_carry, FA_2_12_sum, FA_2_12_carry;
    wire FA_2_13_sum, FA_2_13_carry, FA_2_14_sum, FA_2_14_carry, FA_2_15_sum, FA_2_15_carry;
    wire FA_2_16_sum, FA_2_16_carry, FA_2_17_sum, FA_2_17_carry, FA_2_18_sum, FA_2_18_carry;
    wire FA_2_19_sum, FA_2_19_carry, FA_2_20_sum, FA_2_20_carry, FA_2_21_sum, FA_2_21_carry;
    wire FA_2_22_sum, FA_2_22_carry, FA_2_23_sum, FA_2_23_carry, FA_2_24_sum, FA_2_24_carry;
    wire FA_2_25_sum, FA_2_25_carry, FA_2_26_sum, FA_2_26_carry, FA_2_27_sum, FA_2_27_carry;
    wire FA_2_28_sum, FA_2_28_carry, FA_2_29_sum, FA_2_29_carry, FA_2_30_sum, FA_2_30_carry;
    wire FA_2_31_sum, FA_2_31_carry, FA_2_32_sum, FA_2_32_carry, FA_2_33_sum, FA_2_33_carry;
    wire FA_2_34_sum, FA_2_34_carry, FA_2_35_sum, FA_2_35_carry, FA_2_36_sum, FA_2_36_carry;
    wire FA_2_37_sum, FA_2_37_carry, FA_2_38_sum, FA_2_38_carry, FA_2_39_sum, FA_2_39_carry;
    wire FA_2_40_sum, FA_2_40_carry, FA_2_41_sum, FA_2_41_carry, FA_2_42_sum, FA_2_42_carry;
    wire FA_2_43_sum, FA_2_43_carry, FA_2_44_sum, FA_2_44_carry, FA_2_45_sum, FA_2_45_carry;
    wire FA_2_46_sum, FA_2_46_carry, FA_2_47_sum, FA_2_47_carry, FA_2_48_sum, FA_2_48_carry;
    wire FA_2_49_sum, FA_2_49_carry, FA_2_50_sum, FA_2_50_carry, FA_2_51_sum, FA_2_51_carry;
    wire FA_2_52_sum, FA_2_52_carry, FA_2_53_sum, FA_2_53_carry, FA_2_54_sum, FA_2_54_carry;
    wire FA_2_55_sum, FA_2_55_carry, FA_2_56_sum, FA_2_56_carry, FA_2_57_sum, FA_2_57_carry;
    wire FA_2_58_sum, FA_2_58_carry, FA_2_59_sum, FA_2_59_carry, FA_2_60_sum, FA_2_60_carry;
    wire FA_2_61_sum, FA_2_61_carry, FA_2_62_sum, FA_2_62_carry, FA_2_63_sum, FA_2_63_carry;
    wire FA_2_64_sum, FA_2_64_carry, FA_2_65_sum, FA_2_65_carry, FA_2_66_sum, FA_2_66_carry;
    wire FA_2_67_sum, FA_2_67_carry, FA_2_68_sum, FA_2_68_carry, FA_2_69_sum, FA_2_69_carry;
    wire FA_2_70_sum, FA_2_70_carry, FA_2_71_sum, FA_2_71_carry, FA_2_72_sum, FA_2_72_carry;
    wire FA_2_73_sum, FA_2_73_carry, FA_2_74_sum, FA_2_74_carry, FA_2_75_sum, FA_2_75_carry;
    wire FA_2_76_sum, FA_2_76_carry, FA_2_77_sum, FA_2_77_carry, FA_2_78_sum, FA_2_78_carry;
    wire FA_2_79_sum, FA_2_79_carry, FA_2_80_sum, FA_2_80_carry, FA_2_81_sum, FA_2_81_carry;
    wire FA_2_82_sum, FA_2_82_carry, FA_2_83_sum, FA_2_83_carry, FA_2_84_sum, FA_2_84_carry;
    wire FA_2_85_sum, FA_2_85_carry, FA_2_86_sum, FA_2_86_carry, FA_2_87_sum, FA_2_87_carry;
    wire FA_2_88_sum, FA_2_88_carry, FA_2_89_sum, FA_2_89_carry, FA_2_90_sum, FA_2_90_carry;
    wire FA_2_91_sum, FA_2_91_carry, FA_2_92_sum, FA_2_92_carry, FA_2_93_sum, FA_2_93_carry;
    wire FA_2_94_sum, FA_2_94_carry, FA_2_95_sum, FA_2_95_carry, FA_2_96_sum, FA_2_96_carry;
    
    // Stage 3 wires
    wire HA_3_1_sum, HA_3_1_carry, HA_3_2_sum, HA_3_2_carry, HA_3_3_sum, HA_3_3_carry;
    wire HA_3_4_sum, HA_3_4_carry, HA_3_5_sum, HA_3_5_carry, HA_3_6_sum, HA_3_6_carry;
    
    wire FA_3_1_sum, FA_3_1_carry, FA_3_2_sum, FA_3_2_carry, FA_3_3_sum, FA_3_3_carry;
    wire FA_3_4_sum, FA_3_4_carry, FA_3_5_sum, FA_3_5_carry, FA_3_6_sum, FA_3_6_carry;
    wire FA_3_7_sum, FA_3_7_carry, FA_3_8_sum, FA_3_8_carry, FA_3_9_sum, FA_3_9_carry;
    wire FA_3_10_sum, FA_3_10_carry, FA_3_11_sum, FA_3_11_carry, FA_3_12_sum, FA_3_12_carry;
    wire FA_3_13_sum, FA_3_13_carry, FA_3_14_sum, FA_3_14_carry, FA_3_15_sum, FA_3_15_carry;
    wire FA_3_16_sum, FA_3_16_carry, FA_3_17_sum, FA_3_17_carry, FA_3_18_sum, FA_3_18_carry;
    wire FA_3_19_sum, FA_3_19_carry, FA_3_20_sum, FA_3_20_carry, FA_3_21_sum, FA_3_21_carry;
    wire FA_3_22_sum, FA_3_22_carry, FA_3_23_sum, FA_3_23_carry, FA_3_24_sum, FA_3_24_carry;
    wire FA_3_25_sum, FA_3_25_carry, FA_3_26_sum, FA_3_26_carry, FA_3_27_sum, FA_3_27_carry;
    wire FA_3_28_sum, FA_3_28_carry, FA_3_29_sum, FA_3_29_carry, FA_3_30_sum, FA_3_30_carry;
    wire FA_3_31_sum, FA_3_31_carry, FA_3_32_sum, FA_3_32_carry, FA_3_33_sum, FA_3_33_carry;
    wire FA_3_34_sum, FA_3_34_carry, FA_3_35_sum, FA_3_35_carry, FA_3_36_sum, FA_3_36_carry;
    wire FA_3_37_sum, FA_3_37_carry, FA_3_38_sum, FA_3_38_carry, FA_3_39_sum, FA_3_39_carry;
    wire FA_3_40_sum, FA_3_40_carry, FA_3_41_sum, FA_3_41_carry, FA_3_42_sum, FA_3_42_carry;
    wire FA_3_43_sum, FA_3_43_carry, FA_3_44_sum, FA_3_44_carry, FA_3_45_sum, FA_3_45_carry;
    wire FA_3_46_sum, FA_3_46_carry, FA_3_47_sum, FA_3_47_carry, FA_3_48_sum, FA_3_48_carry;
    wire FA_3_49_sum, FA_3_49_carry, FA_3_50_sum, FA_3_50_carry, FA_3_51_sum, FA_3_51_carry;
    wire FA_3_52_sum, FA_3_52_carry, FA_3_53_sum, FA_3_53_carry, FA_3_54_sum, FA_3_54_carry;
    wire FA_3_55_sum, FA_3_55_carry, FA_3_56_sum, FA_3_56_carry, FA_3_57_sum, FA_3_57_carry;
    wire FA_3_58_sum, FA_3_58_carry, FA_3_59_sum, FA_3_59_carry, FA_3_60_sum, FA_3_60_carry;
    wire FA_3_61_sum, FA_3_61_carry, FA_3_62_sum, FA_3_62_carry, FA_3_63_sum, FA_3_63_carry;
    wire FA_3_64_sum, FA_3_64_carry, FA_3_65_sum, FA_3_65_carry, FA_3_66_sum, FA_3_66_carry;
    wire FA_3_67_sum, FA_3_67_carry, FA_3_68_sum, FA_3_68_carry, FA_3_69_sum, FA_3_69_carry;
    wire FA_3_70_sum, FA_3_70_carry, FA_3_71_sum, FA_3_71_carry, FA_3_72_sum, FA_3_72_carry;
    wire FA_3_73_sum, FA_3_73_carry, FA_3_74_sum, FA_3_74_carry, FA_3_75_sum, FA_3_75_carry;
    wire FA_3_76_sum, FA_3_76_carry, FA_3_77_sum, FA_3_77_carry, FA_3_78_sum, FA_3_78_carry;
    wire FA_3_79_sum, FA_3_79_carry, FA_3_80_sum, FA_3_80_carry, FA_3_81_sum, FA_3_81_carry;
    wire FA_3_82_sum, FA_3_82_carry;
  
        // Full Adder wires for level 4
    wire FA_4_1_sum, FA_4_1_carry, FA_4_2_sum, FA_4_2_carry, FA_4_3_sum, FA_4_3_carry;
    wire FA_4_4_sum, FA_4_4_carry, FA_4_5_sum, FA_4_5_carry, FA_4_6_sum, FA_4_6_carry;
    wire FA_4_7_sum, FA_4_7_carry, FA_4_8_sum, FA_4_8_carry, FA_4_9_sum, FA_4_9_carry;
    wire FA_4_10_sum, FA_4_10_carry, FA_4_11_sum, FA_4_11_carry, FA_4_12_sum, FA_4_12_carry;
    wire FA_4_13_sum, FA_4_13_carry, FA_4_14_sum, FA_4_14_carry, FA_4_15_sum, FA_4_15_carry;
    wire FA_4_16_sum, FA_4_16_carry, FA_4_17_sum, FA_4_17_carry, FA_4_18_sum, FA_4_18_carry;
    wire FA_4_19_sum, FA_4_19_carry, FA_4_20_sum, FA_4_20_carry, FA_4_21_sum, FA_4_21_carry;
    wire FA_4_22_sum, FA_4_22_carry, FA_4_23_sum, FA_4_23_carry, FA_4_24_sum, FA_4_24_carry;
    wire FA_4_25_sum, FA_4_25_carry, FA_4_26_sum, FA_4_26_carry, FA_4_27_sum, FA_4_27_carry;
    wire FA_4_28_sum, FA_4_28_carry, FA_4_29_sum, FA_4_29_carry, FA_4_30_sum, FA_4_30_carry;
    wire FA_4_31_sum, FA_4_31_carry, FA_4_32_sum, FA_4_32_carry, FA_4_33_sum, FA_4_33_carry;
    wire FA_4_34_sum, FA_4_34_carry, FA_4_35_sum, FA_4_35_carry, FA_4_36_sum, FA_4_36_carry;
    wire FA_4_37_sum, FA_4_37_carry, FA_4_38_sum, FA_4_38_carry, FA_4_39_sum, FA_4_39_carry;
    wire FA_4_40_sum, FA_4_40_carry, FA_4_41_sum, FA_4_41_carry, FA_4_42_sum, FA_4_42_carry;
    wire FA_4_43_sum, FA_4_43_carry, FA_4_44_sum, FA_4_44_carry, HA_4_1_sum, HA_4_1_carry;
    
    // Full Adder wires for level 5
    wire FA_5_1_sum, FA_5_1_carry, FA_5_2_sum, FA_5_2_carry, FA_5_3_sum, FA_5_3_carry;
    wire FA_5_4_sum, FA_5_4_carry, FA_5_5_sum, FA_5_5_carry, FA_5_6_sum, FA_5_6_carry;
    wire FA_5_7_sum, FA_5_7_carry, FA_5_8_sum, FA_5_8_carry, FA_5_9_sum, FA_5_9_carry;
    wire FA_5_10_sum, FA_5_10_carry, FA_5_11_sum, FA_5_11_carry, FA_5_12_sum, FA_5_12_carry;
    wire FA_5_13_sum, FA_5_13_carry, FA_5_14_sum, FA_5_14_carry, FA_5_15_sum, FA_5_15_carry;
    wire FA_5_16_sum, FA_5_16_carry, FA_5_17_sum, FA_5_17_carry, FA_5_18_sum, FA_5_18_carry;
    wire FA_5_19_sum, FA_5_19_carry, FA_5_20_sum, FA_5_20_carry, FA_5_21_sum, FA_5_21_carry;
    wire FA_5_22_sum, FA_5_22_carry, FA_5_23_sum, FA_5_23_carry, FA_5_24_sum, FA_5_24_carry;
    wire FA_5_25_sum, FA_5_25_carry, FA_5_26_sum, FA_5_26_carry, FA_5_27_sum, FA_5_27_carry;
    wire FA_5_28_sum, FA_5_28_carry, FA_5_29_sum, FA_5_29_carry, FA_5_30_sum, FA_5_30_carry;
    wire FA_5_31_sum, FA_5_31_carry, FA_5_32_sum, FA_5_32_carry, FA_5_33_sum, FA_5_33_carry;
    wire FA_5_34_sum, FA_5_34_carry, FA_5_35_sum, FA_5_35_carry, HA_5_1_sum, HA_5_1_carry;

    //Step-1
    HalfAdder HA1 (P1[6], P2[3], HA1_sum, HA1_carry);
    FullAdder FA1 (P1[7], P2[4], P3[1], FA1_sum, FA1_carry);
    FullAdder FA2 (P1[8], P2[5], P3[2], FA2_sum, FA2_carry);
    FullAdder FA3 (P1[9], P2[6], P3[3], FA3_sum,FA3_carry);
    FullAdder FA4 (P1[10], P2[7], P3[4], FA4_sum, FA4_carry);
    FullAdder FA5 (P1[11], P2[8], P3[5], FA5_sum, FA5_carry);
    
    FullAdder FA6 (P1[12], P2[9], P3[6], FA6_sum, FA6_carry);
    HalfAdder HA2 (P4[3], P5[0], HA2_sum,HA2_carry);
    
    FullAdder FA7 (P1[13], P2[10], P3[7], FA7_sum,FA7_carry);
    HalfAdder HA3 (P4[4], P5[1], HA3_sum,HA3_carry);
    
    FullAdder FA8 (P1[14], P2[11], P3[8], FA8_sum, FA8_carry);
    HalfAdder HA4 (P4[5], P5[2], HA4_sum,HA4_carry);

    FullAdder FA9 (P1[15], P2[12], P3[9], FA9_sum, FA9_carry);
    FullAdder FA10 (P4[6], P5[3], P6[0], FA10_sum, FA10_carry);
    FullAdder FA11 (P1[16], P2[13], P3[10], FA11_sum, FA11_carry);
    FullAdder FA12 (P4[7], P5[4], P6[1], FA12_sum, FA12_carry);


    FullAdder FA13 (P1[17], P2[14], P3[11], FA13_sum, FA13_carry);
    FullAdder FA14 (P4[8],  P5[5],  P6[2],  FA14_sum, FA14_carry);
    FullAdder FA15 (P1[18], P2[15], P3[12], FA15_sum, FA15_carry);
    FullAdder FA16 (P4[9],  P5[6],  P6[3],  FA16_sum, FA16_carry);
    FullAdder FA17 (P1[19], P2[16], P3[13], FA17_sum, FA17_carry);
    FullAdder FA18 (P4[10], P5[7],  P6[4],  FA18_sum, FA18_carry);
    FullAdder FA19 (P1[20], P2[17], P3[14], FA19_sum, FA19_carry);
    FullAdder FA20 (P4[11], P5[8],  P6[5],  FA20_sum, FA20_carry);
    
    
    FullAdder FA21 (P1[21], P2[18], P3[15], FA21_sum, FA21_carry);
    FullAdder FA22 (P4[12], P5[9],  P6[6],  FA22_sum, FA22_carry);
    HalfAdder HA5 (P7[3], P8[0], HA5_sum,HA5_carry);
       
    
    FullAdder FA23 (P1[22], P2[19], P3[16], FA23_sum, FA23_carry);
    FullAdder FA24 (P4[13], P5[10], P6[7],  FA24_sum, FA24_carry);
    HalfAdder HA6 (P7[4], P8[1], HA6_sum,HA6_carry);
    
    
    FullAdder FA25 (P1[23], P2[20], P3[17], FA25_sum, FA25_carry);
    FullAdder FA26 (P4[14], P5[11], P6[8],  FA26_sum, FA26_carry);
    HalfAdder HA7 (P7[5], P8[2], HA7_sum,HA7_carry);


    FullAdder FA27 (P1[24], P2[21], P3[18], FA27_sum, FA27_carry);
    FullAdder FA28 (P4[15], P5[12], P6[9],  FA28_sum, FA28_carry);
    FullAdder FA29 (P7[6], P8[3], P9[0], FA29_sum, FA29_carry);
    
    FullAdder FA30 (P1[25], P2[22], P3[19], FA30_sum, FA30_carry);
    FullAdder FA31 (P4[16], P5[13], P6[10], FA31_sum, FA31_carry);
    FullAdder FA32 (P7[7], P8[4], P9[1], FA32_sum, FA32_carry);

    
    FullAdder FA33 (P1[26], P2[23], P3[20], FA33_sum, FA33_carry);
    FullAdder FA34 (P4[17], P5[14], P6[11], FA34_sum, FA34_carry);
    FullAdder FA35 (P7[8], P8[5], P9[2], FA35_sum, FA35_carry);

    
    FullAdder FA36 (P1[27], P2[24], P3[21], FA36_sum, FA36_carry);
    FullAdder FA37 (P4[18], P5[15], P6[12], FA37_sum, FA37_carry);
    FullAdder FA38 (P7[9], P8[6], P9[3], FA38_sum, FA38_carry);

    
    FullAdder FA39 (P1[28], P2[25], P3[22], FA39_sum, FA39_carry);
    FullAdder FA40 (P4[19], P5[16], P6[13], FA40_sum, FA40_carry);
    FullAdder FA41 (P7[10], P8[7], P9[4], FA41_sum, FA41_carry);

 
    FullAdder FA42 (P1[29], P2[26], P3[23], FA42_sum, FA42_carry);
    FullAdder FA43 (P4[20], P5[17], P6[14], FA43_sum, FA43_carry);
    FullAdder FA44 (P7[11], P8[8], P9[5], FA44_sum, FA44_carry);

    
    FullAdder FA45 (P1[30], P2[27], P3[24], FA45_sum, FA45_carry);
    FullAdder FA46 (P4[21], P5[18], P6[15], FA46_sum, FA46_carry);
    FullAdder FA47 (P7[12], P8[9], P9[6], FA47_sum, FA47_carry);
    HalfAdder HA8 (P10[3], P11[0], HA8_sum,HA8_carry);

    
    FullAdder FA48 (P1[31], P2[28], P3[25], FA48_sum, FA48_carry);
    FullAdder FA49 (P4[22], P5[19], P6[16], FA49_sum, FA49_carry);
    FullAdder FA50 (P7[13], P8[10], P9[7], FA50_sum, FA50_carry);
    HalfAdder HA9 (P10[4], P11[1], HA9_sum,HA9_carry);
    
    FullAdder FA51 (P1[32], P2[29], P3[26], FA51_sum, FA51_carry);
    FullAdder FA52 (P4[23], P5[20], P6[17], FA52_sum, FA52_carry);
    FullAdder FA53 (P7[14], P8[11], P9[8], FA53_sum, FA53_carry);
    HalfAdder HA10 (P10[5], P11[2], HA10_sum, HA10_carry);

    FullAdder FA54 (P1[33], P2[30], P3[27], FA54_sum, FA54_carry);
    FullAdder FA55 (P4[24], P5[21], P6[18], FA55_sum, FA55_carry);
    FullAdder FA56 (P7[15], P8[12], P9[9], FA56_sum, FA56_carry);
    HalfAdder HA11 (P10[6], P11[3], HA11_sum, HA11_carry);

    FullAdder FA57 (P1[34], P2[31], P3[28], FA57_sum, FA57_carry);
    FullAdder FA58 (P4[25], P5[22], P6[19], FA58_sum, FA58_carry);
    FullAdder FA59 (P7[16], P8[13], P9[10], FA59_sum, FA59_carry);
    HalfAdder HA12 (P10[7], P11[4], HA12_sum, HA12_carry);

    FullAdder FA60 (P1[35], P2[32], P3[29], FA60_sum, FA60_carry);
    FullAdder FA61 (P4[26], P5[23], P6[20], FA61_sum, FA61_carry);
    FullAdder FA62 (P7[17], P8[14], P9[11], FA62_sum, FA62_carry);
    HalfAdder HA13 (P10[8], P11[5], HA13_sum, HA13_carry);

    FullAdder FA63 (P1[36], P2[33], P3[30], FA63_sum, FA63_carry);
    FullAdder FA64 (P4[27], P5[24], P6[21], FA64_sum, FA64_carry);
    FullAdder FA65 (P7[18], P8[15], P9[12], FA65_sum, FA65_carry);
    HalfAdder HA14 (P10[9], P11[6], HA14_sum, HA14_carry);

    FullAdder FA66 (P1[37], P2[34], P3[31], FA66_sum, FA66_carry);
    FullAdder FA67 (P4[28], P5[25], P6[22], FA67_sum, FA67_carry);
    FullAdder FA68 (P7[19], P8[16], P9[13], FA68_sum, FA68_carry);
    HalfAdder HA15 (P10[10], P11[7], HA15_sum, HA15_carry);

    FullAdder FA69 (P1[38], P2[35], P3[32], FA69_sum, FA69_carry);
    FullAdder FA70 (P4[29], P5[26], P6[23], FA70_sum, FA70_carry);
    FullAdder FA71 (P7[20], P8[17], P9[14], FA71_sum, FA71_carry);
    HalfAdder HA16 (P10[11], P11[8], HA16_sum, HA16_carry);

    FullAdder FA72 (P1[39], P2[36], P3[33], FA72_sum, FA72_carry);
    FullAdder FA73 (P4[30], P5[27], P6[24], FA73_sum, FA73_carry);
    FullAdder FA74 (P7[21], P8[18], P9[15], FA74_sum, FA74_carry);
    HalfAdder HA17 (P10[12], P11[9], HA17_sum, HA17_carry);

    FullAdder FA75 (P1[40], P2[37], P3[34], FA75_sum, FA75_carry);
    FullAdder FA76 (P4[31], P5[28], P6[25], FA76_sum, FA76_carry);
    FullAdder FA77 (P7[22], P8[19], P9[16], FA77_sum, FA77_carry);
    HalfAdder HA18 (P10[13], P11[10], HA18_sum, HA18_carry);

    FullAdder FA78 (P1[41], P2[38], P3[35], FA78_sum, FA78_carry);
    FullAdder FA79 (P4[32], P5[29], P6[26], FA79_sum, FA79_carry);
    FullAdder FA80 (P7[23], P8[20], P9[17], FA80_sum, FA80_carry);
    HalfAdder HA19 (P10[14], P11[11], HA19_sum, HA19_carry);

    FullAdder FA81 (P1[42], P2[39], P3[36], FA81_sum, FA81_carry);
    FullAdder FA82 (P4[33], P5[30], P6[27], FA82_sum, FA82_carry);
    FullAdder FA83 (P7[24], P8[21], P9[18], FA83_sum, FA83_carry);
    HalfAdder HA20 (P10[15], P11[12], HA20_sum, HA20_carry);


    FullAdder FA84 (P1[43], P2[40], P3[37], FA84_sum, FA84_carry);
    FullAdder FA85 (P4[34], P5[31], P6[28], FA85_sum, FA85_carry);
    FullAdder FA86 (P7[25], P8[22], P9[19], FA86_sum, FA86_carry);
    HalfAdder HA21 (P10[16], P11[13], HA21_sum, HA21_carry);

    FullAdder FA87 (P1[44], P2[41], P3[38], FA87_sum, FA87_carry);
    FullAdder FA88 (P4[35], P5[32], P6[29], FA88_sum, FA88_carry);
    FullAdder FA89 (P7[26], P8[23], P9[20], FA89_sum, FA89_carry);
    HalfAdder HA22 (P10[17], P11[14], HA22_sum, HA22_carry);

    FullAdder FA90 (P1[45], P2[42], P3[39], FA90_sum, FA90_carry);
    FullAdder FA91 (P4[36], P5[33], P6[30], FA91_sum, FA91_carry);
    FullAdder FA92 (P7[27], P8[24], P9[21], FA92_sum, FA92_carry);
    HalfAdder HA23 (P10[18], P11[15], HA23_sum, HA23_carry);

    FullAdder FA93 (P1[46], P2[43], P3[40], FA93_sum, FA93_carry);
    FullAdder FA94 (P4[37], P5[34], P6[31], FA94_sum, FA94_carry);
    FullAdder FA95 (P7[28], P8[25], P9[22], FA95_sum, FA95_carry);
    HalfAdder HA24 (P10[19], P11[16], HA24_sum, HA24_carry);

    FullAdder FA96 (P1[47], P2[44], P3[41], FA96_sum, FA96_carry);
    FullAdder FA97 (P4[38], P5[35], P6[32], FA97_sum, FA97_carry);
    FullAdder FA98 (P7[29], P8[26], P9[23], FA98_sum, FA98_carry);
    HalfAdder HA25 (P10[20], P11[17], HA25_sum, HA25_carry);

    FullAdder FA99 (P1[48], P2[45], P3[42], FA99_sum, FA99_carry);
    FullAdder FA100 (P4[39], P5[36], P6[33], FA100_sum, FA100_carry);
    FullAdder FA101 (P7[30], P8[27], P9[24], FA101_sum, FA101_carry);
    HalfAdder HA26 (P10[21], P11[18], HA26_sum, HA26_carry);

    FullAdder FA102 (P1[49], P2[46], P3[43], FA102_sum, FA102_carry);
    FullAdder FA103 (P4[40], P5[37], P6[34], FA103_sum, FA103_carry);
    FullAdder FA104 (P7[31], P8[28], P9[25], FA104_sum, FA104_carry);
    HalfAdder HA27 (P10[22], P11[19], HA27_sum, HA27_carry);

    FullAdder FA105 (P1[50], P2[47], P3[44], FA105_sum, FA105_carry);
    FullAdder FA106 (P4[41], P5[38], P6[35], FA106_sum, FA106_carry);
    FullAdder FA107 (P7[32], P8[29], P9[26], FA107_sum, FA107_carry);
    HalfAdder HA28 (P10[23], P11[20], HA28_sum, HA28_carry);

    FullAdder FA108 (P1[51], P2[48], P3[45], FA108_sum, FA108_carry);
    FullAdder FA109 (P4[42], P5[39], P6[36], FA109_sum, FA109_carry);
    FullAdder FA110 (P7[33], P8[30], P9[27], FA110_sum, FA110_carry);
    HalfAdder HA29 (P10[24], P11[21], HA29_sum, HA29_carry);

    FullAdder FA111 (P1[52], P2[49], P3[46], FA111_sum, FA111_carry);
    FullAdder FA112 (P4[43], P5[40], P6[37], FA112_sum, FA112_carry);
    FullAdder FA113 (P7[34], P8[31], P9[28], FA113_sum, FA113_carry);
    HalfAdder HA30 (P10[25], P11[22], HA30_sum, HA30_carry);

    FullAdder FA114 (P1[53], P2[50], P3[47], FA114_sum, FA114_carry);
    FullAdder FA115 (P4[44], P5[41], P6[38], FA115_sum, FA115_carry);
    FullAdder FA116 (P7[35], P8[32], P9[29], FA116_sum, FA116_carry);
    HalfAdder HA31 (P10[26], P11[23], HA31_sum, HA31_carry);

    FullAdder FA117 (P1[54], P2[51], P3[48], FA117_sum, FA117_carry);
    FullAdder FA118 (P4[45], P5[42], P6[39], FA118_sum, FA118_carry);
    FullAdder FA119 (P7[36], P8[33], P9[30], FA119_sum, FA119_carry);
    HalfAdder HA32 (P10[27], P11[24], HA32_sum, HA32_carry);

    FullAdder FA120 (P1[55], P2[52], P3[49], FA120_sum, FA120_carry);
    FullAdder FA121 (P4[46], P5[43], P6[40], FA121_sum, FA121_carry);
    FullAdder FA122 (P7[37], P8[34], P9[31], FA122_sum, FA122_carry);
    HalfAdder HA33 (P10[28], P11[25], HA33_sum, HA33_carry);

    FullAdder FA123 (P1[56], P2[53], P3[50], FA123_sum, FA123_carry);
    FullAdder FA124 (P4[47], P5[44], P6[41], FA124_sum, FA124_carry);
    FullAdder FA125 (P7[38], P8[35], P9[32], FA125_sum, FA125_carry);
    HalfAdder HA34 (P10[29], P11[26], HA34_sum, HA34_carry);

    FullAdder FA126 (P1[57], P2[54], P3[51], FA126_sum, FA126_carry);
    FullAdder FA127 (P4[48], P5[45], P6[42], FA127_sum, FA127_carry);
    FullAdder FA128 (P7[39], P8[36], P9[33], FA128_sum, FA128_carry);
    HalfAdder HA35 (P10[30], P11[27], HA35_sum, HA35_carry);

    FullAdder FA129 (P1[58], P2[55], P3[52], FA129_sum, FA129_carry);
    FullAdder FA130 (P4[49], P5[46], P6[43], FA130_sum, FA130_carry);
    FullAdder FA131 (P7[40], P8[37], P9[34], FA131_sum, FA131_carry);
    HalfAdder HA36 (P10[31], P11[28], HA36_sum, HA36_carry);

    FullAdder FA132 (P1[59], P2[56], P3[53], FA132_sum, FA132_carry);
    FullAdder FA133 (P4[50], P5[47], P6[44], FA133_sum, FA133_carry);
    FullAdder FA134 (P7[41], P8[38], P9[35], FA134_sum, FA134_carry);
    HalfAdder HA37 (P10[32], P11[29], HA37_sum, HA37_carry);

    FullAdder FA135 (P1[60], P2[57], P3[54], FA135_sum, FA135_carry);
    FullAdder FA136 (P4[51], P5[48], P6[45], FA136_sum, FA136_carry);
    FullAdder FA137 (P7[42], P8[39], P9[36], FA137_sum, FA137_carry);
    HalfAdder HA38 (P10[33], P11[30], HA38_sum, HA38_carry);

    FullAdder FA138 (P1[61], P2[58], P3[55], FA138_sum, FA138_carry);
    FullAdder FA139 (P4[52], P5[49], P6[46], FA139_sum, FA139_carry);
    FullAdder FA140 (P7[43], P8[40], P9[37], FA140_sum, FA140_carry);
    HalfAdder HA39 (P10[34], P11[31], HA39_sum, HA39_carry);

    FullAdder FA141 (P1[62], P2[59], P3[56], FA141_sum, FA141_carry);
    FullAdder FA142 (P4[53], P5[50], P6[47], FA142_sum, FA142_carry);
    FullAdder FA143 (P7[44], P8[41], P9[38], FA143_sum, FA143_carry);
    HalfAdder HA40 (P10[35], P11[32], HA40_sum, HA40_carry);
    
    FullAdder FA144 (P1[63], P2[60], P3[57], FA144_sum, FA144_carry);
    FullAdder FA145 (P4[54], P5[51], P6[48], FA145_sum, FA145_carry);
    FullAdder FA146 (P7[45], P8[42], P9[39], FA146_sum, FA146_carry);
    HalfAdder HA41 (P10[36], P11[33], HA41_sum, HA41_carry);




// stage- 2 

    HalfAdder HA_2_1 (FA3_sum, FA2_carry, HA_2_1_sum, HA_2_1_carry);
    FullAdder FA_2_1 (FA4_sum, FA3_carry , P4[1], FA_2_1_sum, FA_2_1_carry);
    FullAdder FA_2_2 (FA5_sum, FA4_carry , P4[2], FA_2_2_sum, FA_2_2_carry);
    FullAdder FA_2_3 (FA6_sum, FA5_carry , HA2_sum, FA_2_3_sum, FA_2_3_carry);
    FullAdder FA_2_4 (FA7_sum, FA6_carry , HA3_sum, FA_2_4_sum, FA_2_4_carry);
    FullAdder FA_2_5 (FA8_sum, FA7_carry , HA4_sum, FA_2_5_sum, FA_2_5_carry);
    FullAdder FA_2_6 (FA9_sum, FA10_sum , FA8_carry, FA_2_6_sum, FA_2_6_carry);
    FullAdder FA_2_7 (FA11_sum, FA12_sum , FA9_carry, FA_2_7_sum, FA_2_7_carry);
    FullAdder FA_2_8 (FA13_sum, FA14_sum , FA11_carry, FA_2_8_sum, FA_2_8_carry);

    FullAdder FA_2_9 (FA15_sum, FA16_sum , FA13_carry, FA_2_9_sum, FA_2_9_carry);
    HalfAdder HA_2_2 (FA14_carry, P7[0], HA_2_2_sum, HA_2_2_carry);
    
    FullAdder FA_2_10 (FA17_sum, FA18_sum , FA15_carry, FA_2_10_sum, FA_2_10_carry);
    HalfAdder HA_2_3 (FA16_carry, P7[1], HA_2_3_sum, HA_2_3_carry);

    FullAdder FA_2_11 (FA19_sum, FA20_sum , FA17_carry, FA_2_11_sum, FA_2_11_carry);
    HalfAdder HA_2_4 (FA18_carry, P7[2], HA_2_4_sum, HA_2_4_carry);

    FullAdder FA_2_12 (FA21_sum, FA22_sum , FA19_carry, FA_2_12_sum, FA_2_12_carry);
    HalfAdder HA_2_5 (HA5_sum, FA20_carry, HA_2_5_sum, HA_2_5_carry);

    FullAdder FA_2_13 (FA23_sum, FA24_sum , FA21_carry, FA_2_13_sum, FA_2_13_carry);
    FullAdder FA_2_14 (HA6_sum, FA22_carry , HA5_carry, FA_2_14_sum, FA_2_14_carry);
    
    FullAdder FA_2_15 (FA25_sum, FA26_sum , FA23_carry, FA_2_15_sum, FA_2_15_carry);
    FullAdder FA_2_16 (HA7_sum, FA24_carry , HA6_carry, FA_2_16_sum, FA_2_16_carry);

    FullAdder FA_2_17 (FA27_sum, FA28_sum , FA25_carry, FA_2_17_sum, FA_2_17_carry);
    FullAdder FA_2_18 (FA29_sum, FA26_carry , HA7_carry, FA_2_18_sum, FA_2_18_carry);

    FullAdder FA_2_19 (FA30_sum, FA31_sum , FA32_sum, FA_2_19_sum, FA_2_19_carry);
    FullAdder FA_2_20 (FA27_carry, FA28_carry , FA29_carry, FA_2_20_sum, FA_2_20_carry);

    FullAdder FA_2_21 (FA33_sum, FA34_sum , FA35_sum, FA_2_21_sum, FA_2_21_carry);
    FullAdder FA_2_22 (FA30_carry, FA31_carry , FA32_carry, FA_2_22_sum, FA_2_22_carry);
    
    FullAdder FA_2_23 (FA36_sum, FA37_sum , FA38_sum, FA_2_23_sum, FA_2_23_carry);
    FullAdder FA_2_24 (FA33_carry, FA34_carry , FA35_carry, FA_2_24_sum, FA_2_24_carry);

    FullAdder FA_2_25 (FA39_sum, FA40_sum , FA41_sum, FA_2_25_sum, FA_2_25_carry);
    FullAdder FA_2_26 (FA36_carry, FA37_carry , FA38_carry, FA_2_26_sum, FA_2_26_carry);
    
    FullAdder FA_2_27 (FA42_sum, FA43_sum , FA44_sum, FA_2_27_sum, FA_2_27_carry);
    FullAdder FA_2_28 (FA39_carry, FA40_carry , FA41_carry, FA_2_28_sum, FA_2_28_carry);   
    
    FullAdder FA_2_29 (FA45_sum, FA46_sum , FA47_sum, FA_2_29_sum, FA_2_29_carry);
    FullAdder FA_2_30 (HA8_sum, FA42_carry , FA43_carry, FA_2_30_sum, FA_2_30_carry);
    
    
    FullAdder FA_2_31 (FA48_sum, FA49_sum , FA50_sum, FA_2_31_sum, FA_2_31_carry);
    FullAdder FA_2_32 (HA9_sum, FA45_carry , FA46_carry, FA_2_32_sum, FA_2_32_carry);
    HalfAdder HA_2_6 (FA47_carry, HA8_carry, HA_2_6_sum, HA_2_6_carry);

    FullAdder FA_2_33 (FA51_sum, FA52_sum , FA53_sum, FA_2_33_sum, FA_2_33_carry);
    FullAdder FA_2_34 (HA10_sum, FA48_carry , FA49_carry, FA_2_34_sum, FA_2_34_carry);
    HalfAdder HA_2_7 (FA50_carry, HA9_carry, HA_2_7_sum, HA_2_7_carry);  
    
    
    FullAdder FA_2_35 (FA54_sum, FA55_sum, FA56_sum, FA_2_35_sum, FA_2_35_carry);
    FullAdder FA_2_36 (HA11_sum, FA51_carry, FA52_carry, FA_2_36_sum, FA_2_36_carry);
    HalfAdder HA_2_8 (FA53_carry, HA10_carry, HA_2_8_sum, HA_2_8_carry);
    
    FullAdder FA_2_37 (FA57_sum, FA58_sum, FA59_sum, FA_2_37_sum, FA_2_37_carry);
    FullAdder FA_2_38 (HA12_sum, FA54_carry, FA55_carry, FA_2_38_sum, FA_2_38_carry);
    HalfAdder HA_2_9 (FA56_carry, HA11_carry, HA_2_9_sum, HA_2_9_carry);
    
    FullAdder FA_2_39 (FA60_sum, FA61_sum, FA62_sum, FA_2_39_sum, FA_2_39_carry);
    FullAdder FA_2_40 (HA13_sum, FA57_carry, FA58_carry, FA_2_40_sum, FA_2_40_carry);
    HalfAdder HA_2_10 (FA59_carry, HA12_carry, HA_2_10_sum, HA_2_10_carry);
    
    FullAdder FA_2_41 (FA63_sum, FA64_sum, FA65_sum, FA_2_41_sum, FA_2_41_carry);
    FullAdder FA_2_42 (HA14_sum, FA60_carry, FA61_carry, FA_2_42_sum, FA_2_42_carry);
    HalfAdder HA_2_11 (FA62_carry, HA13_carry, HA_2_11_sum, HA_2_11_carry);
    
    FullAdder FA_2_43 (FA66_sum, FA67_sum, FA68_sum, FA_2_43_sum, FA_2_43_carry);
    FullAdder FA_2_44 (HA15_sum, FA63_carry, FA64_carry, FA_2_44_sum, FA_2_44_carry);
    HalfAdder HA_2_12 (FA65_carry, HA14_carry, HA_2_12_sum, HA_2_12_carry);
    
    FullAdder FA_2_45 (FA69_sum, FA70_sum, FA71_sum, FA_2_45_sum, FA_2_45_carry);
    FullAdder FA_2_46 (HA16_sum, FA66_carry, FA67_carry, FA_2_46_sum, FA_2_46_carry);
    HalfAdder HA_2_13 (FA68_carry, HA15_carry, HA_2_13_sum, HA_2_13_carry);
    
    FullAdder FA_2_47 (FA72_sum, FA73_sum, FA74_sum, FA_2_47_sum, FA_2_47_carry);
    FullAdder FA_2_48 (HA17_sum, FA69_carry, FA70_carry, FA_2_48_sum, FA_2_48_carry);
    HalfAdder HA_2_14 (FA71_carry, HA16_carry, HA_2_14_sum, HA_2_14_carry);
    
    FullAdder FA_2_49 (FA75_sum, FA76_sum, FA77_sum, FA_2_49_sum, FA_2_49_carry);
    FullAdder FA_2_50 (HA18_sum, FA72_carry, FA73_carry, FA_2_50_sum, FA_2_50_carry);
    HalfAdder HA_2_15 (FA74_carry, HA17_carry, HA_2_15_sum, HA_2_15_carry);
    
    FullAdder FA_2_51 (FA78_sum, FA79_sum, FA80_sum, FA_2_51_sum, FA_2_51_carry);
    FullAdder FA_2_52 (HA19_sum, FA75_carry, FA76_carry, FA_2_52_sum, FA_2_52_carry);
    HalfAdder HA_2_16 (FA77_carry, HA18_carry, HA_2_16_sum, HA_2_16_carry);
    
    FullAdder FA_2_53 (FA81_sum, FA82_sum, FA83_sum, FA_2_53_sum, FA_2_53_carry);
    FullAdder FA_2_54 (HA20_sum, FA78_carry, FA79_carry, FA_2_54_sum, FA_2_54_carry);
    HalfAdder HA_2_17 (FA80_carry, HA19_carry, HA_2_17_sum, HA_2_17_carry);
    
    FullAdder FA_2_55 (FA84_sum, FA85_sum, FA86_sum, FA_2_55_sum, FA_2_55_carry);
    FullAdder FA_2_56 (HA21_sum, FA81_carry, FA82_carry, FA_2_56_sum, FA_2_56_carry);
    HalfAdder HA_2_18 (FA83_carry, HA20_carry, HA_2_18_sum, HA_2_18_carry);
    
    FullAdder FA_2_57 (FA87_sum, FA88_sum, FA89_sum, FA_2_57_sum, FA_2_57_carry);
    FullAdder FA_2_58 (HA22_sum, FA84_carry, FA85_carry, FA_2_58_sum, FA_2_58_carry);
    HalfAdder HA_2_19 (FA86_carry, HA21_carry, HA_2_19_sum, HA_2_19_carry);
    
    FullAdder FA_2_59 (FA90_sum, FA91_sum, FA92_sum, FA_2_59_sum, FA_2_59_carry);
    FullAdder FA_2_60 (HA23_sum, FA87_carry, FA88_carry, FA_2_60_sum, FA_2_60_carry);
    HalfAdder HA_2_20 (FA89_carry, HA22_carry, HA_2_20_sum, HA_2_20_carry);
    
    FullAdder FA_2_61 (FA93_sum, FA94_sum, FA95_sum, FA_2_61_sum, FA_2_61_carry);
    FullAdder FA_2_62 (HA24_sum, FA90_carry, FA91_carry, FA_2_62_sum, FA_2_62_carry);
    HalfAdder HA_2_21 (FA92_carry, HA23_carry, HA_2_21_sum, HA_2_21_carry);
    
    FullAdder FA_2_63 (FA96_sum, FA97_sum, FA98_sum, FA_2_63_sum, FA_2_63_carry);
    FullAdder FA_2_64 (HA25_sum, FA93_carry, FA94_carry, FA_2_64_sum, FA_2_64_carry);
    HalfAdder HA_2_22 (FA95_carry, HA24_carry, HA_2_22_sum, HA_2_22_carry);
    
    FullAdder FA_2_65 (FA99_sum, FA100_sum, FA101_sum, FA_2_65_sum, FA_2_65_carry);
    FullAdder FA_2_66 (HA26_sum, FA96_carry, FA97_carry, FA_2_66_sum, FA_2_66_carry);
    HalfAdder HA_2_23 (FA98_carry, HA25_carry, HA_2_23_sum, HA_2_23_carry);
    
    FullAdder FA_2_67 (FA102_sum, FA103_sum, FA104_sum, FA_2_67_sum, FA_2_67_carry);
    FullAdder FA_2_68 (HA27_sum, FA99_carry, FA100_carry, FA_2_68_sum, FA_2_68_carry);
    HalfAdder HA_2_24 (FA101_carry, HA26_carry, HA_2_24_sum, HA_2_24_carry);
    
    FullAdder FA_2_69 (FA105_sum, FA106_sum, FA107_sum, FA_2_69_sum, FA_2_69_carry);
    FullAdder FA_2_70 (HA28_sum, FA102_carry, FA103_carry, FA_2_70_sum, FA_2_70_carry);
    HalfAdder HA_2_25 (FA104_carry, HA27_carry, HA_2_25_sum, HA_2_25_carry);
    
    FullAdder FA_2_71 (FA108_sum, FA109_sum, FA110_sum, FA_2_71_sum, FA_2_71_carry);
    FullAdder FA_2_72 (HA29_sum, FA105_carry, FA106_carry, FA_2_72_sum, FA_2_72_carry);
    HalfAdder HA_2_26 (FA107_carry, HA28_carry, HA_2_26_sum, HA_2_26_carry);
    
    FullAdder FA_2_73 (FA111_sum, FA112_sum, FA113_sum, FA_2_73_sum, FA_2_73_carry);
    FullAdder FA_2_74 (HA30_sum, FA108_carry, FA109_carry, FA_2_74_sum, FA_2_74_carry);
    HalfAdder HA_2_27 (FA110_carry, HA29_carry, HA_2_27_sum, HA_2_27_carry);
    
    FullAdder FA_2_75 (FA114_sum, FA115_sum, FA116_sum, FA_2_75_sum, FA_2_75_carry);
    FullAdder FA_2_76 (HA31_sum, FA111_carry, FA112_carry, FA_2_76_sum, FA_2_76_carry);
    HalfAdder HA_2_28 (FA113_carry, HA30_carry, HA_2_28_sum, HA_2_28_carry);
    
    FullAdder FA_2_77 (FA117_sum, FA118_sum, FA119_sum, FA_2_77_sum, FA_2_77_carry);
    FullAdder FA_2_78 (HA32_sum, FA114_carry, FA115_carry, FA_2_78_sum, FA_2_78_carry);
    HalfAdder HA_2_29 (FA116_carry, HA31_carry, HA_2_29_sum, HA_2_29_carry);
    
    FullAdder FA_2_79 (FA120_sum, FA121_sum, FA122_sum, FA_2_79_sum, FA_2_79_carry);
    FullAdder FA_2_80 (HA33_sum, FA117_carry, FA118_carry, FA_2_80_sum, FA_2_80_carry);
    HalfAdder HA_2_30 (FA119_carry, HA32_carry, HA_2_30_sum, HA_2_30_carry);
    
    FullAdder FA_2_81 (FA123_sum, FA124_sum, FA125_sum, FA_2_81_sum, FA_2_81_carry);
    FullAdder FA_2_82 (HA34_sum, FA120_carry, FA121_carry, FA_2_82_sum, FA_2_82_carry);
    HalfAdder HA_2_31 (FA122_carry, HA33_carry, HA_2_31_sum, HA_2_31_carry);
    
    FullAdder FA_2_83 (FA126_sum, FA127_sum, FA128_sum, FA_2_83_sum, FA_2_83_carry);
    FullAdder FA_2_84 (HA35_sum, FA123_carry, FA124_carry, FA_2_84_sum, FA_2_84_carry);
    HalfAdder HA_2_32 (FA125_carry, HA34_carry, HA_2_32_sum, HA_2_32_carry);
    
    FullAdder FA_2_85 (FA129_sum, FA130_sum, FA131_sum, FA_2_85_sum, FA_2_85_carry);
    FullAdder FA_2_86 (HA36_sum, FA126_carry, FA127_carry, FA_2_86_sum, FA_2_86_carry);
    HalfAdder HA_2_33 (FA128_carry, HA35_carry, HA_2_33_sum, HA_2_33_carry);
    
    FullAdder FA_2_87 (FA132_sum, FA133_sum, FA134_sum, FA_2_87_sum, FA_2_87_carry);
    FullAdder FA_2_88 (HA37_sum, FA129_carry, FA130_carry, FA_2_88_sum, FA_2_88_carry);
    HalfAdder HA_2_34 (FA131_carry, HA36_carry, HA_2_34_sum, HA_2_34_carry);
    
    FullAdder FA_2_89 (FA135_sum, FA136_sum, FA137_sum, FA_2_89_sum, FA_2_89_carry);
    FullAdder FA_2_90 (HA38_sum, FA132_carry, FA133_carry, FA_2_90_sum, FA_2_90_carry);
    HalfAdder HA_2_35 (FA134_carry, HA37_carry, HA_2_35_sum, HA_2_35_carry);
    
    FullAdder FA_2_91 (FA138_sum, FA139_sum, FA140_sum, FA_2_91_sum, FA_2_91_carry);
    FullAdder FA_2_92 (HA39_sum, FA135_carry, FA136_carry, FA_2_92_sum, FA_2_92_carry);
    HalfAdder HA_2_36 (FA137_carry, HA38_carry, HA_2_36_sum, HA_2_36_carry);
    
    FullAdder FA_2_93 (FA141_sum, FA142_sum, FA143_sum, FA_2_93_sum, FA_2_93_carry);
    FullAdder FA_2_94 (HA40_sum, FA138_carry, FA139_carry, FA_2_94_sum, FA_2_94_carry);
    HalfAdder HA_2_37 (FA140_carry, HA39_carry, HA_2_37_sum, HA_2_37_carry);
    
    FullAdder FA_2_95 (FA144_sum, FA145_sum, FA146_sum, FA_2_95_sum, FA_2_95_carry);
    FullAdder FA_2_96 (HA41_sum, FA141_carry, FA142_carry, FA_2_96_sum, FA_2_96_carry);
    HalfAdder HA_2_38 (FA143_carry, HA40_carry, HA_2_38_sum, HA_2_38_carry);
       
   
   // satge 3
    
    HalfAdder HA_3_1 (FA_2_4_sum, HA2_carry, HA_3_1_sum, HA_3_1_carry);
    FullAdder FA_3_1 (FA_2_5_sum, FA_2_4_carry , HA3_carry, FA_3_1_sum, FA_3_1_carry);
    FullAdder FA_3_2  (FA_2_6_sum,  FA_2_5_carry,  HA4_carry,  FA_3_2_sum,  FA_3_2_carry);
    FullAdder FA_3_3  (FA_2_7_sum,  FA_2_6_carry,  FA10_carry,  FA_3_3_sum,  FA_3_3_carry);
    FullAdder FA_3_4  (FA_2_8_sum,  FA_2_7_carry,  FA12_carry, FA_3_4_sum,  FA_3_4_carry);
    FullAdder FA_3_5  (FA_2_9_sum,  FA_2_8_carry,  HA_2_2_sum, FA_3_5_sum,  FA_3_5_carry);
    FullAdder FA_3_6  (FA_2_10_sum, FA_2_9_carry,  HA_2_3_sum, FA_3_6_sum,  FA_3_6_carry);
    FullAdder FA_3_7  (FA_2_11_sum, FA_2_10_carry,  HA_2_4_sum, FA_3_7_sum,  FA_3_7_carry);
    FullAdder FA_3_8  (FA_2_12_sum, FA_2_11_carry,  HA_2_5_sum, FA_3_8_sum,  FA_3_8_carry);
    FullAdder FA_3_9  (FA_2_13_sum, FA_2_12_carry,  FA_2_14_sum, FA_3_9_sum,  FA_3_9_carry);
    FullAdder FA_3_10  (FA_2_15_sum, FA_2_13_carry,  FA_2_16_sum, FA_3_10_sum,  FA_3_10_carry);
    FullAdder FA_3_11  (FA_2_17_sum, FA_2_15_carry,  FA_2_18_sum, FA_3_11_sum,  FA_3_11_carry);
    FullAdder FA_3_12  (FA_2_19_sum, FA_2_17_carry,  FA_2_20_sum, FA_3_12_sum,  FA_3_12_carry);
    FullAdder FA_3_13  (FA_2_21_sum, FA_2_19_carry,  FA_2_22_sum, FA_3_13_sum,  FA_3_13_carry);

    FullAdder FA_3_14  (FA_2_23_sum, P10[0],  FA_2_24_sum, FA_3_14_sum,  FA_3_14_carry);
    HalfAdder HA_3_2 (FA_2_21_carry, FA_2_22_carry, HA_3_2_sum, HA_3_2_carry);

    FullAdder FA_3_15  (FA_2_25_sum, P10[1],  FA_2_26_sum, FA_3_15_sum,  FA_3_15_carry);
    HalfAdder HA_3_3 (FA_2_23_carry, FA_2_24_carry, HA_3_3_sum, HA_3_3_carry);

    FullAdder FA_3_16  (FA_2_27_sum, P10[2],  FA_2_28_sum, FA_3_16_sum,  FA_3_16_carry);
    HalfAdder HA_3_4 (FA_2_25_carry, FA_2_26_carry, HA_3_4_sum, HA_3_4_carry);

    FullAdder FA_3_17  (FA_2_29_sum, FA44_carry,  FA_2_30_sum, FA_3_17_sum,  FA_3_17_carry);
    HalfAdder HA_3_5 (FA_2_27_carry, FA_2_28_carry, HA_3_5_sum, HA_3_5_carry);

    FullAdder FA_3_18  (FA_2_31_sum, HA_2_6_sum,  FA_2_32_sum, FA_3_18_sum,  FA_3_18_carry);
    HalfAdder HA_3_6 (FA_2_29_carry, FA_2_30_carry, HA_3_6_sum, HA_3_6_carry);

    FullAdder FA_3_19 (FA_2_33_sum, HA_2_7_sum,  FA_2_34_sum, FA_3_19_sum,  FA_3_19_carry);
    FullAdder FA_3_20 (FA_2_31_carry, HA_2_6_carry,  FA_2_32_carry, FA_3_20_sum,  FA_3_20_carry);

    FullAdder FA_3_21 (FA_2_35_sum, HA_2_8_sum,  FA_2_36_sum, FA_3_21_sum,  FA_3_21_carry);
    FullAdder FA_3_22 (FA_2_33_carry, HA_2_7_carry,  FA_2_34_carry, FA_3_22_sum,  FA_3_22_carry);
    
    
    FullAdder FA_3_23 (FA_2_37_sum, HA_2_9_sum, FA_2_38_sum, FA_3_23_sum, FA_3_23_carry);
    FullAdder FA_3_24 (FA_2_35_carry, HA_2_8_carry, FA_2_36_carry, FA_3_24_sum, FA_3_24_carry);
    
    FullAdder FA_3_25 (FA_2_39_sum, HA_2_10_sum, FA_2_40_sum, FA_3_25_sum, FA_3_25_carry);
    FullAdder FA_3_26 (FA_2_37_carry, HA_2_9_carry, FA_2_38_carry, FA_3_26_sum, FA_3_26_carry);
    
    FullAdder FA_3_27 (FA_2_41_sum, HA_2_11_sum, FA_2_42_sum, FA_3_27_sum, FA_3_27_carry);
    FullAdder FA_3_28 (FA_2_39_carry, HA_2_10_carry, FA_2_40_carry, FA_3_28_sum, FA_3_28_carry);
    
    FullAdder FA_3_29 (FA_2_43_sum, HA_2_12_sum, FA_2_44_sum, FA_3_29_sum, FA_3_29_carry);
    FullAdder FA_3_30 (FA_2_41_carry, HA_2_11_carry, FA_2_42_carry, FA_3_30_sum, FA_3_30_carry);
    
    FullAdder FA_3_31 (FA_2_45_sum, HA_2_13_sum, FA_2_46_sum, FA_3_31_sum, FA_3_31_carry);
    FullAdder FA_3_32 (FA_2_43_carry, HA_2_12_carry, FA_2_44_carry, FA_3_32_sum, FA_3_32_carry);
    
    FullAdder FA_3_33 (FA_2_47_sum, HA_2_14_sum, FA_2_48_sum, FA_3_33_sum, FA_3_33_carry);
    FullAdder FA_3_34 (FA_2_45_carry, HA_2_13_carry, FA_2_46_carry, FA_3_34_sum, FA_3_34_carry);
    
    FullAdder FA_3_35 (FA_2_49_sum, HA_2_15_sum, FA_2_50_sum, FA_3_35_sum, FA_3_35_carry);
    FullAdder FA_3_36 (FA_2_47_carry, HA_2_14_carry, FA_2_48_carry, FA_3_36_sum, FA_3_36_carry);
    
    FullAdder FA_3_37 (FA_2_51_sum, HA_2_16_sum, FA_2_52_sum, FA_3_37_sum, FA_3_37_carry);
    FullAdder FA_3_38 (FA_2_49_carry, HA_2_15_carry, FA_2_50_carry, FA_3_38_sum, FA_3_38_carry);
    
    FullAdder FA_3_39 (FA_2_53_sum, HA_2_17_sum, FA_2_54_sum, FA_3_39_sum, FA_3_39_carry);
    FullAdder FA_3_40 (FA_2_51_carry, HA_2_16_carry, FA_2_52_carry, FA_3_40_sum, FA_3_40_carry);
    
    FullAdder FA_3_41 (FA_2_55_sum, HA_2_18_sum, FA_2_56_sum, FA_3_41_sum, FA_3_41_carry);
    FullAdder FA_3_42 (FA_2_53_carry, HA_2_17_carry, FA_2_54_carry, FA_3_42_sum, FA_3_42_carry);
    
    FullAdder FA_3_43 (FA_2_57_sum, HA_2_19_sum, FA_2_58_sum, FA_3_43_sum, FA_3_43_carry);
    FullAdder FA_3_44 (FA_2_55_carry, HA_2_18_carry, FA_2_56_carry, FA_3_44_sum, FA_3_44_carry);
    
    FullAdder FA_3_45 (FA_2_59_sum, HA_2_20_sum, FA_2_60_sum, FA_3_45_sum, FA_3_45_carry);
    FullAdder FA_3_46 (FA_2_57_carry, HA_2_19_carry, FA_2_58_carry, FA_3_46_sum, FA_3_46_carry);
    
    FullAdder FA_3_47 (FA_2_61_sum, HA_2_21_sum, FA_2_62_sum, FA_3_47_sum, FA_3_47_carry);
    FullAdder FA_3_48 (FA_2_59_carry, HA_2_20_carry, FA_2_60_carry, FA_3_48_sum, FA_3_48_carry);
    
    FullAdder FA_3_49 (FA_2_63_sum, HA_2_22_sum, FA_2_64_sum, FA_3_49_sum, FA_3_49_carry);
    FullAdder FA_3_50 (FA_2_61_carry, HA_2_21_carry, FA_2_62_carry, FA_3_50_sum, FA_3_50_carry);
    
    
    FullAdder FA_3_51 (FA_2_65_sum, HA_2_23_sum, FA_2_66_sum, FA_3_51_sum, FA_3_51_carry);
    FullAdder FA_3_52 (FA_2_63_carry, HA_2_22_carry, FA_2_64_carry, FA_3_52_sum, FA_3_52_carry);
    
    FullAdder FA_3_53 (FA_2_67_sum, HA_2_24_sum, FA_2_68_sum, FA_3_53_sum, FA_3_53_carry);
    FullAdder FA_3_54 (FA_2_65_carry, HA_2_23_carry, FA_2_66_carry, FA_3_54_sum, FA_3_54_carry);
    
    FullAdder FA_3_55 (FA_2_69_sum, HA_2_25_sum, FA_2_70_sum, FA_3_55_sum, FA_3_55_carry);
    FullAdder FA_3_56 (FA_2_67_carry, HA_2_24_carry, FA_2_68_carry, FA_3_56_sum, FA_3_56_carry);
    
    FullAdder FA_3_57 (FA_2_71_sum, HA_2_26_sum, FA_2_72_sum, FA_3_57_sum, FA_3_57_carry);
    FullAdder FA_3_58 (FA_2_69_carry, HA_2_25_carry, FA_2_70_carry, FA_3_58_sum, FA_3_58_carry);
    
    FullAdder FA_3_59 (FA_2_73_sum, HA_2_27_sum, FA_2_74_sum, FA_3_59_sum, FA_3_59_carry);
    FullAdder FA_3_60 (FA_2_71_carry, HA_2_26_carry, FA_2_72_carry, FA_3_60_sum, FA_3_60_carry);
    
    FullAdder FA_3_61 (FA_2_75_sum, HA_2_28_sum, FA_2_76_sum, FA_3_61_sum, FA_3_61_carry);
    FullAdder FA_3_62 (FA_2_73_carry, HA_2_27_carry, FA_2_74_carry, FA_3_62_sum, FA_3_62_carry);
    
    FullAdder FA_3_63 (FA_2_77_sum, HA_2_29_sum, FA_2_78_sum, FA_3_63_sum, FA_3_63_carry);
    FullAdder FA_3_64 (FA_2_75_carry, HA_2_28_carry, FA_2_76_carry, FA_3_64_sum, FA_3_64_carry);
    
    FullAdder FA_3_65 (FA_2_79_sum, HA_2_30_sum, FA_2_80_sum, FA_3_65_sum, FA_3_65_carry);
    FullAdder FA_3_66 (FA_2_77_carry, HA_2_29_carry, FA_2_78_carry, FA_3_66_sum, FA_3_66_carry);
    
    FullAdder FA_3_67 (FA_2_81_sum, HA_2_31_sum, FA_2_82_sum, FA_3_67_sum, FA_3_67_carry);
    FullAdder FA_3_68 (FA_2_79_carry, HA_2_30_carry, FA_2_80_carry, FA_3_68_sum, FA_3_68_carry);
    
    FullAdder FA_3_69 (FA_2_83_sum, HA_2_32_sum, FA_2_84_sum, FA_3_69_sum, FA_3_69_carry);
    FullAdder FA_3_70 (FA_2_81_carry, HA_2_31_carry, FA_2_82_carry, FA_3_70_sum, FA_3_70_carry);
    
    FullAdder FA_3_71 (FA_2_85_sum, HA_2_33_sum, FA_2_86_sum, FA_3_71_sum, FA_3_71_carry);
    FullAdder FA_3_72 (FA_2_83_carry, HA_2_32_carry, FA_2_84_carry, FA_3_72_sum, FA_3_72_carry);
    
    FullAdder FA_3_73 (FA_2_87_sum, HA_2_34_sum, FA_2_88_sum, FA_3_73_sum, FA_3_73_carry);
    FullAdder FA_3_74 (FA_2_85_carry, HA_2_33_carry, FA_2_86_carry, FA_3_74_sum, FA_3_74_carry);
    
    FullAdder FA_3_75 (FA_2_89_sum, HA_2_35_sum, FA_2_90_sum, FA_3_75_sum, FA_3_75_carry);
    FullAdder FA_3_76 (FA_2_87_carry, HA_2_34_carry, FA_2_88_carry, FA_3_76_sum, FA_3_76_carry);
    
    FullAdder FA_3_77 (FA_2_91_sum, HA_2_36_sum, FA_2_92_sum, FA_3_77_sum, FA_3_77_carry);
    FullAdder FA_3_78 (FA_2_89_carry, HA_2_35_carry, FA_2_90_carry, FA_3_78_sum, FA_3_78_carry);
    
    FullAdder FA_3_79 (FA_2_93_sum, HA_2_37_sum, FA_2_94_sum, FA_3_79_sum, FA_3_79_carry);
    FullAdder FA_3_80 (FA_2_91_carry, HA_2_36_carry, FA_2_92_carry, FA_3_80_sum, FA_3_80_carry);
    
    FullAdder FA_3_81 (FA_2_95_sum, HA_2_38_sum, FA_2_96_sum, FA_3_81_sum, FA_3_81_carry);
    FullAdder FA_3_82 (FA_2_93_carry, HA_2_37_carry, FA_2_94_carry, FA_3_82_sum, FA_3_82_carry);
    
    
// satge 4
    
    HalfAdder HA_4_1 (FA_3_6_sum, HA_2_2_carry, HA_4_1_sum, HA_4_1_carry);
    FullAdder FA_4_1 (FA_3_7_sum, HA_2_3_carry , FA_3_6_carry, FA_4_1_sum, FA_4_1_carry);
    FullAdder FA_4_2 (FA_3_8_sum, HA_2_4_carry , FA_3_7_carry, FA_4_2_sum, FA_4_2_carry);
    FullAdder FA_4_3 (FA_3_9_sum, HA_2_5_carry , FA_3_8_carry, FA_4_3_sum, FA_4_3_carry);
    FullAdder FA_4_4 (FA_3_10_sum, FA_2_14_carry , FA_3_9_carry, FA_4_4_sum, FA_4_4_carry);
    FullAdder FA_4_5 (FA_3_11_sum, FA_2_16_carry , FA_3_10_carry, FA_4_5_sum, FA_4_5_carry);
    FullAdder FA_4_6 (FA_3_12_sum, FA_2_18_carry , FA_3_11_carry, FA_4_6_sum, FA_4_6_carry);
    FullAdder FA_4_7 (FA_3_13_sum, FA_2_20_carry , FA_3_12_carry, FA_4_7_sum, FA_4_7_carry);
    FullAdder FA_4_8 (FA_3_14_sum, HA_3_2_sum , FA_3_13_carry, FA_4_8_sum, FA_4_8_carry);
    FullAdder FA_4_9 (FA_3_15_sum, HA_3_3_sum , FA_3_14_carry, FA_4_9_sum, FA_4_9_carry);
    FullAdder FA_4_10 (FA_3_16_sum, HA_3_4_sum , FA_3_15_carry, FA_4_10_sum, FA_4_10_carry);

    FullAdder FA_4_11 (FA_3_17_sum, HA_3_5_sum, FA_3_16_carry, FA_4_11_sum, FA_4_11_carry);
    FullAdder FA_4_12 (FA_3_18_sum, HA_3_6_sum, FA_3_17_carry, FA_4_12_sum, FA_4_12_carry);
    FullAdder FA_4_13 (FA_3_19_sum, FA_3_20_sum, FA_3_18_carry, FA_4_13_sum, FA_4_13_carry);
    FullAdder FA_4_14 (FA_3_21_sum, FA_3_22_sum, FA_3_19_carry, FA_4_14_sum, FA_4_14_carry);
    FullAdder FA_4_15 (FA_3_23_sum, FA_3_24_sum, FA_3_21_carry, FA_4_15_sum, FA_4_15_carry);

    FullAdder FA_4_16 (FA_3_25_sum, FA_3_26_sum, FA_3_23_carry, FA_4_16_sum, FA_4_16_carry);
    FullAdder FA_4_17 (FA_3_27_sum, FA_3_28_sum, FA_3_25_carry, FA_4_17_sum, FA_4_17_carry);
    FullAdder FA_4_18 (FA_3_29_sum, FA_3_30_sum, FA_3_27_carry, FA_4_18_sum, FA_4_18_carry);
    FullAdder FA_4_19 (FA_3_31_sum, FA_3_32_sum, FA_3_29_carry, FA_4_19_sum, FA_4_19_carry);
    FullAdder FA_4_20 (FA_3_33_sum, FA_3_34_sum, FA_3_31_carry, FA_4_20_sum, FA_4_20_carry);
    FullAdder FA_4_21 (FA_3_35_sum, FA_3_36_sum, FA_3_33_carry, FA_4_21_sum, FA_4_21_carry);
    FullAdder FA_4_22 (FA_3_37_sum, FA_3_38_sum, FA_3_35_carry, FA_4_22_sum, FA_4_22_carry);
    FullAdder FA_4_23 (FA_3_39_sum, FA_3_40_sum, FA_3_37_carry, FA_4_23_sum, FA_4_23_carry);
    FullAdder FA_4_24 (FA_3_41_sum, FA_3_42_sum, FA_3_39_carry, FA_4_24_sum, FA_4_24_carry);
    FullAdder FA_4_25 (FA_3_43_sum, FA_3_44_sum, FA_3_41_carry, FA_4_25_sum, FA_4_25_carry);
    FullAdder FA_4_26 (FA_3_45_sum, FA_3_46_sum, FA_3_43_carry, FA_4_26_sum, FA_4_26_carry);
    FullAdder FA_4_27 (FA_3_47_sum, FA_3_48_sum, FA_3_45_carry, FA_4_27_sum, FA_4_27_carry);
    FullAdder FA_4_28 (FA_3_49_sum, FA_3_50_sum, FA_3_47_carry, FA_4_28_sum, FA_4_28_carry);
    FullAdder FA_4_29 (FA_3_51_sum, FA_3_52_sum, FA_3_49_carry, FA_4_29_sum, FA_4_29_carry);
    FullAdder FA_4_30 (FA_3_53_sum, FA_3_54_sum, FA_3_51_carry, FA_4_30_sum, FA_4_30_carry);
    FullAdder FA_4_31 (FA_3_55_sum, FA_3_56_sum, FA_3_53_carry, FA_4_31_sum, FA_4_31_carry);
    FullAdder FA_4_32 (FA_3_57_sum, FA_3_58_sum, FA_3_55_carry, FA_4_32_sum, FA_4_32_carry);
    FullAdder FA_4_33 (FA_3_59_sum, FA_3_60_sum, FA_3_57_carry, FA_4_33_sum, FA_4_33_carry);
    FullAdder FA_4_34 (FA_3_61_sum, FA_3_62_sum, FA_3_59_carry, FA_4_34_sum, FA_4_34_carry);
    FullAdder FA_4_35 (FA_3_63_sum, FA_3_64_sum, FA_3_61_carry, FA_4_35_sum, FA_4_35_carry);
    FullAdder FA_4_36 (FA_3_65_sum, FA_3_66_sum, FA_3_63_carry, FA_4_36_sum, FA_4_36_carry);
    FullAdder FA_4_37 (FA_3_67_sum, FA_3_68_sum, FA_3_65_carry, FA_4_37_sum, FA_4_37_carry);
    FullAdder FA_4_38 (FA_3_69_sum, FA_3_70_sum, FA_3_67_carry, FA_4_38_sum, FA_4_38_carry);
    FullAdder FA_4_39 (FA_3_71_sum, FA_3_72_sum, FA_3_69_carry, FA_4_39_sum, FA_4_39_carry);
    FullAdder FA_4_40 (FA_3_73_sum, FA_3_74_sum, FA_3_71_carry, FA_4_40_sum, FA_4_40_carry);
    FullAdder FA_4_41 (FA_3_75_sum, FA_3_76_sum, FA_3_73_carry, FA_4_41_sum, FA_4_41_carry);
    FullAdder FA_4_42 (FA_3_77_sum, FA_3_78_sum, FA_3_75_carry, FA_4_42_sum, FA_4_42_carry);
    FullAdder FA_4_43 (FA_3_79_sum, FA_3_80_sum, FA_3_77_carry, FA_4_43_sum, FA_4_43_carry);
    FullAdder FA_4_44 (FA_3_81_sum, FA_3_82_sum, FA_3_79_carry, FA_4_44_sum, FA_4_44_carry);
    
    
 // stage 5

    HalfAdder HA_5_1 (FA_4_9_sum, HA_3_2_carry, HA_5_1_sum, HA_5_1_carry);
    FullAdder FA_5_1 (FA_4_10_sum, HA_3_3_carry , FA_4_9_carry, FA_5_1_sum, FA_5_1_carry);
    FullAdder FA_5_2 (FA_4_11_sum, HA_3_4_carry , FA_4_10_carry, FA_5_2_sum, FA_5_2_carry);
    FullAdder FA_5_3 (FA_4_12_sum, HA_3_5_carry , FA_4_11_carry, FA_5_3_sum, FA_5_3_carry);
    FullAdder FA_5_4 (FA_4_13_sum, HA_3_6_carry , FA_4_12_carry, FA_5_4_sum, FA_5_4_carry);
    FullAdder FA_5_5 (FA_4_14_sum, FA_3_20_carry , FA_4_13_carry, FA_5_5_sum, FA_5_5_carry);
    FullAdder FA_5_6 (FA_4_15_sum, FA_3_22_carry , FA_4_14_carry, FA_5_6_sum, FA_5_6_carry);

    FullAdder FA_5_7 (FA_4_16_sum, FA_3_24_carry, FA_4_15_carry, FA_5_7_sum, FA_5_7_carry);
    FullAdder FA_5_8 (FA_4_17_sum, FA_3_26_carry, FA_4_16_carry, FA_5_8_sum, FA_5_8_carry);
    FullAdder FA_5_9 (FA_4_18_sum, FA_3_28_carry, FA_4_17_carry, FA_5_9_sum, FA_5_9_carry);
    FullAdder FA_5_10 (FA_4_19_sum, FA_3_30_carry, FA_4_18_carry, FA_5_10_sum, FA_5_10_carry);
    FullAdder FA_5_11 (FA_4_20_sum, FA_3_32_carry, FA_4_19_carry, FA_5_11_sum, FA_5_11_carry);
    FullAdder FA_5_12 (FA_4_21_sum, FA_3_34_carry, FA_4_20_carry, FA_5_12_sum, FA_5_12_carry);
    FullAdder FA_5_13 (FA_4_22_sum, FA_3_36_carry, FA_4_21_carry, FA_5_13_sum, FA_5_13_carry);
    FullAdder FA_5_14 (FA_4_23_sum, FA_3_38_carry, FA_4_22_carry, FA_5_14_sum, FA_5_14_carry);
    FullAdder FA_5_15 (FA_4_24_sum, FA_3_40_carry, FA_4_23_carry, FA_5_15_sum, FA_5_15_carry);
    FullAdder FA_5_16 (FA_4_25_sum, FA_3_42_carry, FA_4_24_carry, FA_5_16_sum, FA_5_16_carry);
    FullAdder FA_5_17 (FA_4_26_sum, FA_3_44_carry, FA_4_25_carry, FA_5_17_sum, FA_5_17_carry);
    FullAdder FA_5_18 (FA_4_27_sum, FA_3_46_carry, FA_4_26_carry, FA_5_18_sum, FA_5_18_carry);
    FullAdder FA_5_19 (FA_4_28_sum, FA_3_48_carry, FA_4_27_carry, FA_5_19_sum, FA_5_19_carry);
    FullAdder FA_5_20 (FA_4_29_sum, FA_3_50_carry, FA_4_28_carry, FA_5_20_sum, FA_5_20_carry);
    FullAdder FA_5_21 (FA_4_30_sum, FA_3_52_carry, FA_4_29_carry, FA_5_21_sum, FA_5_21_carry);
    FullAdder FA_5_22 (FA_4_31_sum, FA_3_54_carry, FA_4_30_carry, FA_5_22_sum, FA_5_22_carry);
    FullAdder FA_5_23 (FA_4_32_sum, FA_3_56_carry, FA_4_31_carry, FA_5_23_sum, FA_5_23_carry);
    FullAdder FA_5_24 (FA_4_33_sum, FA_3_58_carry, FA_4_32_carry, FA_5_24_sum, FA_5_24_carry);
    FullAdder FA_5_25 (FA_4_34_sum, FA_3_60_carry, FA_4_33_carry, FA_5_25_sum, FA_5_25_carry);
    FullAdder FA_5_26 (FA_4_35_sum, FA_3_62_carry, FA_4_34_carry, FA_5_26_sum, FA_5_26_carry);
    FullAdder FA_5_27 (FA_4_36_sum, FA_3_64_carry, FA_4_35_carry, FA_5_27_sum, FA_5_27_carry);
    FullAdder FA_5_28 (FA_4_37_sum, FA_3_66_carry, FA_4_36_carry, FA_5_28_sum, FA_5_28_carry);
    FullAdder FA_5_29 (FA_4_38_sum, FA_3_68_carry, FA_4_37_carry, FA_5_29_sum, FA_5_29_carry);
    FullAdder FA_5_30 (FA_4_39_sum, FA_3_70_carry, FA_4_38_carry, FA_5_30_sum, FA_5_30_carry);
    FullAdder FA_5_31 (FA_4_40_sum, FA_3_72_carry, FA_4_39_carry, FA_5_31_sum, FA_5_31_carry);
    FullAdder FA_5_32 (FA_4_41_sum, FA_3_74_carry, FA_4_40_carry, FA_5_32_sum, FA_5_32_carry);
    FullAdder FA_5_33 (FA_4_42_sum, FA_3_76_carry, FA_4_41_carry, FA_5_33_sum, FA_5_33_carry);
    FullAdder FA_5_34 (FA_4_43_sum, FA_3_78_carry, FA_4_42_carry, FA_5_34_sum, FA_5_34_carry);
    FullAdder FA_5_35 (FA_4_44_sum, FA_3_80_carry, FA_4_43_carry, FA_5_35_sum, FA_5_35_carry);


    // Final Addition Stage using Carry Propagate Adder
    wire [63:0] arg1 = {
    FA_5_35_sum, FA_5_34_sum, FA_5_33_sum, FA_5_32_sum,
    FA_5_31_sum, FA_5_30_sum, FA_5_29_sum, FA_5_28_sum,
    FA_5_27_sum, FA_5_26_sum, FA_5_25_sum, FA_5_24_sum,
    FA_5_23_sum, FA_5_22_sum, FA_5_21_sum, FA_5_20_sum,
    FA_5_19_sum, FA_5_18_sum, FA_5_17_sum, FA_5_16_sum,
    FA_5_15_sum, FA_5_14_sum, FA_5_13_sum, FA_5_12_sum,
    FA_5_11_sum, FA_5_10_sum, FA_5_9_sum,  FA_5_8_sum,
    FA_5_7_sum,  FA_5_6_sum,  FA_5_5_sum,  FA_5_4_sum,
    FA_5_3_sum, FA_5_2_sum, FA_5_1_sum, HA_5_1_sum,
    FA_4_8_sum, FA_4_7_sum, FA_4_6_sum, FA_4_5_sum,
    FA_4_4_sum, FA_4_3_sum,  FA_4_2_sum,  FA_4_1_sum,
    HA_4_1_sum,  FA_3_5_sum,  FA_3_4_sum,  FA_3_3_sum,
    FA_3_2_sum,  FA_3_1_sum,  HA_3_1_sum,  FA_2_3_sum,
    FA_2_2_sum,  FA_2_1_sum,  HA_2_1_sum,  FA2_sum,
    FA1_sum,     HA1_sum,     P1[5],       P1[4],
    P1[3],       P1[2],       P1[1],       P1[0]
};
    wire [63:0] arg2 = {
    FA_5_34_carry, FA_5_33_carry, FA_5_32_carry, FA_5_31_carry,
    FA_5_30_carry, FA_5_29_carry, FA_5_28_carry, FA_5_27_carry,
    FA_5_26_carry, FA_5_25_carry, FA_5_24_carry, FA_5_23_carry,
    FA_5_22_carry, FA_5_21_carry, FA_5_20_carry, FA_5_19_carry,
    FA_5_18_carry, FA_5_17_carry, FA_5_16_carry, FA_5_15_carry,
    FA_5_14_carry, FA_5_13_carry, FA_5_12_carry, FA_5_11_carry,
    FA_5_10_carry, FA_5_9_carry,  FA_5_8_carry,  FA_5_7_carry,
    FA_5_6_carry,  FA_5_5_carry,  FA_5_4_carry,
    FA_5_3_carry ,FA_5_2_carry, FA_5_1_carry, HA_5_1_carry,
    FA_4_8_carry, FA_4_7_carry, FA_4_6_carry, FA_4_5_carry,
    FA_4_4_carry, FA_4_3_carry,  FA_4_2_carry,  FA_4_1_carry,
    HA_4_1_carry,  FA_3_5_carry,  FA_3_4_carry,  FA_3_3_carry,
    FA_3_2_carry,  FA_3_1_carry,  HA_3_1_carry,  FA_2_3_carry,
    FA_2_2_carry,  FA_2_1_carry,  HA_2_1_carry,  P4[0],
    FA1_carry,     HA1_carry, P3[0],P2[2],P2[1],P2[0],1'b0,1'b0,1'b0
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


