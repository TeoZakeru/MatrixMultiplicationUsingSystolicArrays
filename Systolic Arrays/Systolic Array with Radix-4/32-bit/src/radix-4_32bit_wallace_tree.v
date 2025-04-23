module WallaceTreeMult(
	input clk,
	input rst,
    input [63:0] P1_in,
    input [61:0] P2_in,
    input [59:0] P3_in,
    input [57:0] P4_in,
    input [55:0] P5_in,
    input [53:0] P6_in,
    input [51:0] P7_in,
    input [49:0] P8_in,
    input [47:0] P9_in,
    input [45:0] P10_in,
    input [43:0] P11_in,
    input [41:0] P12_in,
    input [39:0] P13_in,
    input [37:0] P14_in,
    input [35:0] P15_in,
    input [33:0] P16_in,
    output reg [63:0] Out
    );
    
    wire [63:0] sum;
    wire [64:0] carries; // Extra bit for the final carry
    
	reg [63:0] P1;
	reg [63:0] P1_double;
	reg [63:0] P1_triple;
	
	reg [61:0] P2;
	reg [61:0] P2_double;
	reg [61:0] P2_triple;
	
	reg [59:0] P3;
	reg [59:0] P3_double;
	reg [59:0] P3_triple;
	
	reg [57:0] P4;
	reg [57:0] P4_double;
	reg [57:0] P4_triple;
	
	reg [55:0] P5;
	reg [55:0] P5_double;
	reg [55:0] P5_triple;
	
	reg [53:0] P6;
	reg [53:0] P6_double;
	reg [53:0] P6_triple;
	
	reg [51:0] P7;
	reg [51:0] P7_double;
	reg [51:0] P7_triple;
	
	reg [49:0] P8;
	reg [49:0] P8_double;
	reg [49:0] P8_triple;
	
	reg [47:0] P9;
	reg [47:0] P9_double;
	reg [47:0] P9_triple;
	
	reg [45:0] P10;
	reg [45:0] P10_double;
	reg [45:0] P10_triple;
	
	reg [43:0] P11;
	reg [43:0] P11_double;
	reg [43:0] P11_triple;
	
	reg [41:0] P12;
	reg [41:0] P12_double;
	reg [41:0] P12_triple;
	
	reg [39:0] P13;
	reg [39:0] P13_double;
	reg [39:0] P13_triple;
	
	reg [37:0] P14;
	reg [37:0] P14_double;
	reg [37:0] P14_triple;
	
	reg [35:0] P15;
	reg [35:0] P15_double;
	reg [35:0] P15_triple;
	
	reg [33:0] P16;
	reg [33:0] P16_double;
	reg [33:0] P16_triple;
    
    always @(posedge clk or negedge rst) begin
    	if(!rst) begin
    		P1  <= 0;
			P2  <= 0;
			P3  <= 0;
			P4  <= 0;
			P5  <= 0;
			P6  <= 0;
			P7  <= 0;
			P8  <= 0;
			P9  <= 0;
			P10 <= 0;
			P11 <= 0;
			P12 <= 0;
			P13 <= 0;
			P14 <= 0;
			P15 <= 0;
			P16 <= 0;
			
			Out <= 0;
    	end
    	else begin
    		P1  <= P1_in;
			P2  <= P2_in;
			P3  <= P3_in;
			P4  <= P4_in;
			P5  <= P5_in;
			P6  <= P6_in;
			P7  <= P7_in;
			P8  <= P8_in;
			P9  <= P9_in;
			P10 <= P10_in;
			P11 <= P11_in;
			P12 <= P12_in;
			P13 <= P13_in;
			P14 <= P14_in;
			P15 <= P15_in;
			P16 <= P16_in;

			Out <= sum;
    	end
    end
    
     // Stage 1 wires
    wire HA1_sum, HA1_carry, HA2_sum, HA2_carry, HA3_sum, HA3_carry;
    wire HA4_sum, HA4_carry, HA5_sum, HA5_carry, HA6_sum, HA6_carry;
    wire HA7_sum, HA7_carry, HA8_sum, HA8_carry, HA9_sum, HA9_carry;
    wire HA10_sum, HA10_carry, HA11_sum, HA11_carry, HA12_sum, HA12_carry;
    wire HA13_sum, HA13_carry, HA14_sum, HA14_carry, HA15_sum, HA15_carry;
    wire HA16_sum, HA16_carry, HA17_sum, HA17_carry, HA18_sum, HA18_carry;
    wire HA19_sum, HA19_carry, HA20_sum, HA20_carry, HA21_sum, HA21_carry;
    wire HA22_sum, HA22_carry, HA23_sum, HA23_carry, HA24_sum, HA24_carry;
    
    wire FA1_sum, FA1_carry, FA2_sum, FA2_carry, FA3_sum, FA3_carry;
    wire FA4_sum, FA4_carry, FA5_sum, FA5_carry, FA6_sum, FA6_carry;
    wire FA7_sum, FA7_carry, FA8_sum, FA8_carry, FA9_sum, FA9_carry;
    wire FA10_sum, FA10_carry, FA11_sum, FA11_carry, FA12_sum, FA12_carry;
    wire FA13_sum, FA13_carry, FA14_sum, FA14_carry, FA15_sum, FA15_carry;
    wire FA16_sum, FA16_carry, FA17_sum, FA17_carry, FA18_sum, FA18_carry;
    wire FA19_sum, FA19_carry, FA20_sum, FA20_carry, FA21_sum, FA21_carry;
    wire FA22_sum, FA22_carry, FA23_sum, FA23_carry, FA24_sum, FA24_carry;
    wire FA25_sum, FA25_carry, FA26_sum, FA26_carry, FA27_sum, FA27_carry;
    wire FA28_sum, FA28_carry, FA29_sum, FA29_carry, FA30_sum, FA30_carry;
    wire FA31_sum, FA31_carry, FA32_sum, FA32_carry, FA33_sum, FA33_carry;
    wire FA34_sum, FA34_carry, FA35_sum, FA35_carry, FA36_sum, FA36_carry;
    wire FA37_sum, FA37_carry, FA38_sum, FA38_carry, FA39_sum, FA39_carry;
    wire FA40_sum, FA40_carry, FA41_sum, FA41_carry, FA42_sum, FA42_carry;
    wire FA43_sum, FA43_carry, FA44_sum, FA44_carry, FA45_sum, FA45_carry;
    wire FA46_sum, FA46_carry, FA47_sum, FA47_carry, FA48_sum, FA48_carry;
    wire FA49_sum, FA49_carry, FA50_sum, FA50_carry, FA51_sum, FA51_carry;
    wire FA52_sum, FA52_carry, FA53_sum, FA53_carry, FA54_sum, FA54_carry;
    wire FA55_sum, FA55_carry, FA56_sum, FA56_carry, FA57_sum, FA57_carry;
    wire FA58_sum, FA58_carry, FA59_sum, FA59_carry, FA60_sum, FA60_carry;
    wire FA61_sum, FA61_carry, FA62_sum, FA62_carry, FA63_sum, FA63_carry;
    wire FA64_sum, FA64_carry;
    wire FA65_sum, FA65_carry, FA66_sum, FA66_carry, FA67_sum, FA67_carry;
    wire FA68_sum, FA68_carry, FA69_sum, FA69_carry, FA70_sum, FA70_carry;
    wire FA71_sum, FA71_carry, FA72_sum, FA72_carry, FA73_sum, FA73_carry;
    wire FA74_sum, FA74_carry, FA75_sum, FA75_carry, FA76_sum, FA76_carry;
    wire FA77_sum, FA77_carry, FA78_sum, FA78_carry, FA79_sum, FA79_carry;
    wire FA80_sum, FA80_carry, FA81_sum, FA81_carry, FA82_sum, FA82_carry;
    wire FA83_sum, FA83_carry, FA84_sum, FA84_carry, FA85_sum, FA85_carry;
    wire FA86_sum, FA86_carry, FA87_sum, FA87_carry, FA88_sum, FA88_carry;
    wire FA89_sum, FA89_carry, FA90_sum, FA90_carry, FA91_sum, FA91_carry;
    wire FA92_sum, FA92_carry, FA93_sum, FA93_carry, FA94_sum, FA94_carry;
    wire FA95_sum, FA95_carry, FA96_sum, FA96_carry, FA97_sum, FA97_carry;
    wire FA98_sum, FA98_carry, FA99_sum, FA99_carry, FA100_sum, FA100_carry;
    wire FA101_sum, FA101_carry, FA102_sum, FA102_carry, FA103_sum, FA103_carry;
    wire FA104_sum, FA104_carry, FA105_sum, FA105_carry, FA106_sum, FA106_carry;
    wire FA107_sum, FA107_carry, FA108_sum, FA108_carry, FA109_sum, FA109_carry;
    wire FA110_sum, FA110_carry, FA111_sum, FA111_carry, FA112_sum, FA112_carry;
    wire FA113_sum, FA113_carry, FA114_sum, FA114_carry, FA115_sum, FA115_carry;
    wire FA116_sum, FA116_carry, FA117_sum, FA117_carry, FA118_sum, FA118_carry;
    wire FA119_sum, FA119_carry, FA120_sum, FA120_carry, FA121_sum, FA121_carry;
    wire FA122_sum, FA122_carry, FA123_sum, FA123_carry, FA124_sum, FA124_carry;
    wire FA125_sum, FA125_carry, FA126_sum, FA126_carry, FA127_sum, FA127_carry;
    wire FA128_sum, FA128_carry, FA129_sum, FA129_carry, FA130_sum, FA130_carry;
    wire FA131_sum, FA131_carry, FA132_sum, FA132_carry, FA133_sum, FA133_carry;
    wire FA134_sum, FA134_carry, FA135_sum, FA135_carry, FA136_sum, FA136_carry;
    wire FA137_sum, FA137_carry, FA138_sum, FA138_carry, FA139_sum, FA139_carry;
    wire FA140_sum, FA140_carry, FA141_sum, FA141_carry, FA142_sum, FA142_carry;
    wire FA143_sum, FA143_carry, FA144_sum, FA144_carry, FA145_sum, FA145_carry;
    wire FA146_sum, FA146_carry, FA147_sum, FA147_carry, FA148_sum, FA148_carry;
    wire FA149_sum, FA149_carry, FA150_sum, FA150_carry, FA151_sum, FA151_carry;
    wire FA152_sum, FA152_carry, FA153_sum, FA153_carry, FA154_sum, FA154_carry;
    wire FA155_sum, FA155_carry, FA156_sum, FA156_carry, FA157_sum, FA157_carry;
    wire FA158_sum, FA158_carry, FA159_sum, FA159_carry, FA160_sum, FA160_carry;
    wire FA161_sum, FA161_carry, FA162_sum, FA162_carry, FA163_sum, FA163_carry;
    wire FA164_sum, FA164_carry, FA165_sum, FA165_carry, FA166_sum, FA166_carry;
    wire FA167_sum, FA167_carry, FA168_sum, FA168_carry, FA169_sum, FA169_carry;
    wire FA170_sum, FA170_carry, FA171_sum, FA171_carry, FA172_sum, FA172_carry;
    wire FA173_sum, FA173_carry, FA174_sum, FA174_carry, FA175_sum, FA175_carry;
    wire FA176_sum, FA176_carry, FA177_sum, FA177_carry, FA178_sum, FA178_carry;
    wire FA179_sum, FA179_carry, FA180_sum, FA180_carry, FA181_sum, FA181_carry;
    wire FA182_sum, FA182_carry, FA183_sum, FA183_carry, FA184_sum, FA184_carry;
    wire FA185_sum, FA185_carry, FA186_sum, FA186_carry, FA187_sum, FA187_carry;
    wire FA188_sum, FA188_carry, FA189_sum, FA189_carry, FA190_sum, FA190_carry;
    wire FA191_sum, FA191_carry, FA192_sum, FA192_carry, FA193_sum, FA193_carry;
    wire FA194_sum, FA194_carry, FA195_sum, FA195_carry, FA196_sum, FA196_carry;
    wire FA197_sum, FA197_carry, FA198_sum, FA198_carry, FA199_sum, FA199_carry;
    wire FA200_sum, FA200_carry, FA201_sum, FA201_carry, FA202_sum, FA202_carry;
    wire FA203_sum, FA203_carry, FA204_sum, FA204_carry, FA205_sum, FA205_carry;
    wire FA206_sum, FA206_carry, FA207_sum, FA207_carry, FA208_sum, FA208_carry;
    wire FA209_sum, FA209_carry, FA210_sum, FA210_carry, FA211_sum, FA211_carry;
    wire FA212_sum, FA212_carry, FA213_sum, FA213_carry, FA214_sum, FA214_carry;
    wire FA215_sum, FA215_carry, FA216_sum, FA216_carry, FA217_sum, FA217_carry;
    wire FA218_sum, FA218_carry, FA219_sum, FA219_carry, FA220_sum, FA220_carry;
    wire FA221_sum, FA221_carry, FA222_sum, FA222_carry, FA223_sum, FA223_carry;
    wire FA224_sum, FA224_carry, FA225_sum, FA225_carry, FA226_sum, FA226_carry;
    wire FA227_sum, FA227_carry, FA228_sum, FA228_carry, FA229_sum, FA229_carry;
    wire FA230_sum, FA230_carry, FA231_sum, FA231_carry, FA232_sum, FA232_carry;
    wire FA233_sum, FA233_carry, FA234_sum, FA234_carry, FA235_sum, FA235_carry;
    wire FA236_sum, FA236_carry, FA237_sum, FA237_carry, FA238_sum, FA238_carry;
    wire FA239_sum, FA239_carry;
    
    reg HA1_sum_reg, HA1_carry_reg, HA2_sum_reg, HA2_carry_reg, HA3_sum_reg, HA3_carry_reg;
    reg HA4_sum_reg, HA4_carry_reg, HA5_sum_reg, HA5_carry_reg, HA6_sum_reg, HA6_carry_reg;
    reg HA7_sum_reg, HA7_carry_reg, HA8_sum_reg, HA8_carry_reg, HA9_sum_reg, HA9_carry_reg;
    reg HA10_sum_reg, HA10_carry_reg, HA11_sum_reg, HA11_carry_reg, HA12_sum_reg, HA12_carry_reg;
    reg HA13_sum_reg, HA13_carry_reg, HA14_sum_reg, HA14_carry_reg, HA15_sum_reg, HA15_carry_reg;
    reg HA16_sum_reg, HA16_carry_reg, HA17_sum_reg, HA17_carry_reg, HA18_sum_reg, HA18_carry_reg;
    reg HA19_sum_reg, HA19_carry_reg, HA20_sum_reg, HA20_carry_reg, HA21_sum_reg, HA21_carry_reg;
    reg HA22_sum_reg, HA22_carry_reg, HA23_sum_reg, HA23_carry_reg, HA24_sum_reg, HA24_carry_reg;
    
    reg FA1_sum_reg, FA1_carry_reg, FA2_sum_reg, FA2_carry_reg, FA3_sum_reg, FA3_carry_reg;
    reg FA4_sum_reg, FA4_carry_reg, FA5_sum_reg, FA5_carry_reg, FA6_sum_reg, FA6_carry_reg;
    reg FA7_sum_reg, FA7_carry_reg, FA8_sum_reg, FA8_carry_reg, FA9_sum_reg, FA9_carry_reg;
    reg FA10_sum_reg, FA10_carry_reg, FA11_sum_reg, FA11_carry_reg, FA12_sum_reg, FA12_carry_reg;
    reg FA13_sum_reg, FA13_carry_reg, FA14_sum_reg, FA14_carry_reg, FA15_sum_reg, FA15_carry_reg;
    reg FA16_sum_reg, FA16_carry_reg, FA17_sum_reg, FA17_carry_reg, FA18_sum_reg, FA18_carry_reg;
    reg FA19_sum_reg, FA19_carry_reg, FA20_sum_reg, FA20_carry_reg, FA21_sum_reg, FA21_carry_reg;
    reg FA22_sum_reg, FA22_carry_reg, FA23_sum_reg, FA23_carry_reg, FA24_sum_reg, FA24_carry_reg;
    reg FA25_sum_reg, FA25_carry_reg, FA26_sum_reg, FA26_carry_reg, FA27_sum_reg, FA27_carry_reg;
    reg FA28_sum_reg, FA28_carry_reg, FA29_sum_reg, FA29_carry_reg, FA30_sum_reg, FA30_carry_reg;
    reg FA31_sum_reg, FA31_carry_reg, FA32_sum_reg, FA32_carry_reg, FA33_sum_reg, FA33_carry_reg;
    reg FA34_sum_reg, FA34_carry_reg, FA35_sum_reg, FA35_carry_reg, FA36_sum_reg, FA36_carry_reg;
    reg FA37_sum_reg, FA37_carry_reg, FA38_sum_reg, FA38_carry_reg, FA39_sum_reg, FA39_carry_reg;
    reg FA40_sum_reg, FA40_carry_reg, FA41_sum_reg, FA41_carry_reg, FA42_sum_reg, FA42_carry_reg;
    reg FA43_sum_reg, FA43_carry_reg, FA44_sum_reg, FA44_carry_reg, FA45_sum_reg, FA45_carry_reg;
    reg FA46_sum_reg, FA46_carry_reg, FA47_sum_reg, FA47_carry_reg, FA48_sum_reg, FA48_carry_reg;
    reg FA49_sum_reg, FA49_carry_reg, FA50_sum_reg, FA50_carry_reg, FA51_sum_reg, FA51_carry_reg;
    reg FA52_sum_reg, FA52_carry_reg, FA53_sum_reg, FA53_carry_reg, FA54_sum_reg, FA54_carry_reg;
    reg FA55_sum_reg, FA55_carry_reg, FA56_sum_reg, FA56_carry_reg, FA57_sum_reg, FA57_carry_reg;
    reg FA58_sum_reg, FA58_carry_reg, FA59_sum_reg, FA59_carry_reg, FA60_sum_reg, FA60_carry_reg;
    reg FA61_sum_reg, FA61_carry_reg, FA62_sum_reg, FA62_carry_reg, FA63_sum_reg, FA63_carry_reg;
    reg FA64_sum_reg, FA64_carry_reg;
    reg FA65_sum_reg, FA65_carry_reg, FA66_sum_reg, FA66_carry_reg, FA67_sum_reg, FA67_carry_reg;
    reg FA68_sum_reg, FA68_carry_reg, FA69_sum_reg, FA69_carry_reg, FA70_sum_reg, FA70_carry_reg;
    reg FA71_sum_reg, FA71_carry_reg, FA72_sum_reg, FA72_carry_reg, FA73_sum_reg, FA73_carry_reg;
    reg FA74_sum_reg, FA74_carry_reg, FA75_sum_reg, FA75_carry_reg, FA76_sum_reg, FA76_carry_reg;
    reg FA77_sum_reg, FA77_carry_reg, FA78_sum_reg, FA78_carry_reg, FA79_sum_reg, FA79_carry_reg;
    reg FA80_sum_reg, FA80_carry_reg, FA81_sum_reg, FA81_carry_reg, FA82_sum_reg, FA82_carry_reg;
    reg FA83_sum_reg, FA83_carry_reg, FA84_sum_reg, FA84_carry_reg, FA85_sum_reg, FA85_carry_reg;
    reg FA86_sum_reg, FA86_carry_reg, FA87_sum_reg, FA87_carry_reg, FA88_sum_reg, FA88_carry_reg;
    reg FA89_sum_reg, FA89_carry_reg, FA90_sum_reg, FA90_carry_reg, FA91_sum_reg, FA91_carry_reg;
    reg FA92_sum_reg, FA92_carry_reg, FA93_sum_reg, FA93_carry_reg, FA94_sum_reg, FA94_carry_reg;
    reg FA95_sum_reg, FA95_carry_reg, FA96_sum_reg, FA96_carry_reg, FA97_sum_reg, FA97_carry_reg;
    reg FA98_sum_reg, FA98_carry_reg, FA99_sum_reg, FA99_carry_reg, FA100_sum_reg, FA100_carry_reg;
    reg FA101_sum_reg, FA101_carry_reg, FA102_sum_reg, FA102_carry_reg, FA103_sum_reg, FA103_carry_reg;
    reg FA104_sum_reg, FA104_carry_reg, FA105_sum_reg, FA105_carry_reg, FA106_sum_reg, FA106_carry_reg;
    reg FA107_sum_reg, FA107_carry_reg, FA108_sum_reg, FA108_carry_reg, FA109_sum_reg, FA109_carry_reg;
    reg FA110_sum_reg, FA110_carry_reg, FA111_sum_reg, FA111_carry_reg, FA112_sum_reg, FA112_carry_reg;
    reg FA113_sum_reg, FA113_carry_reg, FA114_sum_reg, FA114_carry_reg, FA115_sum_reg, FA115_carry_reg;
    reg FA116_sum_reg, FA116_carry_reg, FA117_sum_reg, FA117_carry_reg, FA118_sum_reg, FA118_carry_reg;
    reg FA119_sum_reg, FA119_carry_reg, FA120_sum_reg, FA120_carry_reg, FA121_sum_reg, FA121_carry_reg;
    reg FA122_sum_reg, FA122_carry_reg, FA123_sum_reg, FA123_carry_reg, FA124_sum_reg, FA124_carry_reg;
    reg FA125_sum_reg, FA125_carry_reg, FA126_sum_reg, FA126_carry_reg, FA127_sum_reg, FA127_carry_reg;
    reg FA128_sum_reg, FA128_carry_reg, FA129_sum_reg, FA129_carry_reg, FA130_sum_reg, FA130_carry_reg;
    reg FA131_sum_reg, FA131_carry_reg, FA132_sum_reg, FA132_carry_reg, FA133_sum_reg, FA133_carry_reg;
    reg FA134_sum_reg, FA134_carry_reg, FA135_sum_reg, FA135_carry_reg, FA136_sum_reg, FA136_carry_reg;
    reg FA137_sum_reg, FA137_carry_reg, FA138_sum_reg, FA138_carry_reg, FA139_sum_reg, FA139_carry_reg;
    reg FA140_sum_reg, FA140_carry_reg, FA141_sum_reg, FA141_carry_reg, FA142_sum_reg, FA142_carry_reg;
    reg FA143_sum_reg, FA143_carry_reg, FA144_sum_reg, FA144_carry_reg, FA145_sum_reg, FA145_carry_reg;
    reg FA146_sum_reg, FA146_carry_reg, FA147_sum_reg, FA147_carry_reg, FA148_sum_reg, FA148_carry_reg;
    reg FA149_sum_reg, FA149_carry_reg, FA150_sum_reg, FA150_carry_reg, FA151_sum_reg, FA151_carry_reg;
    reg FA152_sum_reg, FA152_carry_reg, FA153_sum_reg, FA153_carry_reg, FA154_sum_reg, FA154_carry_reg;
    reg FA155_sum_reg, FA155_carry_reg, FA156_sum_reg, FA156_carry_reg, FA157_sum_reg, FA157_carry_reg;
    reg FA158_sum_reg, FA158_carry_reg, FA159_sum_reg, FA159_carry_reg, FA160_sum_reg, FA160_carry_reg;
    reg FA161_sum_reg, FA161_carry_reg, FA162_sum_reg, FA162_carry_reg, FA163_sum_reg, FA163_carry_reg;
    reg FA164_sum_reg, FA164_carry_reg, FA165_sum_reg, FA165_carry_reg, FA166_sum_reg, FA166_carry_reg;
    reg FA167_sum_reg, FA167_carry_reg, FA168_sum_reg, FA168_carry_reg, FA169_sum_reg, FA169_carry_reg;
    reg FA170_sum_reg, FA170_carry_reg, FA171_sum_reg, FA171_carry_reg, FA172_sum_reg, FA172_carry_reg;
    reg FA173_sum_reg, FA173_carry_reg, FA174_sum_reg, FA174_carry_reg, FA175_sum_reg, FA175_carry_reg;
    reg FA176_sum_reg, FA176_carry_reg, FA177_sum_reg, FA177_carry_reg, FA178_sum_reg, FA178_carry_reg;
    reg FA179_sum_reg, FA179_carry_reg, FA180_sum_reg, FA180_carry_reg, FA181_sum_reg, FA181_carry_reg;
    reg FA182_sum_reg, FA182_carry_reg, FA183_sum_reg, FA183_carry_reg, FA184_sum_reg, FA184_carry_reg;
    reg FA185_sum_reg, FA185_carry_reg, FA186_sum_reg, FA186_carry_reg, FA187_sum_reg, FA187_carry_reg;
    reg FA188_sum_reg, FA188_carry_reg, FA189_sum_reg, FA189_carry_reg, FA190_sum_reg, FA190_carry_reg;
    reg FA191_sum_reg, FA191_carry_reg, FA192_sum_reg, FA192_carry_reg, FA193_sum_reg, FA193_carry_reg;
    reg FA194_sum_reg, FA194_carry_reg, FA195_sum_reg, FA195_carry_reg, FA196_sum_reg, FA196_carry_reg;
    reg FA197_sum_reg, FA197_carry_reg, FA198_sum_reg, FA198_carry_reg, FA199_sum_reg, FA199_carry_reg;
    reg FA200_sum_reg, FA200_carry_reg, FA201_sum_reg, FA201_carry_reg, FA202_sum_reg, FA202_carry_reg;
    reg FA203_sum_reg, FA203_carry_reg, FA204_sum_reg, FA204_carry_reg, FA205_sum_reg, FA205_carry_reg;
    reg FA206_sum_reg, FA206_carry_reg, FA207_sum_reg, FA207_carry_reg, FA208_sum_reg, FA208_carry_reg;
    reg FA209_sum_reg, FA209_carry_reg, FA210_sum_reg, FA210_carry_reg, FA211_sum_reg, FA211_carry_reg;
    reg FA212_sum_reg, FA212_carry_reg, FA213_sum_reg, FA213_carry_reg, FA214_sum_reg, FA214_carry_reg;
    reg FA215_sum_reg, FA215_carry_reg, FA216_sum_reg, FA216_carry_reg, FA217_sum_reg, FA217_carry_reg;
    reg FA218_sum_reg, FA218_carry_reg, FA219_sum_reg, FA219_carry_reg, FA220_sum_reg, FA220_carry_reg;
    reg FA221_sum_reg, FA221_carry_reg, FA222_sum_reg, FA222_carry_reg, FA223_sum_reg, FA223_carry_reg;
    reg FA224_sum_reg, FA224_carry_reg, FA225_sum_reg, FA225_carry_reg, FA226_sum_reg, FA226_carry_reg;
    reg FA227_sum_reg, FA227_carry_reg, FA228_sum_reg, FA228_carry_reg, FA229_sum_reg, FA229_carry_reg;
    reg FA230_sum_reg, FA230_carry_reg, FA231_sum_reg, FA231_carry_reg, FA232_sum_reg, FA232_carry_reg;
    reg FA233_sum_reg, FA233_carry_reg, FA234_sum_reg, FA234_carry_reg, FA235_sum_reg, FA235_carry_reg;
    reg FA236_sum_reg, FA236_carry_reg, FA237_sum_reg, FA237_carry_reg, FA238_sum_reg, FA238_carry_reg;
    reg FA239_sum_reg, FA239_carry_reg;
    
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
    wire HA_2_37_sum, HA_2_37_carry, HA_2_38_sum, HA_2_38_carry, HA_2_39_sum, HA_2_39_carry;
    wire HA_2_40_sum, HA_2_40_carry, HA_2_41_sum, HA_2_41_carry;
    
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
    wire FA_2_97_sum, FA_2_97_carry, FA_2_98_sum, FA_2_98_carry, FA_2_99_sum, FA_2_99_carry;
    wire FA_2_100_sum, FA_2_100_carry, FA_2_101_sum, FA_2_101_carry, FA_2_102_sum, FA_2_102_carry;
    wire FA_2_103_sum, FA_2_103_carry, FA_2_104_sum, FA_2_104_carry, FA_2_105_sum, FA_2_105_carry;
    wire FA_2_106_sum, FA_2_106_carry, FA_2_107_sum, FA_2_107_carry, FA_2_108_sum, FA_2_108_carry;
    wire FA_2_109_sum, FA_2_109_carry, FA_2_110_sum, FA_2_110_carry, FA_2_111_sum, FA_2_111_carry;
    wire FA_2_112_sum, FA_2_112_carry, FA_2_113_sum, FA_2_113_carry, FA_2_114_sum, FA_2_114_carry;
    wire FA_2_115_sum, FA_2_115_carry, FA_2_116_sum, FA_2_116_carry, FA_2_117_sum, FA_2_117_carry;
    wire FA_2_118_sum, FA_2_118_carry, FA_2_119_sum, FA_2_119_carry, FA_2_120_sum, FA_2_120_carry;
    wire FA_2_121_sum, FA_2_121_carry, FA_2_122_sum, FA_2_122_carry, FA_2_123_sum, FA_2_123_carry;
    wire FA_2_124_sum, FA_2_124_carry, FA_2_125_sum, FA_2_125_carry, FA_2_126_sum, FA_2_126_carry;
    wire FA_2_127_sum, FA_2_127_carry, FA_2_128_sum, FA_2_128_carry, FA_2_129_sum, FA_2_129_carry;
    wire FA_2_130_sum, FA_2_130_carry, FA_2_131_sum, FA_2_131_carry, FA_2_132_sum, FA_2_132_carry;
    wire FA_2_133_sum, FA_2_133_carry, FA_2_134_sum, FA_2_134_carry, FA_2_135_sum, FA_2_135_carry;
    wire FA_2_136_sum, FA_2_136_carry, FA_2_137_sum, FA_2_137_carry, FA_2_138_sum, FA_2_138_carry;
    wire FA_2_139_sum, FA_2_139_carry, FA_2_140_sum, FA_2_140_carry, FA_2_141_sum, FA_2_141_carry;
    wire FA_2_142_sum, FA_2_142_carry, FA_2_143_sum, FA_2_143_carry, FA_2_144_sum, FA_2_144_carry;
    wire FA_2_145_sum, FA_2_145_carry, FA_2_146_sum, FA_2_146_carry;
    
    reg HA_2_1_sum_reg, HA_2_1_carry_reg, HA_2_2_sum_reg, HA_2_2_carry_reg, HA_2_3_sum_reg, HA_2_3_carry_reg;
    reg HA_2_4_sum_reg, HA_2_4_carry_reg, HA_2_5_sum_reg, HA_2_5_carry_reg, HA_2_6_sum_reg, HA_2_6_carry_reg;
    reg HA_2_7_sum_reg, HA_2_7_carry_reg, HA_2_8_sum_reg, HA_2_8_carry_reg, HA_2_9_sum_reg, HA_2_9_carry_reg;
    reg HA_2_10_sum_reg, HA_2_10_carry_reg, HA_2_11_sum_reg, HA_2_11_carry_reg, HA_2_12_sum_reg, HA_2_12_carry_reg;
    reg HA_2_13_sum_reg, HA_2_13_carry_reg, HA_2_14_sum_reg, HA_2_14_carry_reg, HA_2_15_sum_reg, HA_2_15_carry_reg;
    reg HA_2_16_sum_reg, HA_2_16_carry_reg, HA_2_17_sum_reg, HA_2_17_carry_reg, HA_2_18_sum_reg, HA_2_18_carry_reg;
    reg HA_2_19_sum_reg, HA_2_19_carry_reg, HA_2_20_sum_reg, HA_2_20_carry_reg, HA_2_21_sum_reg, HA_2_21_carry_reg;
    reg HA_2_22_sum_reg, HA_2_22_carry_reg, HA_2_23_sum_reg, HA_2_23_carry_reg, HA_2_24_sum_reg, HA_2_24_carry_reg;
    reg HA_2_25_sum_reg, HA_2_25_carry_reg, HA_2_26_sum_reg, HA_2_26_carry_reg, HA_2_27_sum_reg, HA_2_27_carry_reg;
    reg HA_2_28_sum_reg, HA_2_28_carry_reg, HA_2_29_sum_reg, HA_2_29_carry_reg, HA_2_30_sum_reg, HA_2_30_carry_reg;
    reg HA_2_31_sum_reg, HA_2_31_carry_reg, HA_2_32_sum_reg, HA_2_32_carry_reg, HA_2_33_sum_reg, HA_2_33_carry_reg;
    reg HA_2_34_sum_reg, HA_2_34_carry_reg, HA_2_35_sum_reg, HA_2_35_carry_reg, HA_2_36_sum_reg, HA_2_36_carry_reg;
    reg HA_2_37_sum_reg, HA_2_37_carry_reg, HA_2_38_sum_reg, HA_2_38_carry_reg, HA_2_39_sum_reg, HA_2_39_carry_reg;
    reg HA_2_40_sum_reg, HA_2_40_carry_reg, HA_2_41_sum_reg, HA_2_41_carry_reg;
    
    reg FA_2_1_sum_reg, FA_2_1_carry_reg, FA_2_2_sum_reg, FA_2_2_carry_reg, FA_2_3_sum_reg, FA_2_3_carry_reg;
    reg FA_2_4_sum_reg, FA_2_4_carry_reg, FA_2_5_sum_reg, FA_2_5_carry_reg, FA_2_6_sum_reg, FA_2_6_carry_reg;
    reg FA_2_7_sum_reg, FA_2_7_carry_reg, FA_2_8_sum_reg, FA_2_8_carry_reg, FA_2_9_sum_reg, FA_2_9_carry_reg;
    reg FA_2_10_sum_reg, FA_2_10_carry_reg, FA_2_11_sum_reg, FA_2_11_carry_reg, FA_2_12_sum_reg, FA_2_12_carry_reg;
    reg FA_2_13_sum_reg, FA_2_13_carry_reg, FA_2_14_sum_reg, FA_2_14_carry_reg, FA_2_15_sum_reg, FA_2_15_carry_reg;
    reg FA_2_16_sum_reg, FA_2_16_carry_reg, FA_2_17_sum_reg, FA_2_17_carry_reg, FA_2_18_sum_reg, FA_2_18_carry_reg;
    reg FA_2_19_sum_reg, FA_2_19_carry_reg, FA_2_20_sum_reg, FA_2_20_carry_reg, FA_2_21_sum_reg, FA_2_21_carry_reg;
    reg FA_2_22_sum_reg, FA_2_22_carry_reg, FA_2_23_sum_reg, FA_2_23_carry_reg, FA_2_24_sum_reg, FA_2_24_carry_reg;
    reg FA_2_25_sum_reg, FA_2_25_carry_reg, FA_2_26_sum_reg, FA_2_26_carry_reg, FA_2_27_sum_reg, FA_2_27_carry_reg;
    reg FA_2_28_sum_reg, FA_2_28_carry_reg, FA_2_29_sum_reg, FA_2_29_carry_reg, FA_2_30_sum_reg, FA_2_30_carry_reg;
    reg FA_2_31_sum_reg, FA_2_31_carry_reg, FA_2_32_sum_reg, FA_2_32_carry_reg, FA_2_33_sum_reg, FA_2_33_carry_reg;
    reg FA_2_34_sum_reg, FA_2_34_carry_reg, FA_2_35_sum_reg, FA_2_35_carry_reg, FA_2_36_sum_reg, FA_2_36_carry_reg;
    reg FA_2_37_sum_reg, FA_2_37_carry_reg, FA_2_38_sum_reg, FA_2_38_carry_reg, FA_2_39_sum_reg, FA_2_39_carry_reg;
    reg FA_2_40_sum_reg, FA_2_40_carry_reg, FA_2_41_sum_reg, FA_2_41_carry_reg, FA_2_42_sum_reg, FA_2_42_carry_reg;
    reg FA_2_43_sum_reg, FA_2_43_carry_reg, FA_2_44_sum_reg, FA_2_44_carry_reg, FA_2_45_sum_reg, FA_2_45_carry_reg;
    reg FA_2_46_sum_reg, FA_2_46_carry_reg, FA_2_47_sum_reg, FA_2_47_carry_reg, FA_2_48_sum_reg, FA_2_48_carry_reg;
    reg FA_2_49_sum_reg, FA_2_49_carry_reg, FA_2_50_sum_reg, FA_2_50_carry_reg, FA_2_51_sum_reg, FA_2_51_carry_reg;
    reg FA_2_52_sum_reg, FA_2_52_carry_reg, FA_2_53_sum_reg, FA_2_53_carry_reg, FA_2_54_sum_reg, FA_2_54_carry_reg;
    reg FA_2_55_sum_reg, FA_2_55_carry_reg, FA_2_56_sum_reg, FA_2_56_carry_reg, FA_2_57_sum_reg, FA_2_57_carry_reg;
    reg FA_2_58_sum_reg, FA_2_58_carry_reg, FA_2_59_sum_reg, FA_2_59_carry_reg, FA_2_60_sum_reg, FA_2_60_carry_reg;
    reg FA_2_61_sum_reg, FA_2_61_carry_reg, FA_2_62_sum_reg, FA_2_62_carry_reg, FA_2_63_sum_reg, FA_2_63_carry_reg;
    reg FA_2_64_sum_reg, FA_2_64_carry_reg, FA_2_65_sum_reg, FA_2_65_carry_reg, FA_2_66_sum_reg, FA_2_66_carry_reg;
    reg FA_2_67_sum_reg, FA_2_67_carry_reg, FA_2_68_sum_reg, FA_2_68_carry_reg, FA_2_69_sum_reg, FA_2_69_carry_reg;
    reg FA_2_70_sum_reg, FA_2_70_carry_reg, FA_2_71_sum_reg, FA_2_71_carry_reg, FA_2_72_sum_reg, FA_2_72_carry_reg;
    reg FA_2_73_sum_reg, FA_2_73_carry_reg, FA_2_74_sum_reg, FA_2_74_carry_reg, FA_2_75_sum_reg, FA_2_75_carry_reg;
    reg FA_2_76_sum_reg, FA_2_76_carry_reg, FA_2_77_sum_reg, FA_2_77_carry_reg, FA_2_78_sum_reg, FA_2_78_carry_reg;
    reg FA_2_79_sum_reg, FA_2_79_carry_reg, FA_2_80_sum_reg, FA_2_80_carry_reg, FA_2_81_sum_reg, FA_2_81_carry_reg;
    reg FA_2_82_sum_reg, FA_2_82_carry_reg, FA_2_83_sum_reg, FA_2_83_carry_reg, FA_2_84_sum_reg, FA_2_84_carry_reg;
    reg FA_2_85_sum_reg, FA_2_85_carry_reg, FA_2_86_sum_reg, FA_2_86_carry_reg, FA_2_87_sum_reg, FA_2_87_carry_reg;
    reg FA_2_88_sum_reg, FA_2_88_carry_reg, FA_2_89_sum_reg, FA_2_89_carry_reg, FA_2_90_sum_reg, FA_2_90_carry_reg;
    reg FA_2_91_sum_reg, FA_2_91_carry_reg, FA_2_92_sum_reg, FA_2_92_carry_reg, FA_2_93_sum_reg, FA_2_93_carry_reg;
    reg FA_2_94_sum_reg, FA_2_94_carry_reg, FA_2_95_sum_reg, FA_2_95_carry_reg, FA_2_96_sum_reg, FA_2_96_carry_reg;
    reg FA_2_97_sum_reg, FA_2_97_carry_reg, FA_2_98_sum_reg, FA_2_98_carry_reg, FA_2_99_sum_reg, FA_2_99_carry_reg;
    reg FA_2_100_sum_reg, FA_2_100_carry_reg, FA_2_101_sum_reg, FA_2_101_carry_reg, FA_2_102_sum_reg, FA_2_102_carry_reg;
    reg FA_2_103_sum_reg, FA_2_103_carry_reg, FA_2_104_sum_reg, FA_2_104_carry_reg, FA_2_105_sum_reg, FA_2_105_carry_reg;
    reg FA_2_106_sum_reg, FA_2_106_carry_reg, FA_2_107_sum_reg, FA_2_107_carry_reg, FA_2_108_sum_reg, FA_2_108_carry_reg;
    reg FA_2_109_sum_reg, FA_2_109_carry_reg, FA_2_110_sum_reg, FA_2_110_carry_reg, FA_2_111_sum_reg, FA_2_111_carry_reg;
    reg FA_2_112_sum_reg, FA_2_112_carry_reg, FA_2_113_sum_reg, FA_2_113_carry_reg, FA_2_114_sum_reg, FA_2_114_carry_reg;
    reg FA_2_115_sum_reg, FA_2_115_carry_reg, FA_2_116_sum_reg, FA_2_116_carry_reg, FA_2_117_sum_reg, FA_2_117_carry_reg;
    reg FA_2_118_sum_reg, FA_2_118_carry_reg, FA_2_119_sum_reg, FA_2_119_carry_reg, FA_2_120_sum_reg, FA_2_120_carry_reg;
    reg FA_2_121_sum_reg, FA_2_121_carry_reg, FA_2_122_sum_reg, FA_2_122_carry_reg, FA_2_123_sum_reg, FA_2_123_carry_reg;
    reg FA_2_124_sum_reg, FA_2_124_carry_reg, FA_2_125_sum_reg, FA_2_125_carry_reg, FA_2_126_sum_reg, FA_2_126_carry_reg;
    reg FA_2_127_sum_reg, FA_2_127_carry_reg, FA_2_128_sum_reg, FA_2_128_carry_reg, FA_2_129_sum_reg, FA_2_129_carry_reg;
    reg FA_2_130_sum_reg, FA_2_130_carry_reg, FA_2_131_sum_reg, FA_2_131_carry_reg, FA_2_132_sum_reg, FA_2_132_carry_reg;
    reg FA_2_133_sum_reg, FA_2_133_carry_reg, FA_2_134_sum_reg, FA_2_134_carry_reg, FA_2_135_sum_reg, FA_2_135_carry_reg;
    reg FA_2_136_sum_reg, FA_2_136_carry_reg, FA_2_137_sum_reg, FA_2_137_carry_reg, FA_2_138_sum_reg, FA_2_138_carry_reg;
    reg FA_2_139_sum_reg, FA_2_139_carry_reg, FA_2_140_sum_reg, FA_2_140_carry_reg, FA_2_141_sum_reg, FA_2_141_carry_reg;
    reg FA_2_142_sum_reg, FA_2_142_carry_reg, FA_2_143_sum_reg, FA_2_143_carry_reg, FA_2_144_sum_reg, FA_2_144_carry_reg;
    reg FA_2_145_sum_reg, FA_2_145_carry_reg, FA_2_146_sum_reg, FA_2_146_carry_reg;
    
    
        // Stage 3 wires
    wire HA_3_1_sum, HA_3_1_carry;
    wire HA_3_2_sum, HA_3_2_carry, HA_3_3_sum, HA_3_3_carry, HA_3_4_sum, HA_3_4_carry;
    wire HA_3_5_sum, HA_3_5_carry, HA_3_6_sum, HA_3_6_carry, HA_3_7_sum, HA_3_7_carry;
    wire HA_3_8_sum, HA_3_8_carry, HA_3_9_sum, HA_3_9_carry, HA_3_10_sum, HA_3_10_carry;
    wire HA_3_11_sum, HA_3_11_carry, HA_3_12_sum, HA_3_12_carry, HA_3_13_sum, HA_3_13_carry;
    wire HA_3_14_sum, HA_3_14_carry, HA_3_15_sum, HA_3_15_carry, HA_3_16_sum, HA_3_16_carry;
    wire HA_3_17_sum, HA_3_17_carry, HA_3_18_sum, HA_3_18_carry, HA_3_19_sum, HA_3_19_carry;
    wire HA_3_20_sum, HA_3_20_carry, HA_3_21_sum, HA_3_21_carry, HA_3_22_sum, HA_3_22_carry;
    wire HA_3_23_sum, HA_3_23_carry, HA_3_24_sum, HA_3_24_carry, HA_3_25_sum, HA_3_25_carry;
    wire HA_3_26_sum, HA_3_26_carry, HA_3_27_sum, HA_3_27_carry, HA_3_28_sum, HA_3_28_carry;
    wire HA_3_29_sum, HA_3_29_carry, HA_3_30_sum, HA_3_30_carry, HA_3_31_sum, HA_3_31_carry;
    wire HA_3_32_sum, HA_3_32_carry, HA_3_33_sum, HA_3_33_carry, HA_3_34_sum, HA_3_34_carry;
    wire HA_3_35_sum, HA_3_35_carry, HA_3_36_sum, HA_3_36_carry, HA_3_37_sum, HA_3_37_carry;
    wire HA_3_38_sum, HA_3_38_carry;
    
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
    wire FA_3_82_sum, FA_3_82_carry, FA_3_83_sum, FA_3_83_carry, FA_3_84_sum, FA_3_84_carry;
    wire FA_3_85_sum, FA_3_85_carry, FA_3_86_sum, FA_3_86_carry, FA_3_87_sum, FA_3_87_carry;
    wire FA_3_88_sum, FA_3_88_carry, FA_3_89_sum, FA_3_89_carry, FA_3_90_sum, FA_3_90_carry;
    wire FA_3_91_sum, FA_3_91_carry, FA_3_92_sum, FA_3_92_carry, FA_3_93_sum, FA_3_93_carry;
    wire FA_3_94_sum, FA_3_94_carry, FA_3_95_sum, FA_3_95_carry, FA_3_96_sum, FA_3_96_carry;
    
    
        // Stage 4 wires
    wire HA_4_1_sum, HA_4_1_carry, HA_4_2_sum, HA_4_2_carry, HA_4_3_sum, HA_4_3_carry;
    wire HA_4_4_sum, HA_4_4_carry, HA_4_5_sum, HA_4_5_carry, HA_4_6_sum, HA_4_6_carry;
    
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
    wire FA_4_43_sum, FA_4_43_carry, FA_4_44_sum, FA_4_44_carry, FA_4_45_sum, FA_4_45_carry;
    wire FA_4_46_sum, FA_4_46_carry, FA_4_47_sum, FA_4_47_carry, FA_4_48_sum, FA_4_48_carry;
    wire FA_4_49_sum, FA_4_49_carry, FA_4_50_sum, FA_4_50_carry, FA_4_51_sum, FA_4_51_carry;
    wire FA_4_52_sum, FA_4_52_carry, FA_4_53_sum, FA_4_53_carry, FA_4_54_sum, FA_4_54_carry;
    wire FA_4_55_sum, FA_4_55_carry, FA_4_56_sum, FA_4_56_carry, FA_4_57_sum, FA_4_57_carry;
    wire FA_4_58_sum, FA_4_58_carry, FA_4_59_sum, FA_4_59_carry, FA_4_60_sum, FA_4_60_carry;
    wire FA_4_61_sum, FA_4_61_carry, FA_4_62_sum, FA_4_62_carry, FA_4_63_sum, FA_4_63_carry;
    wire FA_4_64_sum, FA_4_64_carry, FA_4_65_sum, FA_4_65_carry, FA_4_66_sum, FA_4_66_carry;
    wire FA_4_67_sum, FA_4_67_carry, FA_4_68_sum, FA_4_68_carry, FA_4_69_sum, FA_4_69_carry;
    wire FA_4_70_sum, FA_4_70_carry, FA_4_71_sum, FA_4_71_carry, FA_4_72_sum, FA_4_72_carry;
    wire FA_4_73_sum, FA_4_73_carry, FA_4_74_sum, FA_4_74_carry, FA_4_75_sum, FA_4_75_carry;
    wire FA_4_76_sum, FA_4_76_carry, FA_4_77_sum, FA_4_77_carry, FA_4_78_sum, FA_4_78_carry;
    wire FA_4_79_sum, FA_4_79_carry, FA_4_80_sum, FA_4_80_carry, FA_4_81_sum, FA_4_81_carry;
    wire FA_4_82_sum, FA_4_82_carry, FA_4_83_sum, FA_4_83_carry, FA_4_84_sum, FA_4_84_carry;
    wire FA_4_85_sum, FA_4_85_carry, FA_4_86_sum, FA_4_86_carry, FA_4_87_sum, FA_4_87_carry;
    wire FA_4_88_sum, FA_4_88_carry, FA_4_89_sum, FA_4_89_carry, FA_4_90_sum, FA_4_90_carry;
    wire FA_4_91_sum, FA_4_91_carry, FA_4_92_sum, FA_4_92_carry, FA_4_93_sum, FA_4_93_carry;
    wire FA_4_94_sum, FA_4_94_carry, FA_4_95_sum, FA_4_95_carry, FA_4_96_sum, FA_4_96_carry;
    
    
    
        // Stage 5 wires
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
    wire FA_5_34_sum, FA_5_34_carry, FA_5_35_sum, FA_5_35_carry, FA_5_36_sum, FA_5_36_carry;
    wire FA_5_37_sum, FA_5_37_carry, FA_5_38_sum, FA_5_38_carry, FA_5_39_sum, FA_5_39_carry;
    wire FA_5_40_sum, FA_5_40_carry, FA_5_41_sum, FA_5_41_carry, FA_5_42_sum, FA_5_42_carry;
    wire FA_5_43_sum, FA_5_43_carry, FA_5_44_sum, FA_5_44_carry, FA_5_45_sum, FA_5_45_carry;
    wire FA_5_46_sum, FA_5_46_carry, FA_5_47_sum, FA_5_47_carry, FA_5_48_sum, FA_5_48_carry;
    wire FA_5_49_sum, FA_5_49_carry, FA_5_50_sum, FA_5_50_carry, FA_5_51_sum, FA_5_51_carry;
    wire FA_5_52_sum, FA_5_52_carry, FA_5_53_sum, FA_5_53_carry, FA_5_54_sum, FA_5_54_carry;
    wire FA_5_55_sum, FA_5_55_carry, FA_5_56_sum, FA_5_56_carry, FA_5_57_sum, FA_5_57_carry;
    wire FA_5_58_sum, FA_5_58_carry, FA_5_59_sum, FA_5_59_carry, FA_5_60_sum, FA_5_60_carry;
    wire FA_5_61_sum, FA_5_61_carry, FA_5_62_sum, FA_5_62_carry, FA_5_63_sum, FA_5_63_carry;
    
    
        // Stage 6 wires
    wire HA_6_1_sum, HA_6_1_carry;
    wire FA_6_1_sum, FA_6_1_carry, FA_6_2_sum, FA_6_2_carry, FA_6_3_sum, FA_6_3_carry;
    wire FA_6_4_sum, FA_6_4_carry, FA_6_5_sum, FA_6_5_carry, FA_6_6_sum, FA_6_6_carry;
    wire FA_6_7_sum, FA_6_7_carry, FA_6_8_sum, FA_6_8_carry, FA_6_9_sum, FA_6_9_carry;
    wire FA_6_10_sum, FA_6_10_carry, FA_6_11_sum, FA_6_11_carry, FA_6_12_sum, FA_6_12_carry;
    wire FA_6_13_sum, FA_6_13_carry, FA_6_14_sum, FA_6_14_carry, FA_6_15_sum, FA_6_15_carry;
    wire FA_6_16_sum, FA_6_16_carry, FA_6_17_sum, FA_6_17_carry, FA_6_18_sum, FA_6_18_carry;
    wire FA_6_19_sum, FA_6_19_carry, FA_6_20_sum, FA_6_20_carry, FA_6_21_sum, FA_6_21_carry;
    wire FA_6_22_sum, FA_6_22_carry, FA_6_23_sum, FA_6_23_carry, FA_6_24_sum, FA_6_24_carry;
    wire FA_6_25_sum, FA_6_25_carry, FA_6_26_sum, FA_6_26_carry, FA_6_27_sum, FA_6_27_carry;
    wire FA_6_28_sum, FA_6_28_carry, FA_6_29_sum, FA_6_29_carry, FA_6_30_sum, FA_6_30_carry;
    wire FA_6_31_sum, FA_6_31_carry, FA_6_32_sum, FA_6_32_carry, FA_6_33_sum, FA_6_33_carry;
    wire FA_6_34_sum, FA_6_34_carry, FA_6_35_sum, FA_6_35_carry, FA_6_36_sum, FA_6_36_carry;
    wire FA_6_37_sum, FA_6_37_carry, FA_6_38_sum, FA_6_38_carry, FA_6_39_sum, FA_6_39_carry;
    wire FA_6_40_sum, FA_6_40_carry, FA_6_41_sum, FA_6_41_carry, FA_6_42_sum, FA_6_42_carry;
    wire FA_6_43_sum, FA_6_43_carry, FA_6_44_sum, FA_6_44_carry, FA_6_45_sum, FA_6_45_carry;
    wire FA_6_46_sum, FA_6_46_carry, FA_6_47_sum, FA_6_47_carry, FA_6_48_sum, FA_6_48_carry;
    wire FA_6_49_sum, FA_6_49_carry, FA_6_50_sum, FA_6_50_carry, FA_6_51_sum, FA_6_51_carry;
    wire FA_6_52_sum, FA_6_52_carry, FA_6_53_sum, FA_6_53_carry, FA_6_54_sum, FA_6_54_carry;
    wire FA_6_55_sum, FA_6_55_carry, FA_6_56_sum, FA_6_56_carry, FA_6_57_sum, FA_6_57_carry;
    wire FA_6_58_sum, FA_6_58_carry, FA_6_59_sum, FA_6_59_carry, FA_6_60_sum, FA_6_60_carry;
    wire FA_6_61_sum, FA_6_61_carry, FA_6_62_sum, FA_6_62_carry, FA_6_63_sum, FA_6_63_carry;
    
    
    //Step-1
    HalfAdder HA1 (P1[4], P2[2], HA1_sum, HA1_carry);
    FullAdder FA1 (P1[5], P2[3], P3[1], FA1_sum, FA1_carry);
    FullAdder FA2 (P1[6], P2[4], P3[2], FA2_sum, FA2_carry);
    FullAdder FA3 (P1[7], P2[5], P3[3], FA3_sum,FA3_carry);
    FullAdder FA4 (P1[8], P2[6], P3[4], FA4_sum, FA4_carry);
    HalfAdder HA2 (P4[2], P5[0], HA2_sum, HA2_carry);
    FullAdder FA5 (P1[9], P2[7], P3[5], FA5_sum, FA5_carry);
    HalfAdder HA3 (P4[3], P5[1], HA3_sum, HA3_carry);

    
    FullAdder FA6 (P1[10], P2[8], P3[6], FA6_sum, FA6_carry);
    FullAdder FA7 (P4[4], P5[2], P6[0], FA7_sum, FA7_carry);

    FullAdder FA8 (P1[11], P2[9], P3[7], FA8_sum, FA8_carry);
    FullAdder FA9 (P4[5], P5[3], P6[1], FA9_sum, FA9_carry);

    FullAdder FA10 (P1[12], P2[10], P3[8], FA10_sum, FA10_carry);
    FullAdder FA11 (P4[6], P5[4], P6[2], FA11_sum, FA11_carry);
    
    FullAdder FA12 (P1[13], P2[11], P3[9], FA12_sum, FA12_carry);
    FullAdder FA13 (P4[7], P5[5], P6[3], FA13_sum, FA13_carry);

    FullAdder FA14 (P1[14], P2[12], P3[10], FA14_sum, FA14_carry);
    FullAdder FA15 (P4[8], P5[6], P6[4], FA15_sum, FA15_carry);
    HalfAdder HA4 (P7[2], P8[0], HA4_sum, HA4_carry);

    FullAdder FA16 (P1[15], P2[13], P3[11], FA16_sum, FA16_carry);
    FullAdder FA17 (P4[9], P5[7], P6[5], FA17_sum, FA17_carry);
    HalfAdder HA5 (P7[3], P8[1], HA5_sum, HA5_carry);

    FullAdder FA18 (P1[16], P2[14], P3[12], FA18_sum, FA18_carry);
    FullAdder FA19 (P4[10], P5[8], P6[6], FA19_sum, FA19_carry);
    FullAdder FA20 (P7[4], P8[2], P9[0], FA20_sum, FA20_carry);

    FullAdder FA21 (P1[17], P2[15], P3[13], FA21_sum, FA21_carry);
    FullAdder FA22 (P4[11], P5[9], P6[7], FA22_sum, FA22_carry);
    FullAdder FA23 (P7[5], P8[3], P9[1], FA23_sum, FA23_carry);

    FullAdder FA24 (P1[18], P2[16], P3[14], FA24_sum, FA24_carry);
    FullAdder FA25 (P4[12], P5[10], P6[8], FA25_sum, FA25_carry);
    FullAdder FA26 (P7[6], P8[4], P9[2], FA26_sum, FA26_carry);

    FullAdder FA27 (P1[19], P2[17], P3[15], FA27_sum, FA27_carry);
    FullAdder FA28 (P4[13], P5[11], P6[9], FA28_sum, FA28_carry);
    FullAdder FA29 (P7[7], P8[5], P9[3], FA29_sum, FA29_carry);

    FullAdder FA30 (P1[20], P2[18], P3[16], FA30_sum, FA30_carry);
    FullAdder FA31 (P4[14], P5[12], P6[10], FA31_sum, FA31_carry);
    FullAdder FA32 (P7[8], P8[6], P9[4], FA32_sum, FA32_carry);
    HalfAdder HA6 (P10[2], P11[0], HA6_sum, HA6_carry);

    FullAdder FA33 (P1[21], P2[19], P3[17], FA33_sum, FA33_carry);
    FullAdder FA34 (P4[15], P5[13], P6[11], FA34_sum, FA34_carry);
    FullAdder FA35 (P7[9], P8[7], P9[5], FA35_sum, FA35_carry);
    HalfAdder HA7 (P10[3], P11[1], HA7_sum, HA7_carry);

    FullAdder FA36 (P1[22], P2[20], P3[18], FA36_sum, FA36_carry);
    FullAdder FA37 (P4[16], P5[14], P6[12], FA37_sum, FA37_carry);
    FullAdder FA38 (P7[10], P8[8], P9[6], FA38_sum, FA38_carry);
    FullAdder FA39 (P10[4], P11[2], P12[0], FA39_sum, FA39_carry);


    FullAdder FA40 (P1[23], P2[21], P3[19], FA40_sum, FA40_carry);
    FullAdder FA41 (P4[17], P5[15], P6[13], FA41_sum, FA41_carry);
    FullAdder FA42 (P7[11], P8[9], P9[7], FA42_sum, FA42_carry);
    FullAdder FA43 (P10[5], P11[3], P12[1], FA43_sum, FA43_carry);
    
    
    FullAdder FA44 (P1[24], P2[22], P3[20], FA44_sum, FA44_carry);
    FullAdder FA45 (P4[18], P5[16], P6[14], FA45_sum, FA45_carry);
    FullAdder FA46 (P7[12], P8[10], P9[8], FA46_sum, FA46_carry);
    FullAdder FA47 (P10[6], P11[4], P12[2], FA47_sum, FA47_carry);

    FullAdder FA48 (P1[25], P2[23], P3[21], FA48_sum, FA48_carry);
    FullAdder FA49 (P4[19], P5[17], P6[15], FA49_sum, FA49_carry);
    FullAdder FA50 (P7[13], P8[11], P9[9], FA50_sum, FA50_carry);
    FullAdder FA51 (P10[7], P11[5], P12[3], FA51_sum, FA51_carry);

    FullAdder FA52 (P1[26], P2[24], P3[22], FA52_sum, FA52_carry);
    FullAdder FA53 (P4[20], P5[18], P6[16], FA53_sum, FA53_carry);
    FullAdder FA54 (P7[14], P8[12], P9[10], FA54_sum, FA54_carry);
    FullAdder FA55 (P10[8], P11[6], P12[4], FA55_sum, FA55_carry);
    HalfAdder HA8 (P13[2], P14[0], HA8_sum, HA8_carry);
    

    FullAdder FA56 (P1[27], P2[25], P3[23], FA56_sum, FA56_carry);
    FullAdder FA57 (P4[21], P5[19], P6[17], FA57_sum, FA57_carry);
    FullAdder FA58 (P7[15], P8[13], P9[11], FA58_sum, FA58_carry);
    FullAdder FA59 (P10[9], P11[7], P12[5], FA59_sum, FA59_carry);
    HalfAdder HA9 (P13[3], P14[1], HA9_sum, HA9_carry);


    FullAdder FA60 (P1[28], P2[26], P3[24], FA60_sum, FA60_carry);
    FullAdder FA61 (P4[22], P5[20], P6[18], FA61_sum, FA61_carry);
    FullAdder FA62 (P7[16], P8[14], P9[12], FA62_sum, FA62_carry);
    FullAdder FA63 (P10[10], P11[8], P12[6], FA63_sum, FA63_carry);
    FullAdder FA64 (P13[4], P14[2], P15[0], FA64_sum, FA64_carry);


    FullAdder FA65 (P1[29], P2[27], P3[25], FA65_sum, FA65_carry);
    FullAdder FA66 (P4[23], P5[21], P6[19], FA66_sum, FA66_carry);
    FullAdder FA67 (P7[17], P8[15], P9[13], FA67_sum, FA67_carry);
    FullAdder FA68 (P10[11], P11[9], P12[7], FA68_sum, FA68_carry);    
    FullAdder FA69 (P13[5], P14[3], P15[1], FA69_sum, FA69_carry);
    
    
    FullAdder FA70 (P1[30], P2[28], P3[26], FA70_sum, FA70_carry);
    FullAdder FA71 (P4[24], P5[22], P6[20], FA71_sum, FA71_carry);
    FullAdder FA72 (P7[18], P8[16], P9[14], FA72_sum, FA72_carry);
    FullAdder FA73 (P10[12], P11[10], P12[8], FA73_sum, FA73_carry);
    FullAdder FA74 (P13[6], P14[4], P15[2], FA74_sum, FA74_carry);


    FullAdder FA75 (P1[31], P2[29], P3[27], FA75_sum, FA75_carry);
    FullAdder FA76 (P4[25], P5[23], P6[21], FA76_sum, FA76_carry);
    FullAdder FA77 (P7[19], P8[17], P9[15], FA77_sum, FA77_carry);
    FullAdder FA78 (P10[13], P11[11], P12[9], FA78_sum, FA78_carry);
    FullAdder FA79 (P13[7], P14[5], P15[3], FA79_sum, FA79_carry);
    
    FullAdder FA80 (P1[32], P2[30], P3[28], FA80_sum, FA80_carry);
    FullAdder FA81 (P4[26], P5[24], P6[22], FA81_sum, FA81_carry);
    FullAdder FA82 (P7[20], P8[18], P9[16], FA82_sum, FA82_carry);
    FullAdder FA83 (P10[14], P11[12], P12[10], FA83_sum, FA83_carry);
    FullAdder FA84 (P13[8], P14[6], P15[4], FA84_sum, FA84_carry);
    
    FullAdder FA85 (P1[33], P2[31], P3[29], FA85_sum, FA85_carry);
    FullAdder FA86 (P4[27], P5[25], P6[23], FA86_sum, FA86_carry);
    FullAdder FA87 (P7[21], P8[19], P9[17], FA87_sum, FA87_carry);
    FullAdder FA88 (P10[15], P11[13], P12[11], FA88_sum, FA88_carry);
    FullAdder FA89 (P13[9], P14[7], P15[5], FA89_sum, FA89_carry);
    
    FullAdder FA90 (P1[34], P2[32], P3[30], FA90_sum, FA90_carry);
    FullAdder FA91 (P4[28], P5[26], P6[24], FA91_sum, FA91_carry);
    FullAdder FA92 (P7[22], P8[20], P9[18], FA92_sum, FA92_carry);
    FullAdder FA93 (P10[16], P11[14], P12[12], FA93_sum, FA93_carry);
    FullAdder FA94 (P13[10], P14[8], P15[6], FA94_sum, FA94_carry);
    
    FullAdder FA95 (P1[35], P2[33], P3[31], FA95_sum, FA95_carry);
    FullAdder FA96 (P4[29], P5[27], P6[25], FA96_sum, FA96_carry);
    FullAdder FA97 (P7[23], P8[21], P9[19], FA97_sum, FA97_carry);
    FullAdder FA98 (P10[17], P11[15], P12[13], FA98_sum, FA98_carry);
    FullAdder FA99 (P13[11], P14[9], P15[7], FA99_sum, FA99_carry);
    
    FullAdder FA100 (P1[36], P2[34], P3[32], FA100_sum, FA100_carry);
    FullAdder FA101 (P4[30], P5[28], P6[26], FA101_sum, FA101_carry);
    FullAdder FA102 (P7[24], P8[22], P9[20], FA102_sum, FA102_carry);
    FullAdder FA103 (P10[18], P11[16], P12[14], FA103_sum, FA103_carry);
    FullAdder FA104 (P13[12], P14[10], P15[8], FA104_sum, FA104_carry);
    
    FullAdder FA105 (P1[37], P2[35], P3[33], FA105_sum, FA105_carry);
    FullAdder FA106 (P4[31], P5[29], P6[27], FA106_sum, FA106_carry);
    FullAdder FA107 (P7[25], P8[23], P9[21], FA107_sum, FA107_carry);
    FullAdder FA108 (P10[19], P11[17], P12[15], FA108_sum, FA108_carry);
    FullAdder FA109 (P13[13], P14[11], P15[9], FA109_sum, FA109_carry);
    
    FullAdder FA110 (P1[38], P2[36], P3[34], FA110_sum, FA110_carry);
    FullAdder FA111 (P4[32], P5[30], P6[28], FA111_sum, FA111_carry);
    FullAdder FA112 (P7[26], P8[24], P9[22], FA112_sum, FA112_carry);
    FullAdder FA113 (P10[20], P11[18], P12[16], FA113_sum, FA113_carry);
    FullAdder FA114 (P13[14], P14[12], P15[10], FA114_sum, FA114_carry);
    
    FullAdder FA115 (P1[39], P2[37], P3[35], FA115_sum, FA115_carry);
    FullAdder FA116 (P4[33], P5[31], P6[29], FA116_sum, FA116_carry);
    FullAdder FA117 (P7[27], P8[25], P9[23], FA117_sum, FA117_carry);
    FullAdder FA118 (P10[21], P11[19], P12[17], FA118_sum, FA118_carry);
    FullAdder FA119 (P13[15], P14[13], P15[11], FA119_sum, FA119_carry);
    
    FullAdder FA120 (P1[40], P2[38], P3[36], FA120_sum, FA120_carry);
    FullAdder FA121 (P4[34], P5[32], P6[30], FA121_sum, FA121_carry);
    FullAdder FA122 (P7[28], P8[26], P9[24], FA122_sum, FA122_carry);
    FullAdder FA123 (P10[22], P11[20], P12[18], FA123_sum, FA123_carry);
    FullAdder FA124 (P13[16], P14[14], P15[12], FA124_sum, FA124_carry);
    
    FullAdder FA125 (P1[41], P2[39], P3[37], FA125_sum, FA125_carry);
    FullAdder FA126 (P4[35], P5[33], P6[31], FA126_sum, FA126_carry);
    FullAdder FA127 (P7[29], P8[27], P9[25], FA127_sum, FA127_carry);
    FullAdder FA128 (P10[23], P11[21], P12[19], FA128_sum, FA128_carry);
    FullAdder FA129 (P13[17], P14[15], P15[13], FA129_sum, FA129_carry);
    
    FullAdder FA130 (P1[42], P2[40], P3[38], FA130_sum, FA130_carry);
    FullAdder FA131 (P4[36], P5[34], P6[32], FA131_sum, FA131_carry);
    FullAdder FA132 (P7[30], P8[28], P9[26], FA132_sum, FA132_carry);
    FullAdder FA133 (P10[24], P11[22], P12[20], FA133_sum, FA133_carry);
    FullAdder FA134 (P13[18], P14[16], P15[14], FA134_sum, FA134_carry);
    
    FullAdder FA135 (P1[43], P2[41], P3[39], FA135_sum, FA135_carry);
    FullAdder FA136 (P4[37], P5[35], P6[33], FA136_sum, FA136_carry);
    FullAdder FA137 (P7[31], P8[29], P9[27], FA137_sum, FA137_carry);
    FullAdder FA138 (P10[25], P11[23], P12[21], FA138_sum, FA138_carry);
    FullAdder FA139 (P13[19], P14[17], P15[15], FA139_sum, FA139_carry);
    
    FullAdder FA140 (P1[44], P2[42], P3[40], FA140_sum, FA140_carry);
    FullAdder FA141 (P4[38], P5[36], P6[34], FA141_sum, FA141_carry);
    FullAdder FA142 (P7[32], P8[30], P9[28], FA142_sum, FA142_carry);
    FullAdder FA143 (P10[26], P11[24], P12[22], FA143_sum, FA143_carry);
    FullAdder FA144 (P13[20], P14[18], P15[16], FA144_sum, FA144_carry);
    
    FullAdder FA145 (P1[45], P2[43], P3[41], FA145_sum, FA145_carry);
    FullAdder FA146 (P4[39], P5[37], P6[35], FA146_sum, FA146_carry);
    FullAdder FA147 (P7[33], P8[31], P9[29], FA147_sum, FA147_carry);
    FullAdder FA148 (P10[27], P11[25], P12[23], FA148_sum, FA148_carry);
    FullAdder FA149 (P13[21], P14[19], P15[17], FA149_sum, FA149_carry);
    
    FullAdder FA150 (P1[46], P2[44], P3[42], FA150_sum, FA150_carry);
    FullAdder FA151 (P4[40], P5[38], P6[36], FA151_sum, FA151_carry);
    FullAdder FA152 (P7[34], P8[32], P9[30], FA152_sum, FA152_carry);
    FullAdder FA153 (P10[28], P11[26], P12[24], FA153_sum, FA153_carry);
    FullAdder FA154 (P13[22], P14[20], P15[18], FA154_sum, FA154_carry);
    
    FullAdder FA155 (P1[47], P2[45], P3[43], FA155_sum, FA155_carry);
    FullAdder FA156 (P4[41], P5[39], P6[37], FA156_sum, FA156_carry);
    FullAdder FA157 (P7[35], P8[33], P9[31], FA157_sum, FA157_carry);
    FullAdder FA158 (P10[29], P11[27], P12[25], FA158_sum, FA158_carry);
    FullAdder FA159 (P13[23], P14[21], P15[19], FA159_sum, FA159_carry);
    
    FullAdder FA160 (P1[48], P2[46], P3[44], FA160_sum, FA160_carry);
    FullAdder FA161 (P4[42], P5[40], P6[38], FA161_sum, FA161_carry);
    FullAdder FA162 (P7[36], P8[34], P9[32], FA162_sum, FA162_carry);
    FullAdder FA163 (P10[30], P11[28], P12[26], FA163_sum, FA163_carry);
    FullAdder FA164 (P13[24], P14[22], P15[20], FA164_sum, FA164_carry);
    
    FullAdder FA165 (P1[49], P2[47], P3[45], FA165_sum, FA165_carry);
    FullAdder FA166 (P4[43], P5[41], P6[39], FA166_sum, FA166_carry);
    FullAdder FA167 (P7[37], P8[35], P9[33], FA167_sum, FA167_carry);
    FullAdder FA168 (P10[31], P11[29], P12[27], FA168_sum, FA168_carry);
    FullAdder FA169 (P13[25], P14[23], P15[21], FA169_sum, FA169_carry);
    
    FullAdder FA170 (P1[50], P2[48], P3[46], FA170_sum, FA170_carry);
    FullAdder FA171 (P4[44], P5[42], P6[40], FA171_sum, FA171_carry);
    FullAdder FA172 (P7[38], P8[36], P9[34], FA172_sum, FA172_carry);
    FullAdder FA173 (P10[32], P11[30], P12[28], FA173_sum, FA173_carry);
    FullAdder FA174 (P13[26], P14[24], P15[22], FA174_sum, FA174_carry);
    
    FullAdder FA175 (P1[51], P2[49], P3[47], FA175_sum, FA175_carry);
    FullAdder FA176 (P4[45], P5[43], P6[41], FA176_sum, FA176_carry);
    FullAdder FA177 (P7[39], P8[37], P9[35], FA177_sum, FA177_carry);
    FullAdder FA178 (P10[33], P11[31], P12[29], FA178_sum, FA178_carry);
    FullAdder FA179 (P13[27], P14[25], P15[23], FA179_sum, FA179_carry);
    
    FullAdder FA180 (P1[52], P2[50], P3[48], FA180_sum, FA180_carry);
    FullAdder FA181 (P4[46], P5[44], P6[42], FA181_sum, FA181_carry);
    FullAdder FA182 (P7[40], P8[38], P9[36], FA182_sum, FA182_carry);
    FullAdder FA183 (P10[34], P11[32], P12[30], FA183_sum, FA183_carry);
    FullAdder FA184 (P13[28], P14[26], P15[24], FA184_sum, FA184_carry);
    
    FullAdder FA185 (P1[53], P2[51], P3[49], FA185_sum, FA185_carry);
    FullAdder FA186 (P4[47], P5[45], P6[43], FA186_sum, FA186_carry);
    FullAdder FA187 (P7[41], P8[39], P9[37], FA187_sum, FA187_carry);
    FullAdder FA188 (P10[35], P11[33], P12[31], FA188_sum, FA188_carry);
    FullAdder FA189 (P13[29], P14[27], P15[25], FA189_sum, FA189_carry);
    
    FullAdder FA190 (P1[54], P2[52], P3[50], FA190_sum, FA190_carry);
    FullAdder FA191 (P4[48], P5[46], P6[44], FA191_sum, FA191_carry);
    FullAdder FA192 (P7[42], P8[40], P9[38], FA192_sum, FA192_carry);
    FullAdder FA193 (P10[36], P11[34], P12[32], FA193_sum, FA193_carry);
    FullAdder FA194 (P13[30], P14[28], P15[26], FA194_sum, FA194_carry);
    
    FullAdder FA195 (P1[55], P2[53], P3[51], FA195_sum, FA195_carry);
    FullAdder FA196 (P4[49], P5[47], P6[45], FA196_sum, FA196_carry);
    FullAdder FA197 (P7[43], P8[41], P9[39], FA197_sum, FA197_carry);
    FullAdder FA198 (P10[37], P11[35], P12[33], FA198_sum, FA198_carry);
    FullAdder FA199 (P13[31], P14[29], P15[27], FA199_sum, FA199_carry);
    
    FullAdder FA200 (P1[56], P2[54], P3[52], FA200_sum, FA200_carry);
    FullAdder FA201 (P4[50], P5[48], P6[46], FA201_sum, FA201_carry);
    FullAdder FA202 (P7[44], P8[42], P9[40], FA202_sum, FA202_carry);
    FullAdder FA203 (P10[38], P11[36], P12[34], FA203_sum, FA203_carry);
    FullAdder FA204 (P13[32], P14[30], P15[28], FA204_sum, FA204_carry);
    
    FullAdder FA205 (P1[57], P2[55], P3[53], FA205_sum, FA205_carry);
    FullAdder FA206 (P4[51], P5[49], P6[47], FA206_sum, FA206_carry);
    FullAdder FA207 (P7[45], P8[43], P9[41], FA207_sum, FA207_carry);
    FullAdder FA208 (P10[39], P11[37], P12[35], FA208_sum, FA208_carry);
    FullAdder FA209 (P13[33], P14[31], P15[29], FA209_sum, FA209_carry);
    
    FullAdder FA210 (P1[58], P2[56], P3[54], FA210_sum, FA210_carry);
    FullAdder FA211 (P4[52], P5[50], P6[48], FA211_sum, FA211_carry);
    FullAdder FA212 (P7[46], P8[44], P9[42], FA212_sum, FA212_carry);
    FullAdder FA213 (P10[40], P11[38], P12[36], FA213_sum, FA213_carry);
    FullAdder FA214 (P13[34], P14[32], P15[30], FA214_sum, FA214_carry);
    
    FullAdder FA215 (P1[59], P2[57], P3[55], FA215_sum, FA215_carry);
    FullAdder FA216 (P4[53], P5[51], P6[49], FA216_sum, FA216_carry);
    FullAdder FA217 (P7[47], P8[45], P9[43], FA217_sum, FA217_carry);
    FullAdder FA218 (P10[41], P11[39], P12[37], FA218_sum, FA218_carry);
    FullAdder FA219 (P13[35], P14[33], P15[31], FA219_sum, FA219_carry);
    
    FullAdder FA220 (P1[60], P2[58], P3[56], FA220_sum, FA220_carry);
    FullAdder FA221 (P4[54], P5[52], P6[50], FA221_sum, FA221_carry);
    FullAdder FA222 (P7[48], P8[46], P9[44], FA222_sum, FA222_carry);
    FullAdder FA223 (P10[42], P11[40], P12[38], FA223_sum, FA223_carry);
    FullAdder FA224 (P13[36], P14[34], P15[32], FA224_sum, FA224_carry);
    
    FullAdder FA225 (P1[61], P2[59], P3[57], FA225_sum, FA225_carry);
    FullAdder FA226 (P4[55], P5[53], P6[51], FA226_sum, FA226_carry);
    FullAdder FA227 (P7[49], P8[47], P9[45], FA227_sum, FA227_carry);
    FullAdder FA228 (P10[43], P11[41], P12[39], FA228_sum, FA228_carry);
    FullAdder FA229 (P13[37], P14[35], P15[33], FA229_sum, FA229_carry);
    
    FullAdder FA230 (P1[62], P2[60], P3[58], FA230_sum, FA230_carry);
    FullAdder FA231 (P4[56], P5[54], P6[52], FA231_sum, FA231_carry);
    FullAdder FA232 (P7[50], P8[48], P9[46], FA232_sum, FA232_carry);
    FullAdder FA233 (P10[44], P11[42], P12[40], FA233_sum, FA233_carry);
    FullAdder FA234 (P13[38], P14[36], P15[34], FA234_sum, FA234_carry);
    
    FullAdder FA235 (P1[63], P2[61], P3[59], FA235_sum, FA235_carry);
    FullAdder FA236 (P4[57], P5[55], P6[53], FA236_sum, FA236_carry);
    FullAdder FA237 (P7[51], P8[49], P9[47], FA237_sum, FA237_carry);
    FullAdder FA238 (P10[45], P11[43], P12[41], FA238_sum, FA238_carry);
    FullAdder FA239 (P13[39], P14[37], P15[35], FA239_sum, FA239_carry);    



// stage- 2 

    HalfAdder HA_2_1 (FA2_sum, FA1_carry, HA_2_1_sum, HA_2_1_carry);
    FullAdder FA_2_1 (FA3_sum, FA2_carry , P4[1], FA_2_1_sum, FA_2_1_carry);
    FullAdder FA_2_2 (FA4_sum, FA3_carry , HA2_sum, FA_2_2_sum, FA_2_2_carry);
    FullAdder FA_2_3 (FA5_sum, FA4_carry , HA3_sum, FA_2_3_sum, FA_2_3_carry);
    FullAdder FA_2_4 (FA6_sum, FA5_carry , FA7_sum , FA_2_4_sum, FA_2_4_carry);
    FullAdder FA_2_5 (FA8_sum, FA6_carry , FA9_sum, FA_2_5_sum, FA_2_5_carry);
    
    FullAdder FA_2_6 (FA10_sum, FA11_sum , FA8_carry, FA_2_6_sum, FA_2_6_carry);
    HalfAdder HA_2_2 (FA9_carry, P7[0], HA_2_2_sum, HA_2_2_carry);
    
    FullAdder FA_2_7 (FA12_sum, FA13_sum , FA10_carry, FA_2_7_sum, FA_2_7_carry);
    HalfAdder HA_2_3 (FA11_carry, P7[1], HA_2_3_sum, HA_2_3_carry);
    
    FullAdder FA_2_8 (FA14_sum, FA15_sum , HA4_sum, FA_2_8_sum, FA_2_8_carry);
    HalfAdder HA_2_4 (FA12_carry, FA13_carry, HA_2_4_sum, HA_2_4_carry);

    FullAdder FA_2_9 (FA16_sum, FA17_sum , HA5_sum, FA_2_9_sum, FA_2_9_carry);
    FullAdder FA_2_10 (FA14_carry, FA15_carry , HA4_carry, FA_2_10_sum, FA_2_10_carry);

    FullAdder FA_2_11 (FA18_sum, FA19_sum , FA20_sum, FA_2_11_sum, FA_2_11_carry);
    FullAdder FA_2_12 (FA16_carry, FA17_carry , HA5_carry, FA_2_12_sum, FA_2_12_carry);
    
    FullAdder FA_2_13 (FA21_sum, FA22_sum , FA23_sum, FA_2_13_sum, FA_2_13_carry);
    FullAdder FA_2_14 (FA18_carry, FA19_carry , FA20_carry, FA_2_14_sum, FA_2_14_carry);

    FullAdder FA_2_15 (FA24_sum, FA25_sum , FA26_sum, FA_2_15_sum, FA_2_15_carry);
    FullAdder FA_2_16 (P10[0], FA21_carry , FA22_carry, FA_2_16_sum, FA_2_16_carry);

    FullAdder FA_2_17 (FA27_sum, FA28_sum , FA29_sum, FA_2_17_sum, FA_2_17_carry);
    FullAdder FA_2_18 (P10[1], FA24_carry , FA25_carry, FA_2_18_sum, FA_2_18_carry);

    FullAdder FA_2_19 (FA30_sum, FA31_sum , FA32_sum, FA_2_19_sum, FA_2_19_carry);
    FullAdder FA_2_20 (HA6_sum, FA27_carry , FA28_carry, FA_2_20_sum, FA_2_20_carry);

    FullAdder FA_2_21 (FA33_sum, FA34_sum , FA35_sum, FA_2_21_sum, FA_2_21_carry);
    FullAdder FA_2_22 (HA7_sum, FA30_carry , FA31_carry, FA_2_22_sum, FA_2_22_carry);
    HalfAdder HA_2_5 (FA32_carry, HA6_carry, HA_2_5_sum, HA_2_5_carry);

    FullAdder FA_2_23 (FA36_sum, FA37_sum , FA38_sum, FA_2_23_sum, FA_2_23_carry);
    FullAdder FA_2_24 (FA39_sum, FA33_carry , FA34_carry, FA_2_24_sum, FA_2_24_carry);
    HalfAdder HA_2_6 (FA35_carry, HA7_carry, HA_2_6_sum, HA_2_6_carry);

    FullAdder FA_2_25 (FA40_sum, FA41_sum , FA42_sum, FA_2_25_sum, FA_2_25_carry);
    FullAdder FA_2_26 (FA43_sum, FA36_carry , FA37_carry, FA_2_26_sum, FA_2_26_carry);
    HalfAdder HA_2_7 (FA38_carry, FA39_carry, HA_2_7_sum, HA_2_7_carry);

    FullAdder FA_2_27 (FA44_sum, FA45_sum , FA46_sum, FA_2_27_sum, FA_2_27_carry);
    FullAdder FA_2_28 (FA47_sum, P13[0] , FA40_carry, FA_2_28_sum, FA_2_28_carry);
    FullAdder FA_2_29 (FA41_carry, FA42_carry , FA43_carry, FA_2_29_sum, FA_2_29_carry);


    FullAdder FA_2_30 (FA48_sum, FA49_sum , FA50_sum, FA_2_30_sum, FA_2_30_carry);
    FullAdder FA_2_31 (FA51_sum, P13[1] , FA44_carry, FA_2_31_sum, FA_2_31_carry);
    FullAdder FA_2_32 (FA45_carry, FA46_carry , FA47_carry, FA_2_32_sum, FA_2_32_carry);


    FullAdder FA_2_33 (FA52_sum, FA53_sum , FA54_sum, FA_2_33_sum, FA_2_33_carry);
    FullAdder FA_2_34 (FA55_sum, HA8_sum , FA48_carry, FA_2_34_sum, FA_2_34_carry);
    FullAdder FA_2_35 (FA49_carry, FA50_carry , FA51_carry, FA_2_35_sum, FA_2_35_carry);

    FullAdder FA_2_36 (FA56_sum, FA57_sum , FA58_sum, FA_2_36_sum, FA_2_36_carry);
    FullAdder FA_2_37 (FA59_sum, HA9_sum , FA52_carry, FA_2_37_sum, FA_2_37_carry);
    FullAdder FA_2_38 (FA53_carry, FA54_carry , FA55_carry, FA_2_38_sum, FA_2_38_carry);
 
 
    FullAdder FA_2_39 (FA60_sum, FA61_sum , FA62_sum, FA_2_39_sum, FA_2_39_carry);
    FullAdder FA_2_40 (FA63_sum, FA64_sum , FA56_carry, FA_2_40_sum, FA_2_40_carry);
    FullAdder FA_2_41 (FA57_carry, FA58_carry , FA59_carry, FA_2_41_sum, FA_2_41_carry);
 
 
    FullAdder FA_2_42 (FA65_sum, FA66_sum , FA67_sum, FA_2_42_sum, FA_2_42_carry);
    FullAdder FA_2_43 (FA68_sum, FA69_sum , FA60_carry, FA_2_43_sum, FA_2_43_carry);
    FullAdder FA_2_44 (FA61_carry, FA62_carry , FA63_carry, FA_2_44_sum, FA_2_44_carry);
    
    
    FullAdder FA_2_45 (FA70_sum, FA71_sum , FA72_sum, FA_2_45_sum, FA_2_45_carry);
    FullAdder FA_2_46 (FA73_sum, FA74_sum , P16[0], FA_2_46_sum, FA_2_46_carry);
    FullAdder FA_2_47 (FA65_carry, FA66_carry , FA67_carry, FA_2_47_sum, FA_2_47_carry);  
    HalfAdder HA_2_8 (FA68_carry, FA69_carry, HA_2_8_sum, HA_2_8_carry);
  
 
    FullAdder FA_2_48 (FA75_sum, FA76_sum , FA77_sum, FA_2_48_sum, FA_2_48_carry);
    FullAdder FA_2_49 (FA78_sum, FA79_sum , P16[1], FA_2_49_sum, FA_2_49_carry);
    FullAdder FA_2_50 (FA70_carry, FA71_carry , FA72_carry, FA_2_50_sum, FA_2_50_carry);  
    HalfAdder HA_2_9 (FA73_carry, FA74_carry, HA_2_9_sum, HA_2_9_carry);
    
        
        /* Group 3 */
    FullAdder FA_2_51 (FA80_sum, FA81_sum, FA82_sum, FA_2_51_sum, FA_2_51_carry);
    FullAdder FA_2_52 (FA83_sum, FA84_sum, P16[2], FA_2_52_sum, FA_2_52_carry);
    FullAdder FA_2_53 (FA75_carry, FA76_carry, FA77_carry, FA_2_53_sum, FA_2_53_carry);
    HalfAdder HA_2_10 (FA78_carry, FA79_carry, HA_2_10_sum, HA_2_10_carry);
    
    /* Group 4 */
    FullAdder FA_2_54 (FA85_sum, FA86_sum, FA87_sum, FA_2_54_sum, FA_2_54_carry);
    FullAdder FA_2_55 (FA88_sum, FA89_sum, P16[3], FA_2_55_sum, FA_2_55_carry);
    FullAdder FA_2_56 (FA80_carry, FA81_carry, FA82_carry, FA_2_56_sum, FA_2_56_carry);
    HalfAdder HA_2_11 (FA83_carry, FA84_carry, HA_2_11_sum, HA_2_11_carry);
    
    /* Group 5 */
    FullAdder FA_2_57 (FA90_sum, FA91_sum, FA92_sum, FA_2_57_sum, FA_2_57_carry);
    FullAdder FA_2_58 (FA93_sum, FA94_sum, P16[4], FA_2_58_sum, FA_2_58_carry);
    FullAdder FA_2_59 (FA85_carry, FA86_carry, FA87_carry, FA_2_59_sum, FA_2_59_carry);
    HalfAdder HA_2_12 (FA88_carry, FA89_carry, HA_2_12_sum, HA_2_12_carry);
    
    /* Group 6 */
    FullAdder FA_2_60 (FA95_sum, FA96_sum, FA97_sum, FA_2_60_sum, FA_2_60_carry);
    FullAdder FA_2_61 (FA98_sum, FA99_sum, P16[5], FA_2_61_sum, FA_2_61_carry);
    FullAdder FA_2_62 (FA90_carry, FA91_carry, FA92_carry, FA_2_62_sum, FA_2_62_carry);
    HalfAdder HA_2_13 (FA93_carry, FA94_carry, HA_2_13_sum, HA_2_13_carry);
    
    /* Group 7 */
    FullAdder FA_2_63 (FA100_sum, FA101_sum, FA102_sum, FA_2_63_sum, FA_2_63_carry);
    FullAdder FA_2_64 (FA103_sum, FA104_sum, P16[6], FA_2_64_sum, FA_2_64_carry);
    FullAdder FA_2_65 (FA95_carry, FA96_carry, FA97_carry, FA_2_65_sum, FA_2_65_carry);
    HalfAdder HA_2_14 (FA98_carry, FA99_carry, HA_2_14_sum, HA_2_14_carry);
    
    /* Group 8 */
    FullAdder FA_2_66 (FA105_sum, FA106_sum, FA107_sum, FA_2_66_sum, FA_2_66_carry);
    FullAdder FA_2_67 (FA108_sum, FA109_sum, P16[7], FA_2_67_sum, FA_2_67_carry);
    FullAdder FA_2_68 (FA100_carry, FA101_carry, FA102_carry, FA_2_68_sum, FA_2_68_carry);
    HalfAdder HA_2_15 (FA103_carry, FA104_carry, HA_2_15_sum, HA_2_15_carry);
    
    /* Group 9 */
    FullAdder FA_2_69 (FA110_sum, FA111_sum, FA112_sum, FA_2_69_sum, FA_2_69_carry);
    FullAdder FA_2_70 (FA113_sum, FA114_sum, P16[8], FA_2_70_sum, FA_2_70_carry);
    FullAdder FA_2_71 (FA105_carry, FA106_carry, FA107_carry, FA_2_71_sum, FA_2_71_carry);
    HalfAdder HA_2_16 (FA108_carry, FA109_carry, HA_2_16_sum, HA_2_16_carry);
    
    /* Group 10 */
    FullAdder FA_2_72 (FA115_sum, FA116_sum, FA117_sum, FA_2_72_sum, FA_2_72_carry);
    FullAdder FA_2_73 (FA118_sum, FA119_sum, P16[9], FA_2_73_sum, FA_2_73_carry);
    FullAdder FA_2_74 (FA110_carry, FA111_carry, FA112_carry, FA_2_74_sum, FA_2_74_carry);
    HalfAdder HA_2_17 (FA113_carry, FA114_carry, HA_2_17_sum, HA_2_17_carry);
    
    /* Group 11 */
    FullAdder FA_2_75 (FA120_sum, FA121_sum, FA122_sum, FA_2_75_sum, FA_2_75_carry);
    FullAdder FA_2_76 (FA123_sum, FA124_sum, P16[10], FA_2_76_sum, FA_2_76_carry);
    FullAdder FA_2_77 (FA115_carry, FA116_carry, FA117_carry, FA_2_77_sum, FA_2_77_carry);
    HalfAdder HA_2_18 (FA118_carry, FA119_carry, HA_2_18_sum, HA_2_18_carry);
    
    /* Group 12 */
    FullAdder FA_2_78 (FA125_sum, FA126_sum, FA127_sum, FA_2_78_sum, FA_2_78_carry);
    FullAdder FA_2_79 (FA128_sum, FA129_sum, P16[11], FA_2_79_sum, FA_2_79_carry);
    FullAdder FA_2_80 (FA120_carry, FA121_carry, FA122_carry, FA_2_80_sum, FA_2_80_carry);
    HalfAdder HA_2_19 (FA123_carry, FA124_carry, HA_2_19_sum, HA_2_19_carry);
    
    /* Group 13 */
    FullAdder FA_2_81 (FA130_sum, FA131_sum, FA132_sum, FA_2_81_sum, FA_2_81_carry);
    FullAdder FA_2_82 (FA133_sum, FA134_sum, P16[12], FA_2_82_sum, FA_2_82_carry);
    FullAdder FA_2_83 (FA125_carry, FA126_carry, FA127_carry, FA_2_83_sum, FA_2_83_carry);
    HalfAdder HA_2_20 (FA128_carry, FA129_carry, HA_2_20_sum, HA_2_20_carry);
    
    /* Group 14 */
    FullAdder FA_2_84 (FA135_sum, FA136_sum, FA137_sum, FA_2_84_sum, FA_2_84_carry);
    FullAdder FA_2_85 (FA138_sum, FA139_sum, P16[13], FA_2_85_sum, FA_2_85_carry);
    FullAdder FA_2_86 (FA130_carry, FA131_carry, FA132_carry, FA_2_86_sum, FA_2_86_carry);
    HalfAdder HA_2_21 (FA133_carry, FA134_carry, HA_2_21_sum, HA_2_21_carry);
    
    /* Group 15 */
    FullAdder FA_2_87 (FA140_sum, FA141_sum, FA142_sum, FA_2_87_sum, FA_2_87_carry);
    FullAdder FA_2_88 (FA143_sum, FA144_sum, P16[14], FA_2_88_sum, FA_2_88_carry);
    FullAdder FA_2_89 (FA135_carry, FA136_carry, FA137_carry, FA_2_89_sum, FA_2_89_carry);
    HalfAdder HA_2_22 (FA138_carry, FA139_carry, HA_2_22_sum, HA_2_22_carry);
    
    /* Group 16 */
    FullAdder FA_2_90 (FA145_sum, FA146_sum, FA147_sum, FA_2_90_sum, FA_2_90_carry);
    FullAdder FA_2_91 (FA148_sum, FA149_sum, P16[15], FA_2_91_sum, FA_2_91_carry);
    FullAdder FA_2_92 (FA140_carry, FA141_carry, FA142_carry, FA_2_92_sum, FA_2_92_carry);
    HalfAdder HA_2_23 (FA143_carry, FA144_carry, HA_2_23_sum, HA_2_23_carry);
    
    /* Group 17 */
    FullAdder FA_2_93 (FA150_sum, FA151_sum, FA152_sum, FA_2_93_sum, FA_2_93_carry);
    FullAdder FA_2_94 (FA153_sum, FA154_sum, P16[16], FA_2_94_sum, FA_2_94_carry);
    FullAdder FA_2_95 (FA145_carry, FA146_carry, FA147_carry, FA_2_95_sum, FA_2_95_carry);
    HalfAdder HA_2_24 (FA148_carry, FA149_carry, HA_2_24_sum, HA_2_24_carry);
    
    /* Group 18 */
    FullAdder FA_2_96 (FA155_sum, FA156_sum, FA157_sum, FA_2_96_sum, FA_2_96_carry);
    FullAdder FA_2_97 (FA158_sum, FA159_sum, P16[17], FA_2_97_sum, FA_2_97_carry);
    FullAdder FA_2_98 (FA150_carry, FA151_carry, FA152_carry, FA_2_98_sum, FA_2_98_carry);
    HalfAdder HA_2_25 (FA153_carry, FA154_carry, HA_2_25_sum, HA_2_25_carry);
    
    /* Group 19 */
    FullAdder FA_2_99 (FA160_sum, FA161_sum, FA162_sum, FA_2_99_sum, FA_2_99_carry);
    FullAdder FA_2_100 (FA163_sum, FA164_sum, P16[18], FA_2_100_sum, FA_2_100_carry);
    FullAdder FA_2_101 (FA155_carry, FA156_carry, FA157_carry, FA_2_101_sum, FA_2_101_carry);
    HalfAdder HA_2_26 (FA158_carry, FA159_carry, HA_2_26_sum, HA_2_26_carry);
    
    /* Group 20 */
    FullAdder FA_2_102 (FA165_sum, FA166_sum, FA167_sum, FA_2_102_sum, FA_2_102_carry);
    FullAdder FA_2_103 (FA168_sum, FA169_sum, P16[19], FA_2_103_sum, FA_2_103_carry);
    FullAdder FA_2_104 (FA160_carry, FA161_carry, FA162_carry, FA_2_104_sum, FA_2_104_carry);
    HalfAdder HA_2_27 (FA163_carry, FA164_carry, HA_2_27_sum, HA_2_27_carry);
    
    /* Group 21 */
    FullAdder FA_2_105 (FA170_sum, FA171_sum, FA172_sum, FA_2_105_sum, FA_2_105_carry);
    FullAdder FA_2_106 (FA173_sum, FA174_sum, P16[20], FA_2_106_sum, FA_2_106_carry);
    FullAdder FA_2_107 (FA165_carry, FA166_carry, FA167_carry, FA_2_107_sum, FA_2_107_carry);
    HalfAdder HA_2_28 (FA168_carry, FA169_carry, HA_2_28_sum, HA_2_28_carry);
    
    /* Group 22 */
    FullAdder FA_2_108 (FA175_sum, FA176_sum, FA177_sum, FA_2_108_sum, FA_2_108_carry);
    FullAdder FA_2_109 (FA178_sum, FA179_sum, P16[21], FA_2_109_sum, FA_2_109_carry);
    FullAdder FA_2_110 (FA170_carry, FA171_carry, FA172_carry, FA_2_110_sum, FA_2_110_carry);
    HalfAdder HA_2_29 (FA173_carry, FA174_carry, HA_2_29_sum, HA_2_29_carry);
    
    /* Group 23 */
    FullAdder FA_2_111 (FA180_sum, FA181_sum, FA182_sum, FA_2_111_sum, FA_2_111_carry);
    FullAdder FA_2_112 (FA183_sum, FA184_sum, P16[22], FA_2_112_sum, FA_2_112_carry);
    FullAdder FA_2_113 (FA175_carry, FA176_carry, FA177_carry, FA_2_113_sum, FA_2_113_carry);
    HalfAdder HA_2_30 (FA178_carry, FA179_carry, HA_2_30_sum, HA_2_30_carry);
    
    /* Group 24 */
    FullAdder FA_2_114 (FA185_sum, FA186_sum, FA187_sum, FA_2_114_sum, FA_2_114_carry);
    FullAdder FA_2_115 (FA188_sum, FA189_sum, P16[23], FA_2_115_sum, FA_2_115_carry);
    FullAdder FA_2_116 (FA180_carry, FA181_carry, FA182_carry, FA_2_116_sum, FA_2_116_carry);
    HalfAdder HA_2_31 (FA183_carry, FA184_carry, HA_2_31_sum, HA_2_31_carry);
    
    /* Group 25 */
    FullAdder FA_2_117 (FA190_sum, FA191_sum, FA192_sum, FA_2_117_sum, FA_2_117_carry);
    FullAdder FA_2_118 (FA193_sum, FA194_sum, P16[24], FA_2_118_sum, FA_2_118_carry);
    FullAdder FA_2_119 (FA185_carry, FA186_carry, FA187_carry, FA_2_119_sum, FA_2_119_carry);
    HalfAdder HA_2_32 (FA188_carry, FA189_carry, HA_2_32_sum, HA_2_32_carry);
    
    /* Group 26 */
    FullAdder FA_2_120 (FA195_sum, FA196_sum, FA197_sum, FA_2_120_sum, FA_2_120_carry);
    FullAdder FA_2_121 (FA198_sum, FA199_sum, P16[25], FA_2_121_sum, FA_2_121_carry);
    FullAdder FA_2_122 (FA190_carry, FA191_carry, FA192_carry, FA_2_122_sum, FA_2_122_carry);
    HalfAdder HA_2_33 (FA193_carry, FA194_carry, HA_2_33_sum, HA_2_33_carry);
    
    /* Group 27 */
    FullAdder FA_2_123 (FA200_sum, FA201_sum, FA202_sum, FA_2_123_sum, FA_2_123_carry);
    FullAdder FA_2_124 (FA203_sum, FA204_sum, P16[26], FA_2_124_sum, FA_2_124_carry);
    FullAdder FA_2_125 (FA195_carry, FA196_carry, FA197_carry, FA_2_125_sum, FA_2_125_carry);
    HalfAdder HA_2_34 (FA198_carry, FA199_carry, HA_2_34_sum, HA_2_34_carry);
    
    /* Group 28 */
    FullAdder FA_2_126 (FA205_sum, FA206_sum, FA207_sum, FA_2_126_sum, FA_2_126_carry);
    FullAdder FA_2_127 (FA208_sum, FA209_sum, P16[27], FA_2_127_sum, FA_2_127_carry);
    FullAdder FA_2_128 (FA200_carry, FA201_carry, FA202_carry, FA_2_128_sum, FA_2_128_carry);
    HalfAdder HA_2_35 (FA203_carry, FA204_carry, HA_2_35_sum, HA_2_35_carry);
    
    /* Group 29 */
    FullAdder FA_2_129 (FA210_sum, FA211_sum, FA212_sum, FA_2_129_sum, FA_2_129_carry);
    FullAdder FA_2_130 (FA213_sum, FA214_sum, P16[28], FA_2_130_sum, FA_2_130_carry);
    FullAdder FA_2_131 (FA205_carry, FA206_carry, FA207_carry, FA_2_131_sum, FA_2_131_carry);
    HalfAdder HA_2_36 (FA208_carry, FA209_carry, HA_2_36_sum, HA_2_36_carry);
    
    /* Group 30 */
    FullAdder FA_2_132 (FA215_sum, FA216_sum, FA217_sum, FA_2_132_sum, FA_2_132_carry);
    FullAdder FA_2_133 (FA218_sum, FA219_sum, P16[29], FA_2_133_sum, FA_2_133_carry);
    FullAdder FA_2_134 (FA210_carry, FA211_carry, FA212_carry, FA_2_134_sum, FA_2_134_carry);
    HalfAdder HA_2_37 (FA213_carry, FA214_carry, HA_2_37_sum, HA_2_37_carry);
    
    /* Group 31 */
    FullAdder FA_2_135 (FA220_sum, FA221_sum, FA222_sum, FA_2_135_sum, FA_2_135_carry);
    FullAdder FA_2_136 (FA223_sum, FA224_sum, P16[30], FA_2_136_sum, FA_2_136_carry);
    FullAdder FA_2_137 (FA215_carry, FA216_carry, FA217_carry, FA_2_137_sum, FA_2_137_carry);
    HalfAdder HA_2_38 (FA218_carry, FA219_carry, HA_2_38_sum, HA_2_38_carry);
    
    /* Group 32 */
    FullAdder FA_2_138 (FA225_sum, FA226_sum, FA227_sum, FA_2_138_sum, FA_2_138_carry);
    FullAdder FA_2_139 (FA228_sum, FA229_sum, P16[31], FA_2_139_sum, FA_2_139_carry);
    FullAdder FA_2_140 (FA220_carry, FA221_carry, FA222_carry, FA_2_140_sum, FA_2_140_carry);
    HalfAdder HA_2_39 (FA223_carry, FA224_carry, HA_2_39_sum, HA_2_39_carry);
    
    /* Group 33 */
    FullAdder FA_2_141 (FA230_sum, FA231_sum, FA232_sum, FA_2_141_sum, FA_2_141_carry);
    FullAdder FA_2_142 (FA233_sum, FA234_sum, P16[32], FA_2_142_sum, FA_2_142_carry);
    FullAdder FA_2_143 (FA225_carry, FA226_carry, FA227_carry, FA_2_143_sum, FA_2_143_carry);
    HalfAdder HA_2_40 (FA228_carry, FA229_carry, HA_2_40_sum, HA_2_40_carry);
    
    /* Group 34 */
    FullAdder FA_2_144 (FA235_sum, FA236_sum, FA237_sum, FA_2_144_sum, FA_2_144_carry);
    FullAdder FA_2_145 (FA238_sum, FA239_sum, P16[33], FA_2_145_sum, FA_2_145_carry);
    FullAdder FA_2_146 (FA230_carry, FA231_carry, FA232_carry, FA_2_146_sum, FA_2_146_carry);
    HalfAdder HA_2_41 (FA233_carry, FA234_carry, HA_2_41_sum, HA_2_41_carry);
 
   
   // satge 3
    
//    HalfAdder HA_3_1 (FA_2_3_sum, HA2_carry, HA_3_1_sum, HA_3_1_carry);
//    FullAdder FA_3_1 (FA_2_4_sum, FA_2_3_carry , HA3_carry, FA_3_1_sum, FA_3_1_carry);
//    FullAdder FA_3_2  (FA_2_5_sum,  FA_2_4_carry,  FA7_carry,  FA_3_2_sum,  FA_3_2_carry);
//    FullAdder FA_3_3  (FA_2_6_sum,  FA_2_5_carry,  HA_2_2_sum, FA_3_3_sum,  FA_3_3_carry);
//    FullAdder FA_3_4  (FA_2_7_sum,  FA_2_6_carry,  HA_2_3_sum, FA_3_4_sum,  FA_3_4_carry);
//    FullAdder FA_3_5  (FA_2_8_sum, FA_2_7_carry,  HA_2_4_sum, FA_3_5_sum,  FA_3_5_carry);
//    FullAdder FA_3_6  (FA_2_9_sum, FA_2_8_carry, FA_2_10_sum, FA_3_6_sum,  FA_3_6_carry);
//    FullAdder FA_3_7  (FA_2_11_sum, FA_2_9_carry, FA_2_12_sum, FA_3_7_sum,  FA_3_7_carry);

//    FullAdder FA_3_8  (FA_2_13_sum, FA_2_11_carry, FA_2_14_sum, FA_3_8_sum,  FA_3_8_carry);
//    FullAdder FA_3_9  (FA_2_15_sum, FA23_carry, FA_2_16_sum, FA_3_9_sum,  FA_3_9_carry);
//    HalfAdder HA_3_2 (FA_2_13_carry, FA_2_14_carry, HA_3_2_sum, HA_3_2_carry);


//    FullAdder FA_3_10 (FA_2_17_sum, FA26_carry, FA_2_18_sum, FA_3_10_sum, FA_3_10_carry);
//    HalfAdder HA_3_3 (FA_2_15_carry, FA_2_16_carry, HA_3_3_sum, HA_3_3_carry);

//    FullAdder FA_3_11 (FA_2_19_sum, FA29_carry, FA_2_20_sum, FA_3_11_sum, FA_3_11_carry);
//    HalfAdder HA_3_4 (FA_2_17_carry, FA_2_18_carry, HA_3_4_sum, HA_3_4_carry);
    
//    FullAdder FA_3_12 (FA_2_21_sum, HA_2_5_sum, FA_2_22_sum, FA_3_12_sum, FA_3_12_carry);
//    HalfAdder HA_3_5 (FA_2_19_carry, FA_2_20_carry, HA_3_5_sum, HA_3_5_carry);

//    FullAdder FA_3_13 (FA_2_23_sum, HA_2_6_sum, FA_2_24_sum, FA_3_13_sum, FA_3_13_carry);
//    FullAdder FA_3_14 (FA_2_21_carry, HA_2_5_carry, FA_2_22_carry, FA_3_14_sum, FA_3_14_carry);

//    FullAdder FA_3_15 (FA_2_25_sum, HA_2_7_sum, FA_2_26_sum, FA_3_15_sum, FA_3_15_carry);
//    FullAdder FA_3_16 (FA_2_23_carry, HA_2_6_carry, FA_2_24_carry, FA_3_16_sum, FA_3_16_carry);
    
//    FullAdder FA_3_17 (FA_2_27_sum, FA_2_28_sum, FA_2_29_sum, FA_3_17_sum, FA_3_17_carry);
//    FullAdder FA_3_18 (FA_2_25_carry, HA_2_7_carry, FA_2_26_carry, FA_3_18_sum, FA_3_18_carry);

//    FullAdder FA_3_19 (FA_2_30_sum, FA_2_31_sum, FA_2_32_sum, FA_3_19_sum, FA_3_19_carry);
//    FullAdder FA_3_20 (FA_2_27_carry, FA_2_28_carry, FA_2_29_carry, FA_3_20_sum, FA_3_20_carry);

//    FullAdder FA_3_21 (FA_2_33_sum, FA_2_34_sum, FA_2_35_sum, FA_3_21_sum, FA_3_21_carry);
//    FullAdder FA_3_22 (FA_2_30_carry, FA_2_31_carry, FA_2_32_carry, FA_3_22_sum, FA_3_22_carry);

//    FullAdder FA_3_23 (FA_2_36_sum, FA_2_37_sum, FA_2_38_sum, FA_3_23_sum, FA_3_23_carry);
//    FullAdder FA_3_24 (HA8_carry, FA_2_33_carry, FA_2_34_carry, FA_3_24_sum, FA_3_24_carry);
    
//    FullAdder FA_3_25 (FA_2_39_sum, FA_2_40_sum, FA_2_41_sum, FA_3_25_sum, FA_3_25_carry);
//    FullAdder FA_3_26 (HA9_carry, FA_2_36_carry, FA_2_37_carry, FA_3_26_sum, FA_3_26_carry);
    
//    FullAdder FA_3_27 (FA_2_42_sum, FA_2_43_sum, FA_2_44_sum, FA_3_27_sum, FA_3_27_carry);
//    FullAdder FA_3_28 (FA64_carry, FA_2_39_carry, FA_2_40_carry, FA_3_28_sum, FA_3_28_carry);
    
//    FullAdder FA_3_29 (FA_2_45_sum, FA_2_46_sum, FA_2_47_sum, FA_3_29_sum, FA_3_29_carry);
//    FullAdder FA_3_30 (HA_2_8_sum, FA_2_42_carry, FA_2_43_carry, FA_3_30_sum, FA_3_30_carry);
    
//    FullAdder FA_3_31 (FA_2_48_sum, FA_2_49_sum, FA_2_50_sum, FA_3_31_sum, FA_3_31_carry);
//    FullAdder FA_3_32 (HA_2_9_sum, FA_2_45_carry, FA_2_46_carry, FA_3_32_sum, FA_3_32_carry);  
//    HalfAdder HA_3_6 (FA_2_47_carry, HA_2_8_carry, HA_3_6_sum, HA_3_6_carry);
    
//    FullAdder FA_3_33 (FA_2_51_sum, FA_2_52_sum, FA_2_53_sum, FA_3_33_sum, FA_3_33_carry);
//    FullAdder FA_3_34 (HA_2_10_sum, FA_2_48_carry, FA_2_49_carry, FA_3_34_sum, FA_3_34_carry);  
//    HalfAdder HA_3_7 (FA_2_50_carry, HA_2_9_carry, HA_3_7_sum, HA_3_7_carry);    
    
    
//        FullAdder FA_3_35 (FA_2_54_sum, FA_2_55_sum, FA_2_56_sum, FA_3_35_sum, FA_3_35_carry);
//    FullAdder FA_3_36 (HA_2_11_sum, FA_2_51_carry, FA_2_52_carry, FA_3_36_sum, FA_3_36_carry);  
//    HalfAdder HA_3_8 (FA_2_53_carry, HA_2_10_carry, HA_3_8_sum, HA_3_8_carry);
    
//    FullAdder FA_3_37 (FA_2_57_sum, FA_2_58_sum, FA_2_59_sum, FA_3_37_sum, FA_3_37_carry);
//    FullAdder FA_3_38 (HA_2_12_sum, FA_2_54_carry, FA_2_55_carry, FA_3_38_sum, FA_3_38_carry);  
//    HalfAdder HA_3_9 (FA_2_56_carry, HA_2_11_carry, HA_3_9_sum, HA_3_9_carry);
    
//    FullAdder FA_3_39 (FA_2_60_sum, FA_2_61_sum, FA_2_62_sum, FA_3_39_sum, FA_3_39_carry);
//    FullAdder FA_3_40 (HA_2_13_sum, FA_2_57_carry, FA_2_58_carry, FA_3_40_sum, FA_3_40_carry);  
//    HalfAdder HA_3_10 (FA_2_59_carry, HA_2_12_carry, HA_3_10_sum, HA_3_10_carry);
    
//    FullAdder FA_3_41 (FA_2_63_sum, FA_2_64_sum, FA_2_65_sum, FA_3_41_sum, FA_3_41_carry);
//    FullAdder FA_3_42 (HA_2_14_sum, FA_2_60_carry, FA_2_61_carry, FA_3_42_sum, FA_3_42_carry);  
//    HalfAdder HA_3_11 (FA_2_62_carry, HA_2_13_carry, HA_3_11_sum, HA_3_11_carry);
    
//    FullAdder FA_3_43 (FA_2_66_sum, FA_2_67_sum, FA_2_68_sum, FA_3_43_sum, FA_3_43_carry);
//    FullAdder FA_3_44 (HA_2_15_sum, FA_2_63_carry, FA_2_64_carry, FA_3_44_sum, FA_3_44_carry);  
//    HalfAdder HA_3_12 (FA_2_65_carry, HA_2_14_carry, HA_3_12_sum, HA_3_12_carry);
    
//    FullAdder FA_3_45 (FA_2_69_sum, FA_2_70_sum, FA_2_71_sum, FA_3_45_sum, FA_3_45_carry);
//    FullAdder FA_3_46 (HA_2_16_sum, FA_2_66_carry, FA_2_67_carry, FA_3_46_sum, FA_3_46_carry);  
//    HalfAdder HA_3_13 (FA_2_68_carry, HA_2_15_carry, HA_3_13_sum, HA_3_13_carry);
    
//    FullAdder FA_3_47 (FA_2_72_sum, FA_2_73_sum, FA_2_74_sum, FA_3_47_sum, FA_3_47_carry);
//    FullAdder FA_3_48 (HA_2_17_sum, FA_2_69_carry, FA_2_70_carry, FA_3_48_sum, FA_3_48_carry);  
//    HalfAdder HA_3_14 (FA_2_71_carry, HA_2_16_carry, HA_3_14_sum, HA_3_14_carry);
    
//    FullAdder FA_3_49 (FA_2_75_sum, FA_2_76_sum, FA_2_77_sum, FA_3_49_sum, FA_3_49_carry);
//    FullAdder FA_3_50 (HA_2_18_sum, FA_2_72_carry, FA_2_73_carry, FA_3_50_sum, FA_3_50_carry);  
//    HalfAdder HA_3_15 (FA_2_74_carry, HA_2_17_carry, HA_3_15_sum, HA_3_15_carry);
    
//    FullAdder FA_3_51 (FA_2_78_sum, FA_2_79_sum, FA_2_80_sum, FA_3_51_sum, FA_3_51_carry);
//    FullAdder FA_3_52 (HA_2_19_sum, FA_2_75_carry, FA_2_76_carry, FA_3_52_sum, FA_3_52_carry);  
//    HalfAdder HA_3_16 (FA_2_77_carry, HA_2_18_carry, HA_3_16_sum, HA_3_16_carry);
    
//    FullAdder FA_3_53 (FA_2_81_sum, FA_2_82_sum, FA_2_83_sum, FA_3_53_sum, FA_3_53_carry);
//    FullAdder FA_3_54 (HA_2_20_sum, FA_2_78_carry, FA_2_79_carry, FA_3_54_sum, FA_3_54_carry);  
//    HalfAdder HA_3_17 (FA_2_80_carry, HA_2_19_carry, HA_3_17_sum, HA_3_17_carry);
    
//    FullAdder FA_3_55 (FA_2_84_sum, FA_2_85_sum, FA_2_86_sum, FA_3_55_sum, FA_3_55_carry);
//    FullAdder FA_3_56 (HA_2_21_sum, FA_2_81_carry, FA_2_82_carry, FA_3_56_sum, FA_3_56_carry);  
//    HalfAdder HA_3_18 (FA_2_83_carry, HA_2_20_carry, HA_3_18_sum, HA_3_18_carry);
    
//    FullAdder FA_3_57 (FA_2_87_sum, FA_2_88_sum, FA_2_89_sum, FA_3_57_sum, FA_3_57_carry);
//    FullAdder FA_3_58 (HA_2_22_sum, FA_2_84_carry, FA_2_85_carry, FA_3_58_sum, FA_3_58_carry);  
//    HalfAdder HA_3_19 (FA_2_86_carry, HA_2_21_carry, HA_3_19_sum, HA_3_19_carry);
    
//    FullAdder FA_3_59 (FA_2_90_sum, FA_2_91_sum, FA_2_92_sum, FA_3_59_sum, FA_3_59_carry);
//    FullAdder FA_3_60 (HA_2_23_sum, FA_2_87_carry, FA_2_88_carry, FA_3_60_sum, FA_3_60_carry);  
//    HalfAdder HA_3_20 (FA_2_89_carry, HA_2_22_carry, HA_3_20_sum, HA_3_20_carry);
    
//    FullAdder FA_3_61 (FA_2_93_sum, FA_2_94_sum, FA_2_95_sum, FA_3_61_sum, FA_3_61_carry);
//    FullAdder FA_3_62 (HA_2_24_sum, FA_2_90_carry, FA_2_91_carry, FA_3_62_sum, FA_3_62_carry);  
//    HalfAdder HA_3_21 (FA_2_92_carry, HA_2_23_carry, HA_3_21_sum, HA_3_21_carry);
    
//    FullAdder FA_3_63 (FA_2_96_sum, FA_2_97_sum, FA_2_98_sum, FA_3_63_sum, FA_3_63_carry);
//    FullAdder FA_3_64 (HA_2_25_sum, FA_2_93_carry, FA_2_94_carry, FA_3_64_sum, FA_3_64_carry);  
//    HalfAdder HA_3_22 (FA_2_95_carry, HA_2_24_carry, HA_3_22_sum, HA_3_22_carry);
    
//    FullAdder FA_3_65 (FA_2_99_sum, FA_2_100_sum, FA_2_101_sum, FA_3_65_sum, FA_3_65_carry);
//    FullAdder FA_3_66 (HA_2_26_sum, FA_2_96_carry, FA_2_97_carry, FA_3_66_sum, FA_3_66_carry);  
//    HalfAdder HA_3_23 (FA_2_98_carry, HA_2_25_carry, HA_3_23_sum, HA_3_23_carry);
    
//    FullAdder FA_3_67 (FA_2_102_sum, FA_2_103_sum, FA_2_104_sum, FA_3_67_sum, FA_3_67_carry);
//    FullAdder FA_3_68 (HA_2_27_sum, FA_2_99_carry, FA_2_100_carry, FA_3_68_sum, FA_3_68_carry);  
//    HalfAdder HA_3_24 (FA_2_101_carry, HA_2_26_carry, HA_3_24_sum, HA_3_24_carry);
    
//    FullAdder FA_3_69 (FA_2_105_sum, FA_2_106_sum, FA_2_107_sum, FA_3_69_sum, FA_3_69_carry);
//    FullAdder FA_3_70 (HA_2_28_sum, FA_2_102_carry, FA_2_103_carry, FA_3_70_sum, FA_3_70_carry);  
//    HalfAdder HA_3_25 (FA_2_104_carry, HA_2_27_carry, HA_3_25_sum, HA_3_25_carry);
    
//    FullAdder FA_3_71 (FA_2_108_sum, FA_2_109_sum, FA_2_110_sum, FA_3_71_sum, FA_3_71_carry);
//    FullAdder FA_3_72 (HA_2_29_sum, FA_2_105_carry, FA_2_106_carry, FA_3_72_sum, FA_3_72_carry);  
//    HalfAdder HA_3_26 (FA_2_107_carry, HA_2_28_carry, HA_3_26_sum, HA_3_26_carry);
    
//    FullAdder FA_3_73 (FA_2_111_sum, FA_2_112_sum, FA_2_113_sum, FA_3_73_sum, FA_3_73_carry);
//    FullAdder FA_3_74 (HA_2_30_sum, FA_2_108_carry, FA_2_109_carry, FA_3_74_sum, FA_3_74_carry);  
//    HalfAdder HA_3_27 (FA_2_110_carry, HA_2_29_carry, HA_3_27_sum, HA_3_27_carry);
    
//    FullAdder FA_3_75 (FA_2_114_sum, FA_2_115_sum, FA_2_116_sum, FA_3_75_sum, FA_3_75_carry);
//    FullAdder FA_3_76 (HA_2_31_sum, FA_2_111_carry, FA_2_112_carry, FA_3_76_sum, FA_3_76_carry);  
//    HalfAdder HA_3_28 (FA_2_113_carry, HA_2_30_carry, HA_3_28_sum, HA_3_28_carry);
    
//    FullAdder FA_3_77 (FA_2_117_sum, FA_2_118_sum, FA_2_119_sum, FA_3_77_sum, FA_3_77_carry);
//    FullAdder FA_3_78 (HA_2_32_sum, FA_2_114_carry, FA_2_115_carry, FA_3_78_sum, FA_3_78_carry);  
//    HalfAdder HA_3_29 (FA_2_116_carry, HA_2_31_carry, HA_3_29_sum, HA_3_29_carry);
    
//    FullAdder FA_3_79 (FA_2_120_sum, FA_2_121_sum, FA_2_122_sum, FA_3_79_sum, FA_3_79_carry);
//    FullAdder FA_3_80 (HA_2_33_sum, FA_2_117_carry, FA_2_118_carry, FA_3_80_sum, FA_3_80_carry);  
//    HalfAdder HA_3_30 (FA_2_119_carry, HA_2_32_carry, HA_3_30_sum, HA_3_30_carry);
    
//    FullAdder FA_3_81 (FA_2_123_sum, FA_2_124_sum, FA_2_125_sum, FA_3_81_sum, FA_3_81_carry);
//    FullAdder FA_3_82 (HA_2_34_sum, FA_2_120_carry, FA_2_121_carry, FA_3_82_sum, FA_3_82_carry);  
//    HalfAdder HA_3_31 (FA_2_122_carry, HA_2_33_carry, HA_3_31_sum, HA_3_31_carry);
    
//    FullAdder FA_3_83 (FA_2_126_sum, FA_2_127_sum, FA_2_128_sum, FA_3_83_sum, FA_3_83_carry);
//    FullAdder FA_3_84 (HA_2_35_sum, FA_2_123_carry, FA_2_124_carry, FA_3_84_sum, FA_3_84_carry);  
//    HalfAdder HA_3_32 (FA_2_125_carry, HA_2_34_carry, HA_3_32_sum, HA_3_32_carry);
    
//    FullAdder FA_3_85 (FA_2_129_sum, FA_2_130_sum, FA_2_131_sum, FA_3_85_sum, FA_3_85_carry);
//    FullAdder FA_3_86 (HA_2_36_sum, FA_2_126_carry, FA_2_127_carry, FA_3_86_sum, FA_3_86_carry);  
//    HalfAdder HA_3_33 (FA_2_128_carry, HA_2_35_carry, HA_3_33_sum, HA_3_33_carry);
    
//    FullAdder FA_3_87 (FA_2_132_sum, FA_2_133_sum, FA_2_134_sum, FA_3_87_sum, FA_3_87_carry);
//    FullAdder FA_3_88 (HA_2_37_sum, FA_2_129_carry, FA_2_130_carry, FA_3_88_sum, FA_3_88_carry);  
//    HalfAdder HA_3_34 (FA_2_131_carry, HA_2_36_carry, HA_3_34_sum, HA_3_34_carry);
    
//    FullAdder FA_3_89 (FA_2_135_sum, FA_2_136_sum, FA_2_137_sum, FA_3_89_sum, FA_3_89_carry);
//    FullAdder FA_3_90 (HA_2_38_sum, FA_2_132_carry, FA_2_133_carry, FA_3_90_sum, FA_3_90_carry);  
//    HalfAdder HA_3_35 (FA_2_134_carry, HA_2_37_carry, HA_3_35_sum, HA_3_35_carry);
    
//    FullAdder FA_3_91 (FA_2_138_sum, FA_2_139_sum, FA_2_140_sum, FA_3_91_sum, FA_3_91_carry);
//    FullAdder FA_3_92 (HA_2_39_sum, FA_2_135_carry, FA_2_136_carry, FA_3_92_sum, FA_3_92_carry);  
//    HalfAdder HA_3_36 (FA_2_137_carry, HA_2_38_carry, HA_3_36_sum, HA_3_36_carry);
    
//    FullAdder FA_3_93 (FA_2_141_sum, FA_2_142_sum, FA_2_143_sum, FA_3_93_sum, FA_3_93_carry);
//    FullAdder FA_3_94 (HA_2_40_sum, FA_2_138_carry, FA_2_139_carry, FA_3_94_sum, FA_3_94_carry);  
//    HalfAdder HA_3_37 (FA_2_140_carry, HA_2_39_carry, HA_3_37_sum, HA_3_37_carry);
    
//    FullAdder FA_3_95 (FA_2_144_sum, FA_2_145_sum, FA_2_146_sum, FA_3_95_sum, FA_3_95_carry);
//    FullAdder FA_3_96 (HA_2_41_sum, FA_2_141_carry, FA_2_142_carry, FA_3_96_sum, FA_3_96_carry);  
//    HalfAdder HA_3_38 (FA_2_143_carry, HA_2_40_carry, HA_3_38_sum, HA_3_38_carry);

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
			P12_double <= 0;
			P13_double <= 0;
			P14_double <= 0;
			P15_double <= 0;
			P16_double <= 0;
			
			FA_2_1_sum_reg <= 0; FA_2_1_carry_reg <= 0;
			FA_2_2_sum_reg <= 0; FA_2_2_carry_reg <= 0;
			FA_2_3_sum_reg <= 0; FA_2_3_carry_reg <= 0;
			FA_2_4_sum_reg <= 0; FA_2_4_carry_reg <= 0;
			FA_2_5_sum_reg <= 0; FA_2_5_carry_reg <= 0;
			FA_2_6_sum_reg <= 0; FA_2_6_carry_reg <= 0;
			FA_2_7_sum_reg <= 0; FA_2_7_carry_reg <= 0;
			FA_2_8_sum_reg <= 0; FA_2_8_carry_reg <= 0;
			FA_2_9_sum_reg <= 0; FA_2_9_carry_reg <= 0;
			FA_2_10_sum_reg <= 0; FA_2_10_carry_reg <= 0;
			FA_2_11_sum_reg <= 0; FA_2_11_carry_reg <= 0;
			FA_2_12_sum_reg <= 0; FA_2_12_carry_reg <= 0;
			FA_2_13_sum_reg <= 0; FA_2_13_carry_reg <= 0;
			FA_2_14_sum_reg <= 0; FA_2_14_carry_reg <= 0;
			FA_2_15_sum_reg <= 0; FA_2_15_carry_reg <= 0;
			FA_2_16_sum_reg <= 0; FA_2_16_carry_reg <= 0;
			FA_2_17_sum_reg <= 0; FA_2_17_carry_reg <= 0;
			FA_2_18_sum_reg <= 0; FA_2_18_carry_reg <= 0;
			FA_2_19_sum_reg <= 0; FA_2_19_carry_reg <= 0;
			FA_2_20_sum_reg <= 0; FA_2_20_carry_reg <= 0;
			FA_2_21_sum_reg <= 0; FA_2_21_carry_reg <= 0;
			FA_2_22_sum_reg <= 0; FA_2_22_carry_reg <= 0;
			FA_2_23_sum_reg <= 0; FA_2_23_carry_reg <= 0;
			FA_2_24_sum_reg <= 0; FA_2_24_carry_reg <= 0;
			FA_2_25_sum_reg <= 0; FA_2_25_carry_reg <= 0;
			FA_2_26_sum_reg <= 0; FA_2_26_carry_reg <= 0;
			FA_2_27_sum_reg <= 0; FA_2_27_carry_reg <= 0;
			FA_2_28_sum_reg <= 0; FA_2_28_carry_reg <= 0;
			FA_2_29_sum_reg <= 0; FA_2_29_carry_reg <= 0;
			FA_2_30_sum_reg <= 0; FA_2_30_carry_reg <= 0;
			FA_2_31_sum_reg <= 0; FA_2_31_carry_reg <= 0;
			FA_2_32_sum_reg <= 0; FA_2_32_carry_reg <= 0;
			FA_2_33_sum_reg <= 0; FA_2_33_carry_reg <= 0;
			FA_2_34_sum_reg <= 0; FA_2_34_carry_reg <= 0;
			FA_2_35_sum_reg <= 0; FA_2_35_carry_reg <= 0;
			FA_2_36_sum_reg <= 0; FA_2_36_carry_reg <= 0;
			FA_2_37_sum_reg <= 0; FA_2_37_carry_reg <= 0;
			FA_2_38_sum_reg <= 0; FA_2_38_carry_reg <= 0;
			FA_2_39_sum_reg <= 0; FA_2_39_carry_reg <= 0;
			FA_2_40_sum_reg <= 0; FA_2_40_carry_reg <= 0;
			FA_2_41_sum_reg <= 0; FA_2_41_carry_reg <= 0;
			FA_2_42_sum_reg <= 0; FA_2_42_carry_reg <= 0;
			FA_2_43_sum_reg <= 0; FA_2_43_carry_reg <= 0;
			FA_2_44_sum_reg <= 0; FA_2_44_carry_reg <= 0;
			FA_2_45_sum_reg <= 0; FA_2_45_carry_reg <= 0;
			FA_2_46_sum_reg <= 0; FA_2_46_carry_reg <= 0;
			FA_2_47_sum_reg <= 0; FA_2_47_carry_reg <= 0;
			FA_2_48_sum_reg <= 0; FA_2_48_carry_reg <= 0;
			FA_2_49_sum_reg <= 0; FA_2_49_carry_reg <= 0;
			FA_2_50_sum_reg <= 0; FA_2_50_carry_reg <= 0;
			FA_2_51_sum_reg <= 0; FA_2_51_carry_reg <= 0;
			FA_2_52_sum_reg <= 0; FA_2_52_carry_reg <= 0;
			FA_2_53_sum_reg <= 0; FA_2_53_carry_reg <= 0;
			FA_2_54_sum_reg <= 0; FA_2_54_carry_reg <= 0;
			FA_2_55_sum_reg <= 0; FA_2_55_carry_reg <= 0;
			FA_2_56_sum_reg <= 0; FA_2_56_carry_reg <= 0;
			FA_2_57_sum_reg <= 0; FA_2_57_carry_reg <= 0;
			FA_2_58_sum_reg <= 0; FA_2_58_carry_reg <= 0;
			FA_2_59_sum_reg <= 0; FA_2_59_carry_reg <= 0;
			FA_2_60_sum_reg <= 0; FA_2_60_carry_reg <= 0;
			FA_2_61_sum_reg <= 0; FA_2_61_carry_reg <= 0;
			FA_2_62_sum_reg <= 0; FA_2_62_carry_reg <= 0;
			FA_2_63_sum_reg <= 0; FA_2_63_carry_reg <= 0;
			FA_2_64_sum_reg <= 0; FA_2_64_carry_reg <= 0;
			FA_2_65_sum_reg <= 0; FA_2_65_carry_reg <= 0;
			FA_2_66_sum_reg <= 0; FA_2_66_carry_reg <= 0;
			FA_2_67_sum_reg <= 0; FA_2_67_carry_reg <= 0;
			FA_2_68_sum_reg <= 0; FA_2_68_carry_reg <= 0;
			FA_2_69_sum_reg <= 0; FA_2_69_carry_reg <= 0;
			FA_2_70_sum_reg <= 0; FA_2_70_carry_reg <= 0;
			FA_2_71_sum_reg <= 0; FA_2_71_carry_reg <= 0;
			FA_2_72_sum_reg <= 0; FA_2_72_carry_reg <= 0;
			FA_2_73_sum_reg <= 0; FA_2_73_carry_reg <= 0;
			FA_2_74_sum_reg <= 0; FA_2_74_carry_reg <= 0;
			FA_2_75_sum_reg <= 0; FA_2_75_carry_reg <= 0;
			FA_2_76_sum_reg <= 0; FA_2_76_carry_reg <= 0;
			FA_2_77_sum_reg <= 0; FA_2_77_carry_reg <= 0;
			FA_2_78_sum_reg <= 0; FA_2_78_carry_reg <= 0;
			FA_2_79_sum_reg <= 0; FA_2_79_carry_reg <= 0;
			FA_2_80_sum_reg <= 0; FA_2_80_carry_reg <= 0;
			FA_2_81_sum_reg <= 0; FA_2_81_carry_reg <= 0;
			FA_2_82_sum_reg <= 0; FA_2_82_carry_reg <= 0;
			FA_2_83_sum_reg <= 0; FA_2_83_carry_reg <= 0;
			FA_2_84_sum_reg <= 0; FA_2_84_carry_reg <= 0;
			FA_2_85_sum_reg <= 0; FA_2_85_carry_reg <= 0;
			FA_2_86_sum_reg <= 0; FA_2_86_carry_reg <= 0;
			FA_2_87_sum_reg <= 0; FA_2_87_carry_reg <= 0;
			FA_2_88_sum_reg <= 0; FA_2_88_carry_reg <= 0;
			FA_2_89_sum_reg <= 0; FA_2_89_carry_reg <= 0;
			FA_2_90_sum_reg <= 0; FA_2_90_carry_reg <= 0;
			FA_2_91_sum_reg <= 0; FA_2_91_carry_reg <= 0;
			FA_2_92_sum_reg <= 0; FA_2_92_carry_reg <= 0;
			FA_2_93_sum_reg <= 0; FA_2_93_carry_reg <= 0;
			FA_2_94_sum_reg <= 0; FA_2_94_carry_reg <= 0;
			FA_2_95_sum_reg <= 0; FA_2_95_carry_reg <= 0;
			FA_2_96_sum_reg <= 0; FA_2_96_carry_reg <= 0;
			FA_2_97_sum_reg <= 0; FA_2_97_carry_reg <= 0;
			FA_2_98_sum_reg <= 0; FA_2_98_carry_reg <= 0;
			FA_2_99_sum_reg <= 0; FA_2_99_carry_reg <= 0;
			FA_2_100_sum_reg <= 0; FA_2_100_carry_reg <= 0;
			FA_2_101_sum_reg <= 0; FA_2_101_carry_reg <= 0;
			FA_2_102_sum_reg <= 0; FA_2_102_carry_reg <= 0;
			FA_2_103_sum_reg <= 0; FA_2_103_carry_reg <= 0;
			FA_2_104_sum_reg <= 0; FA_2_104_carry_reg <= 0;
			FA_2_105_sum_reg <= 0; FA_2_105_carry_reg <= 0;
			FA_2_106_sum_reg <= 0; FA_2_106_carry_reg <= 0;
			FA_2_107_sum_reg <= 0; FA_2_107_carry_reg <= 0;
			FA_2_108_sum_reg <= 0; FA_2_108_carry_reg <= 0;
			FA_2_109_sum_reg <= 0; FA_2_109_carry_reg <= 0;
			FA_2_110_sum_reg <= 0; FA_2_110_carry_reg <= 0;
			FA_2_111_sum_reg <= 0; FA_2_111_carry_reg <= 0;
			FA_2_112_sum_reg <= 0; FA_2_112_carry_reg <= 0;
			FA_2_113_sum_reg <= 0; FA_2_113_carry_reg <= 0;
			FA_2_114_sum_reg <= 0; FA_2_114_carry_reg <= 0;
			FA_2_115_sum_reg <= 0; FA_2_115_carry_reg <= 0;
			FA_2_116_sum_reg <= 0; FA_2_116_carry_reg <= 0;
			FA_2_117_sum_reg <= 0; FA_2_117_carry_reg <= 0;
			FA_2_118_sum_reg <= 0; FA_2_118_carry_reg <= 0;
			FA_2_119_sum_reg <= 0; FA_2_119_carry_reg <= 0;
			FA_2_120_sum_reg <= 0; FA_2_120_carry_reg <= 0;
			FA_2_121_sum_reg <= 0; FA_2_121_carry_reg <= 0;
			FA_2_122_sum_reg <= 0; FA_2_122_carry_reg <= 0;
			FA_2_123_sum_reg <= 0; FA_2_123_carry_reg <= 0;
			FA_2_124_sum_reg <= 0; FA_2_124_carry_reg <= 0;
			FA_2_125_sum_reg <= 0; FA_2_125_carry_reg <= 0;
			FA_2_126_sum_reg <= 0; FA_2_126_carry_reg <= 0;
			FA_2_127_sum_reg <= 0; FA_2_127_carry_reg <= 0;
			FA_2_128_sum_reg <= 0; FA_2_128_carry_reg <= 0;
			FA_2_129_sum_reg <= 0; FA_2_129_carry_reg <= 0;
			FA_2_130_sum_reg <= 0; FA_2_130_carry_reg <= 0;
			FA_2_131_sum_reg <= 0; FA_2_131_carry_reg <= 0;
			FA_2_132_sum_reg <= 0; FA_2_132_carry_reg <= 0;
			FA_2_133_sum_reg <= 0; FA_2_133_carry_reg <= 0;
			FA_2_134_sum_reg <= 0; FA_2_134_carry_reg <= 0;
			FA_2_135_sum_reg <= 0; FA_2_135_carry_reg <= 0;
			FA_2_136_sum_reg <= 0; FA_2_136_carry_reg <= 0;
			FA_2_137_sum_reg <= 0; FA_2_137_carry_reg <= 0;
			FA_2_138_sum_reg <= 0; FA_2_138_carry_reg <= 0;
			FA_2_139_sum_reg <= 0; FA_2_139_carry_reg <= 0;
			FA_2_140_sum_reg <= 0; FA_2_140_carry_reg <= 0;
			FA_2_141_sum_reg <= 0; FA_2_141_carry_reg <= 0;
			FA_2_142_sum_reg <= 0; FA_2_142_carry_reg <= 0;
			FA_2_143_sum_reg <= 0; FA_2_143_carry_reg <= 0;
			FA_2_144_sum_reg <= 0; FA_2_144_carry_reg <= 0;
			FA_2_145_sum_reg <= 0; FA_2_145_carry_reg <= 0;
			FA_2_146_sum_reg <= 0; FA_2_146_carry_reg <= 0;
			
			HA_2_1_sum_reg <= 0;
			HA_2_1_carry_reg <= 0;
			HA_2_2_sum_reg <= 0;
			HA_2_2_carry_reg <= 0;
			HA_2_3_sum_reg <= 0;
			HA_2_3_carry_reg <= 0;
			HA_2_4_sum_reg <= 0;
			HA_2_4_carry_reg <= 0;
			HA_2_5_sum_reg <= 0;
			HA_2_5_carry_reg <= 0;
			HA_2_6_sum_reg <= 0;
			HA_2_6_carry_reg <= 0;
			HA_2_7_sum_reg <= 0;
			HA_2_7_carry_reg <= 0;
			HA_2_8_sum_reg <= 0;
			HA_2_8_carry_reg <= 0;
			HA_2_9_sum_reg <= 0;
			HA_2_9_carry_reg <= 0;
			HA_2_10_sum_reg <= 0;
			HA_2_10_carry_reg <= 0;
			HA_2_11_sum_reg <= 0;
			HA_2_11_carry_reg <= 0;
			HA_2_12_sum_reg <= 0;
			HA_2_12_carry_reg <= 0;
			HA_2_13_sum_reg <= 0;
			HA_2_13_carry_reg <= 0;
			HA_2_14_sum_reg <= 0;
			HA_2_14_carry_reg <= 0;
			HA_2_15_sum_reg <= 0;
			HA_2_15_carry_reg <= 0;
			HA_2_16_sum_reg <= 0;
			HA_2_16_carry_reg <= 0;
			HA_2_17_sum_reg <= 0;
			HA_2_17_carry_reg <= 0;
			HA_2_18_sum_reg <= 0;
			HA_2_18_carry_reg <= 0;
			HA_2_19_sum_reg <= 0;
			HA_2_19_carry_reg <= 0;
			HA_2_20_sum_reg <= 0;
			HA_2_20_carry_reg <= 0;
			HA_2_21_sum_reg <= 0;
			HA_2_21_carry_reg <= 0;
			HA_2_22_sum_reg <= 0;
			HA_2_22_carry_reg <= 0;
			HA_2_23_sum_reg <= 0;
			HA_2_23_carry_reg <= 0;
			HA_2_24_sum_reg <= 0;
			HA_2_24_carry_reg <= 0;
			HA_2_25_sum_reg <= 0;
			HA_2_25_carry_reg <= 0;
			HA_2_26_sum_reg <= 0;
			HA_2_26_carry_reg <= 0;
			HA_2_27_sum_reg <= 0;
			HA_2_27_carry_reg <= 0;
			HA_2_28_sum_reg <= 0;
			HA_2_28_carry_reg <= 0;
			HA_2_29_sum_reg <= 0;
			HA_2_29_carry_reg <= 0;
			HA_2_30_sum_reg <= 0;
			HA_2_30_carry_reg <= 0;
			HA_2_31_sum_reg <= 0;
			HA_2_31_carry_reg <= 0;
			HA_2_32_sum_reg <= 0;
			HA_2_32_carry_reg <= 0;
			HA_2_33_sum_reg <= 0;
			HA_2_33_carry_reg <= 0;
			HA_2_34_sum_reg <= 0;
			HA_2_34_carry_reg <= 0;
			HA_2_35_sum_reg <= 0;
			HA_2_35_carry_reg <= 0;
			HA_2_36_sum_reg <= 0;
			HA_2_36_carry_reg <= 0;
			HA_2_37_sum_reg <= 0;
			HA_2_37_carry_reg <= 0;
			HA_2_38_sum_reg <= 0;
			HA_2_38_carry_reg <= 0;
			HA_2_39_sum_reg <= 0;
			HA_2_39_carry_reg <= 0;
			HA_2_40_sum_reg <= 0;
			HA_2_40_carry_reg <= 0;
			HA_2_41_sum_reg <= 0;
			HA_2_41_carry_reg <= 0;
			
		end
		else begin
			FA_2_1_sum_reg <= FA_2_1_sum; FA_2_1_carry_reg <= FA_2_1_carry;
			FA_2_2_sum_reg <= FA_2_2_sum; FA_2_2_carry_reg <= FA_2_2_carry;
			FA_2_3_sum_reg <= FA_2_3_sum; FA_2_3_carry_reg <= FA_2_3_carry;
			FA_2_4_sum_reg <= FA_2_4_sum; FA_2_4_carry_reg <= FA_2_4_carry;
			FA_2_5_sum_reg <= FA_2_5_sum; FA_2_5_carry_reg <= FA_2_5_carry;
			FA_2_6_sum_reg <= FA_2_6_sum; FA_2_6_carry_reg <= FA_2_6_carry;
			FA_2_7_sum_reg <= FA_2_7_sum; FA_2_7_carry_reg <= FA_2_7_carry;
			FA_2_8_sum_reg <= FA_2_8_sum; FA_2_8_carry_reg <= FA_2_8_carry;
			FA_2_9_sum_reg <= FA_2_9_sum; FA_2_9_carry_reg <= FA_2_9_carry;
			FA_2_10_sum_reg <= FA_2_10_sum; FA_2_10_carry_reg <= FA_2_10_carry;
			FA_2_11_sum_reg <= FA_2_11_sum; FA_2_11_carry_reg <= FA_2_11_carry;
			FA_2_12_sum_reg <= FA_2_12_sum; FA_2_12_carry_reg <= FA_2_12_carry;
			FA_2_13_sum_reg <= FA_2_13_sum; FA_2_13_carry_reg <= FA_2_13_carry;
			FA_2_14_sum_reg <= FA_2_14_sum; FA_2_14_carry_reg <= FA_2_14_carry;
			FA_2_15_sum_reg <= FA_2_15_sum; FA_2_15_carry_reg <= FA_2_15_carry;
			FA_2_16_sum_reg <= FA_2_16_sum; FA_2_16_carry_reg <= FA_2_16_carry;
			FA_2_17_sum_reg <= FA_2_17_sum; FA_2_17_carry_reg <= FA_2_17_carry;
			FA_2_18_sum_reg <= FA_2_18_sum; FA_2_18_carry_reg <= FA_2_18_carry;
			FA_2_19_sum_reg <= FA_2_19_sum; FA_2_19_carry_reg <= FA_2_19_carry;
			FA_2_20_sum_reg <= FA_2_20_sum; FA_2_20_carry_reg <= FA_2_20_carry;
			FA_2_21_sum_reg <= FA_2_21_sum; FA_2_21_carry_reg <= FA_2_21_carry;
			FA_2_22_sum_reg <= FA_2_22_sum; FA_2_22_carry_reg <= FA_2_22_carry;
			FA_2_23_sum_reg <= FA_2_23_sum; FA_2_23_carry_reg <= FA_2_23_carry;
			FA_2_24_sum_reg <= FA_2_24_sum; FA_2_24_carry_reg <= FA_2_24_carry;
			FA_2_25_sum_reg <= FA_2_25_sum; FA_2_25_carry_reg <= FA_2_25_carry;
			FA_2_26_sum_reg <= FA_2_26_sum; FA_2_26_carry_reg <= FA_2_26_carry;
			FA_2_27_sum_reg <= FA_2_27_sum; FA_2_27_carry_reg <= FA_2_27_carry;
			FA_2_28_sum_reg <= FA_2_28_sum; FA_2_28_carry_reg <= FA_2_28_carry;
			FA_2_29_sum_reg <= FA_2_29_sum; FA_2_29_carry_reg <= FA_2_29_carry;
			FA_2_30_sum_reg <= FA_2_30_sum; FA_2_30_carry_reg <= FA_2_30_carry;
			FA_2_31_sum_reg <= FA_2_31_sum; FA_2_31_carry_reg <= FA_2_31_carry;
			FA_2_32_sum_reg <= FA_2_32_sum; FA_2_32_carry_reg <= FA_2_32_carry;
			FA_2_33_sum_reg <= FA_2_33_sum; FA_2_33_carry_reg <= FA_2_33_carry;
			FA_2_34_sum_reg <= FA_2_34_sum; FA_2_34_carry_reg <= FA_2_34_carry;
			FA_2_35_sum_reg <= FA_2_35_sum; FA_2_35_carry_reg <= FA_2_35_carry;
			FA_2_36_sum_reg <= FA_2_36_sum; FA_2_36_carry_reg <= FA_2_36_carry;
			FA_2_37_sum_reg <= FA_2_37_sum; FA_2_37_carry_reg <= FA_2_37_carry;
			FA_2_38_sum_reg <= FA_2_38_sum; FA_2_38_carry_reg <= FA_2_38_carry;
			FA_2_39_sum_reg <= FA_2_39_sum; FA_2_39_carry_reg <= FA_2_39_carry;
			FA_2_40_sum_reg <= FA_2_40_sum; FA_2_40_carry_reg <= FA_2_40_carry;
			FA_2_41_sum_reg <= FA_2_41_sum; FA_2_41_carry_reg <= FA_2_41_carry;
			FA_2_42_sum_reg <= FA_2_42_sum; FA_2_42_carry_reg <= FA_2_42_carry;
			FA_2_43_sum_reg <= FA_2_43_sum; FA_2_43_carry_reg <= FA_2_43_carry;
			FA_2_44_sum_reg <= FA_2_44_sum; FA_2_44_carry_reg <= FA_2_44_carry;
			FA_2_45_sum_reg <= FA_2_45_sum; FA_2_45_carry_reg <= FA_2_45_carry;
			FA_2_46_sum_reg <= FA_2_46_sum; FA_2_46_carry_reg <= FA_2_46_carry;
			FA_2_47_sum_reg <= FA_2_47_sum; FA_2_47_carry_reg <= FA_2_47_carry;
			FA_2_48_sum_reg <= FA_2_48_sum; FA_2_48_carry_reg <= FA_2_48_carry;
			FA_2_49_sum_reg <= FA_2_49_sum; FA_2_49_carry_reg <= FA_2_49_carry;
			FA_2_50_sum_reg <= FA_2_50_sum; FA_2_50_carry_reg <= FA_2_50_carry;
			FA_2_51_sum_reg <= FA_2_51_sum; FA_2_51_carry_reg <= FA_2_51_carry;
			FA_2_52_sum_reg <= FA_2_52_sum; FA_2_52_carry_reg <= FA_2_52_carry;
			FA_2_53_sum_reg <= FA_2_53_sum; FA_2_53_carry_reg <= FA_2_53_carry;
			FA_2_54_sum_reg <= FA_2_54_sum; FA_2_54_carry_reg <= FA_2_54_carry;
			FA_2_55_sum_reg <= FA_2_55_sum; FA_2_55_carry_reg <= FA_2_55_carry;
			FA_2_56_sum_reg <= FA_2_56_sum; FA_2_56_carry_reg <= FA_2_56_carry;
			FA_2_57_sum_reg <= FA_2_57_sum; FA_2_57_carry_reg <= FA_2_57_carry;
			FA_2_58_sum_reg <= FA_2_58_sum; FA_2_58_carry_reg <= FA_2_58_carry;
			FA_2_59_sum_reg <= FA_2_59_sum; FA_2_59_carry_reg <= FA_2_59_carry;
			FA_2_60_sum_reg <= FA_2_60_sum; FA_2_60_carry_reg <= FA_2_60_carry;
			FA_2_61_sum_reg <= FA_2_61_sum; FA_2_61_carry_reg <= FA_2_61_carry;
			FA_2_62_sum_reg <= FA_2_62_sum; FA_2_62_carry_reg <= FA_2_62_carry;
			FA_2_63_sum_reg <= FA_2_63_sum; FA_2_63_carry_reg <= FA_2_63_carry;
			FA_2_64_sum_reg <= FA_2_64_sum; FA_2_64_carry_reg <= FA_2_64_carry;
			FA_2_65_sum_reg <= FA_2_65_sum; FA_2_65_carry_reg <= FA_2_65_carry;
			FA_2_66_sum_reg <= FA_2_66_sum; FA_2_66_carry_reg <= FA_2_66_carry;
			FA_2_67_sum_reg <= FA_2_67_sum; FA_2_67_carry_reg <= FA_2_67_carry;
			FA_2_68_sum_reg <= FA_2_68_sum; FA_2_68_carry_reg <= FA_2_68_carry;
			FA_2_69_sum_reg <= FA_2_69_sum; FA_2_69_carry_reg <= FA_2_69_carry;
			FA_2_70_sum_reg <= FA_2_70_sum; FA_2_70_carry_reg <= FA_2_70_carry;
			FA_2_71_sum_reg <= FA_2_71_sum; FA_2_71_carry_reg <= FA_2_71_carry;
			FA_2_72_sum_reg <= FA_2_72_sum; FA_2_72_carry_reg <= FA_2_72_carry;
			FA_2_73_sum_reg <= FA_2_73_sum; FA_2_73_carry_reg <= FA_2_73_carry;
			FA_2_74_sum_reg <= FA_2_74_sum; FA_2_74_carry_reg <= FA_2_74_carry;
			FA_2_75_sum_reg <= FA_2_75_sum; FA_2_75_carry_reg <= FA_2_75_carry;
			FA_2_76_sum_reg <= FA_2_76_sum; FA_2_76_carry_reg <= FA_2_76_carry;
			FA_2_77_sum_reg <= FA_2_77_sum; FA_2_77_carry_reg <= FA_2_77_carry;
			FA_2_78_sum_reg <= FA_2_78_sum; FA_2_78_carry_reg <= FA_2_78_carry;
			FA_2_79_sum_reg <= FA_2_79_sum; FA_2_79_carry_reg <= FA_2_79_carry;
			FA_2_80_sum_reg <= FA_2_80_sum; FA_2_80_carry_reg <= FA_2_80_carry;
			FA_2_81_sum_reg <= FA_2_81_sum; FA_2_81_carry_reg <= FA_2_81_carry;
			FA_2_82_sum_reg <= FA_2_82_sum; FA_2_82_carry_reg <= FA_2_82_carry;
			FA_2_83_sum_reg <= FA_2_83_sum; FA_2_83_carry_reg <= FA_2_83_carry;
			FA_2_84_sum_reg <= FA_2_84_sum; FA_2_84_carry_reg <= FA_2_84_carry;
			FA_2_85_sum_reg <= FA_2_85_sum; FA_2_85_carry_reg <= FA_2_85_carry;
			FA_2_86_sum_reg <= FA_2_86_sum; FA_2_86_carry_reg <= FA_2_86_carry;
			FA_2_87_sum_reg <= FA_2_87_sum; FA_2_87_carry_reg <= FA_2_87_carry;
			FA_2_88_sum_reg <= FA_2_88_sum; FA_2_88_carry_reg <= FA_2_88_carry;
			FA_2_89_sum_reg <= FA_2_89_sum; FA_2_89_carry_reg <= FA_2_89_carry;
			FA_2_90_sum_reg <= FA_2_90_sum; FA_2_90_carry_reg <= FA_2_90_carry;
			FA_2_91_sum_reg <= FA_2_91_sum; FA_2_91_carry_reg <= FA_2_91_carry;
			FA_2_92_sum_reg <= FA_2_92_sum; FA_2_92_carry_reg <= FA_2_92_carry;
			FA_2_93_sum_reg <= FA_2_93_sum; FA_2_93_carry_reg <= FA_2_93_carry;
			FA_2_94_sum_reg <= FA_2_94_sum; FA_2_94_carry_reg <= FA_2_94_carry;
			FA_2_95_sum_reg <= FA_2_95_sum; FA_2_95_carry_reg <= FA_2_95_carry;
			FA_2_96_sum_reg <= FA_2_96_sum; FA_2_96_carry_reg <= FA_2_96_carry;
			FA_2_97_sum_reg <= FA_2_97_sum; FA_2_97_carry_reg <= FA_2_97_carry;
			FA_2_98_sum_reg <= FA_2_98_sum; FA_2_98_carry_reg <= FA_2_98_carry;
			FA_2_99_sum_reg <= FA_2_99_sum; FA_2_99_carry_reg <= FA_2_99_carry;
			FA_2_100_sum_reg <= FA_2_100_sum; FA_2_100_carry_reg <= FA_2_100_carry;
			FA_2_101_sum_reg <= FA_2_101_sum; FA_2_101_carry_reg <= FA_2_101_carry;
			FA_2_102_sum_reg <= FA_2_102_sum; FA_2_102_carry_reg <= FA_2_102_carry;
			FA_2_103_sum_reg <= FA_2_103_sum; FA_2_103_carry_reg <= FA_2_103_carry;
			FA_2_104_sum_reg <= FA_2_104_sum; FA_2_104_carry_reg <= FA_2_104_carry;
			FA_2_105_sum_reg <= FA_2_105_sum; FA_2_105_carry_reg <= FA_2_105_carry;
			FA_2_106_sum_reg <= FA_2_106_sum; FA_2_106_carry_reg <= FA_2_106_carry;
			FA_2_107_sum_reg <= FA_2_107_sum; FA_2_107_carry_reg <= FA_2_107_carry;
			FA_2_108_sum_reg <= FA_2_108_sum; FA_2_108_carry_reg <= FA_2_108_carry;
			FA_2_109_sum_reg <= FA_2_109_sum; FA_2_109_carry_reg <= FA_2_109_carry;
			FA_2_110_sum_reg <= FA_2_110_sum; FA_2_110_carry_reg <= FA_2_110_carry;
			FA_2_111_sum_reg <= FA_2_111_sum; FA_2_111_carry_reg <= FA_2_111_carry;
			FA_2_112_sum_reg <= FA_2_112_sum; FA_2_112_carry_reg <= FA_2_112_carry;
			FA_2_113_sum_reg <= FA_2_113_sum; FA_2_113_carry_reg <= FA_2_113_carry;
			FA_2_114_sum_reg <= FA_2_114_sum; FA_2_114_carry_reg <= FA_2_114_carry;
			FA_2_115_sum_reg <= FA_2_115_sum; FA_2_115_carry_reg <= FA_2_115_carry;
			FA_2_116_sum_reg <= FA_2_116_sum; FA_2_116_carry_reg <= FA_2_116_carry;
			FA_2_117_sum_reg <= FA_2_117_sum; FA_2_117_carry_reg <= FA_2_117_carry;
			FA_2_118_sum_reg <= FA_2_118_sum; FA_2_118_carry_reg <= FA_2_118_carry;
			FA_2_119_sum_reg <= FA_2_119_sum; FA_2_119_carry_reg <= FA_2_119_carry;
			FA_2_120_sum_reg <= FA_2_120_sum; FA_2_120_carry_reg <= FA_2_120_carry;
			FA_2_121_sum_reg <= FA_2_121_sum; FA_2_121_carry_reg <= FA_2_121_carry;
			FA_2_122_sum_reg <= FA_2_122_sum; FA_2_122_carry_reg <= FA_2_122_carry;
			FA_2_123_sum_reg <= FA_2_123_sum; FA_2_123_carry_reg <= FA_2_123_carry;
			FA_2_124_sum_reg <= FA_2_124_sum; FA_2_124_carry_reg <= FA_2_124_carry;
			FA_2_125_sum_reg <= FA_2_125_sum; FA_2_125_carry_reg <= FA_2_125_carry;
			FA_2_126_sum_reg <= FA_2_126_sum; FA_2_126_carry_reg <= FA_2_126_carry;
			FA_2_127_sum_reg <= FA_2_127_sum; FA_2_127_carry_reg <= FA_2_127_carry;
			FA_2_128_sum_reg <= FA_2_128_sum; FA_2_128_carry_reg <= FA_2_128_carry;
			FA_2_129_sum_reg <= FA_2_129_sum; FA_2_129_carry_reg <= FA_2_129_carry;
			FA_2_130_sum_reg <= FA_2_130_sum; FA_2_130_carry_reg <= FA_2_130_carry;
			FA_2_131_sum_reg <= FA_2_131_sum; FA_2_131_carry_reg <= FA_2_131_carry;
			FA_2_132_sum_reg <= FA_2_132_sum; FA_2_132_carry_reg <= FA_2_132_carry;
			FA_2_133_sum_reg <= FA_2_133_sum; FA_2_133_carry_reg <= FA_2_133_carry;
			FA_2_134_sum_reg <= FA_2_134_sum; FA_2_134_carry_reg <= FA_2_134_carry;
			FA_2_135_sum_reg <= FA_2_135_sum; FA_2_135_carry_reg <= FA_2_135_carry;
			FA_2_136_sum_reg <= FA_2_136_sum; FA_2_136_carry_reg <= FA_2_136_carry;
			FA_2_137_sum_reg <= FA_2_137_sum; FA_2_137_carry_reg <= FA_2_137_carry;
			FA_2_138_sum_reg <= FA_2_138_sum; FA_2_138_carry_reg <= FA_2_138_carry;
			FA_2_139_sum_reg <= FA_2_139_sum; FA_2_139_carry_reg <= FA_2_139_carry;
			FA_2_140_sum_reg <= FA_2_140_sum; FA_2_140_carry_reg <= FA_2_140_carry;
			FA_2_141_sum_reg <= FA_2_141_sum; FA_2_141_carry_reg <= FA_2_141_carry;
			FA_2_142_sum_reg <= FA_2_142_sum; FA_2_142_carry_reg <= FA_2_142_carry;
			FA_2_143_sum_reg <= FA_2_143_sum; FA_2_143_carry_reg <= FA_2_143_carry;
			FA_2_144_sum_reg <= FA_2_144_sum; FA_2_144_carry_reg <= FA_2_144_carry;
			FA_2_145_sum_reg <= FA_2_145_sum; FA_2_145_carry_reg <= FA_2_145_carry;
			FA_2_146_sum_reg <= FA_2_146_sum; FA_2_146_carry_reg <= FA_2_146_carry;
			
			HA_2_1_sum_reg <= HA_2_1_sum; HA_2_1_carry_reg <= HA_2_1_carry;
			HA_2_2_sum_reg <= HA_2_2_sum; HA_2_2_carry_reg <= HA_2_2_carry;
			HA_2_3_sum_reg <= HA_2_3_sum; HA_2_3_carry_reg <= HA_2_3_carry;
			HA_2_4_sum_reg <= HA_2_4_sum; HA_2_4_carry_reg <= HA_2_4_carry;
			HA_2_5_sum_reg <= HA_2_5_sum; HA_2_5_carry_reg <= HA_2_5_carry;
			HA_2_6_sum_reg <= HA_2_6_sum; HA_2_6_carry_reg <= HA_2_6_carry;
			HA_2_7_sum_reg <= HA_2_7_sum; HA_2_7_carry_reg <= HA_2_7_carry;
			HA_2_8_sum_reg <= HA_2_8_sum; HA_2_8_carry_reg <= HA_2_8_carry;
			HA_2_9_sum_reg <= HA_2_9_sum; HA_2_9_carry_reg <= HA_2_9_carry;
			HA_2_10_sum_reg <= HA_2_10_sum; HA_2_10_carry_reg <= HA_2_10_carry;
			HA_2_11_sum_reg <= HA_2_11_sum; HA_2_11_carry_reg <= HA_2_11_carry;
			HA_2_12_sum_reg <= HA_2_12_sum; HA_2_12_carry_reg <= HA_2_12_carry;
			HA_2_13_sum_reg <= HA_2_13_sum; HA_2_13_carry_reg <= HA_2_13_carry;
			HA_2_14_sum_reg <= HA_2_14_sum; HA_2_14_carry_reg <= HA_2_14_carry;
			HA_2_15_sum_reg <= HA_2_15_sum; HA_2_15_carry_reg <= HA_2_15_carry;
			HA_2_16_sum_reg <= HA_2_16_sum; HA_2_16_carry_reg <= HA_2_16_carry;
			HA_2_17_sum_reg <= HA_2_17_sum; HA_2_17_carry_reg <= HA_2_17_carry;
			HA_2_18_sum_reg <= HA_2_18_sum; HA_2_18_carry_reg <= HA_2_18_carry;
			HA_2_19_sum_reg <= HA_2_19_sum; HA_2_19_carry_reg <= HA_2_19_carry;
			HA_2_20_sum_reg <= HA_2_20_sum; HA_2_20_carry_reg <= HA_2_20_carry;
			HA_2_21_sum_reg <= HA_2_21_sum; HA_2_21_carry_reg <= HA_2_21_carry;
			HA_2_22_sum_reg <= HA_2_22_sum; HA_2_22_carry_reg <= HA_2_22_carry;
			HA_2_23_sum_reg <= HA_2_23_sum; HA_2_23_carry_reg <= HA_2_23_carry;
			HA_2_24_sum_reg <= HA_2_24_sum; HA_2_24_carry_reg <= HA_2_24_carry;
			HA_2_25_sum_reg <= HA_2_25_sum; HA_2_25_carry_reg <= HA_2_25_carry;
			HA_2_26_sum_reg <= HA_2_26_sum; HA_2_26_carry_reg <= HA_2_26_carry;
			HA_2_27_sum_reg <= HA_2_27_sum; HA_2_27_carry_reg <= HA_2_27_carry;
			HA_2_28_sum_reg <= HA_2_28_sum; HA_2_28_carry_reg <= HA_2_28_carry;
			HA_2_29_sum_reg <= HA_2_29_sum; HA_2_29_carry_reg <= HA_2_29_carry;
			HA_2_30_sum_reg <= HA_2_30_sum; HA_2_30_carry_reg <= HA_2_30_carry;
			HA_2_31_sum_reg <= HA_2_31_sum; HA_2_31_carry_reg <= HA_2_31_carry;
			HA_2_32_sum_reg <= HA_2_32_sum; HA_2_32_carry_reg <= HA_2_32_carry;
			HA_2_33_sum_reg <= HA_2_33_sum; HA_2_33_carry_reg <= HA_2_33_carry;
			HA_2_34_sum_reg <= HA_2_34_sum; HA_2_34_carry_reg <= HA_2_34_carry;
			HA_2_35_sum_reg <= HA_2_35_sum; HA_2_35_carry_reg <= HA_2_35_carry;
			HA_2_36_sum_reg <= HA_2_36_sum; HA_2_36_carry_reg <= HA_2_36_carry;
			HA_2_37_sum_reg <= HA_2_37_sum; HA_2_37_carry_reg <= HA_2_37_carry;
			HA_2_38_sum_reg <= HA_2_38_sum; HA_2_38_carry_reg <= HA_2_38_carry;
			HA_2_39_sum_reg <= HA_2_39_sum; HA_2_39_carry_reg <= HA_2_39_carry;
			HA_2_40_sum_reg <= HA_2_40_sum; HA_2_40_carry_reg <= HA_2_40_carry;
			HA_2_41_sum_reg <= HA_2_41_sum; HA_2_41_carry_reg <= HA_2_41_carry;
			
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
			P12_double <= P12;
			P13_double <= P13;
			P14_double <= P14;
			P15_double <= P15;
			P16_double <= P16;
		end
	end

	always @(posedge clk or negedge rst) begin
		if(!rst) begin
			HA1_sum_reg   <= 0;
			HA1_carry_reg <= 0;
			HA2_sum_reg   <= 0;
			HA2_carry_reg <= 0;
			HA3_sum_reg   <= 0;
			HA3_carry_reg <= 0;
			HA4_sum_reg   <= 0;
			HA4_carry_reg <= 0;
			HA5_sum_reg   <= 0;
			HA5_carry_reg <= 0;
			HA6_sum_reg   <= 0;
			HA6_carry_reg <= 0;
			HA7_sum_reg   <= 0;
			HA7_carry_reg <= 0;
			HA8_sum_reg   <= 0;
			HA8_carry_reg <= 0;
			HA9_sum_reg   <= 0;
			HA9_carry_reg <= 0;
			HA10_sum_reg  <= 0;
			HA10_carry_reg<= 0;
			HA11_sum_reg  <= 0;
			HA11_carry_reg<= 0;
			HA12_sum_reg  <= 0;
			HA12_carry_reg<= 0;
			HA13_sum_reg  <= 0;
			HA13_carry_reg<= 0;
			HA14_sum_reg  <= 0;
			HA14_carry_reg<= 0;
			HA15_sum_reg  <= 0;
			HA15_carry_reg<= 0;
			HA16_sum_reg  <= 0;
			HA16_carry_reg<= 0;
			HA17_sum_reg  <= 0;
			HA17_carry_reg<= 0;
			HA18_sum_reg  <= 0;
			HA18_carry_reg<= 0;
			HA19_sum_reg  <= 0;
			HA19_carry_reg<= 0;
			HA20_sum_reg  <= 0;
			HA20_carry_reg<= 0;
			HA21_sum_reg  <= 0;
			HA21_carry_reg<= 0;
			HA22_sum_reg  <= 0;
			HA22_carry_reg<= 0;
			HA23_sum_reg  <= 0;
			HA23_carry_reg<= 0;
			HA24_sum_reg  <= 0;
			HA24_carry_reg<= 0;
			

			FA1_sum_reg  <= 0; FA1_carry_reg  <= 0;
			FA2_sum_reg  <= 0; FA2_carry_reg  <= 0;
			FA3_sum_reg  <= 0; FA3_carry_reg  <= 0;
			FA4_sum_reg  <= 0; FA4_carry_reg  <= 0;
			FA5_sum_reg  <= 0; FA5_carry_reg  <= 0;
			FA6_sum_reg  <= 0; FA6_carry_reg  <= 0;
			FA7_sum_reg  <= 0; FA7_carry_reg  <= 0;
			FA8_sum_reg  <= 0; FA8_carry_reg  <= 0;
			FA9_sum_reg  <= 0; FA9_carry_reg  <= 0;
			FA10_sum_reg  <= 0; FA10_carry_reg  <= 0;
			FA11_sum_reg  <= 0; FA11_carry_reg  <= 0;
			FA12_sum_reg  <= 0; FA12_carry_reg  <= 0;
			FA13_sum_reg  <= 0; FA13_carry_reg  <= 0;
			FA14_sum_reg  <= 0; FA14_carry_reg  <= 0;
			FA15_sum_reg  <= 0; FA15_carry_reg  <= 0;
			FA16_sum_reg  <= 0; FA16_carry_reg  <= 0;
			FA17_sum_reg  <= 0; FA17_carry_reg  <= 0;
			FA18_sum_reg  <= 0; FA18_carry_reg  <= 0;
			FA19_sum_reg  <= 0; FA19_carry_reg  <= 0;
			FA20_sum_reg  <= 0; FA20_carry_reg  <= 0;
			FA21_sum_reg  <= 0; FA21_carry_reg  <= 0;
			FA22_sum_reg  <= 0; FA22_carry_reg  <= 0;
			FA23_sum_reg  <= 0; FA23_carry_reg  <= 0;
			FA24_sum_reg  <= 0; FA24_carry_reg  <= 0;
			FA25_sum_reg  <= 0; FA25_carry_reg  <= 0;
			FA26_sum_reg  <= 0; FA26_carry_reg  <= 0;
			FA27_sum_reg  <= 0; FA27_carry_reg  <= 0;
			FA28_sum_reg  <= 0; FA28_carry_reg  <= 0;
			FA29_sum_reg  <= 0; FA29_carry_reg  <= 0;
			FA30_sum_reg  <= 0; FA30_carry_reg  <= 0;
			FA31_sum_reg  <= 0; FA31_carry_reg  <= 0;
			FA32_sum_reg  <= 0; FA32_carry_reg  <= 0;
			FA33_sum_reg  <= 0; FA33_carry_reg  <= 0;
			FA34_sum_reg  <= 0; FA34_carry_reg  <= 0;
			FA35_sum_reg  <= 0; FA35_carry_reg  <= 0;
			FA36_sum_reg  <= 0; FA36_carry_reg  <= 0;
			FA37_sum_reg  <= 0; FA37_carry_reg  <= 0;
			FA38_sum_reg  <= 0; FA38_carry_reg  <= 0;
			FA39_sum_reg  <= 0; FA39_carry_reg  <= 0;
			FA40_sum_reg  <= 0; FA40_carry_reg  <= 0;
			FA41_sum_reg  <= 0; FA41_carry_reg  <= 0;
			FA42_sum_reg  <= 0; FA42_carry_reg  <= 0;
			FA43_sum_reg  <= 0; FA43_carry_reg  <= 0;
			FA44_sum_reg  <= 0; FA44_carry_reg  <= 0;
			FA45_sum_reg  <= 0; FA45_carry_reg  <= 0;
			FA46_sum_reg  <= 0; FA46_carry_reg  <= 0;
			FA47_sum_reg  <= 0; FA47_carry_reg  <= 0;
			FA48_sum_reg  <= 0; FA48_carry_reg  <= 0;
			FA49_sum_reg  <= 0; FA49_carry_reg  <= 0;
			FA50_sum_reg  <= 0; FA50_carry_reg  <= 0;
			FA51_sum_reg  <= 0; FA51_carry_reg  <= 0;
			FA52_sum_reg  <= 0; FA52_carry_reg  <= 0;
			FA53_sum_reg  <= 0; FA53_carry_reg  <= 0;
			FA54_sum_reg  <= 0; FA54_carry_reg  <= 0;
			FA55_sum_reg  <= 0; FA55_carry_reg  <= 0;
			FA56_sum_reg  <= 0; FA56_carry_reg  <= 0;
			FA57_sum_reg  <= 0; FA57_carry_reg  <= 0;
			FA58_sum_reg  <= 0; FA58_carry_reg  <= 0;
			FA59_sum_reg  <= 0; FA59_carry_reg  <= 0;
			FA60_sum_reg  <= 0; FA60_carry_reg  <= 0;
			FA61_sum_reg  <= 0; FA61_carry_reg  <= 0;
			FA62_sum_reg  <= 0; FA62_carry_reg  <= 0;
			FA63_sum_reg  <= 0; FA63_carry_reg  <= 0;
			FA64_sum_reg  <= 0; FA64_carry_reg  <= 0;
			FA65_sum_reg  <= 0; FA65_carry_reg  <= 0;
			FA66_sum_reg  <= 0; FA66_carry_reg  <= 0;
			FA67_sum_reg  <= 0; FA67_carry_reg  <= 0;
			FA68_sum_reg  <= 0; FA68_carry_reg  <= 0;
			FA69_sum_reg  <= 0; FA69_carry_reg  <= 0;
			FA70_sum_reg  <= 0; FA70_carry_reg  <= 0;
			FA71_sum_reg  <= 0; FA71_carry_reg  <= 0;
			FA72_sum_reg  <= 0; FA72_carry_reg  <= 0;
			FA73_sum_reg  <= 0; FA73_carry_reg  <= 0;
			FA74_sum_reg  <= 0; FA74_carry_reg  <= 0;
			FA75_sum_reg  <= 0; FA75_carry_reg  <= 0;
			FA76_sum_reg  <= 0; FA76_carry_reg  <= 0;
			FA77_sum_reg  <= 0; FA77_carry_reg  <= 0;
			FA78_sum_reg  <= 0; FA78_carry_reg  <= 0;
			FA79_sum_reg  <= 0; FA79_carry_reg  <= 0;
			FA80_sum_reg  <= 0; FA80_carry_reg  <= 0;
			FA81_sum_reg  <= 0; FA81_carry_reg  <= 0;
			FA82_sum_reg  <= 0; FA82_carry_reg  <= 0;
			FA83_sum_reg  <= 0; FA83_carry_reg  <= 0;
			FA84_sum_reg  <= 0; FA84_carry_reg  <= 0;
			FA85_sum_reg  <= 0; FA85_carry_reg  <= 0;
			FA86_sum_reg  <= 0; FA86_carry_reg  <= 0;
			FA87_sum_reg  <= 0; FA87_carry_reg  <= 0;
			FA88_sum_reg  <= 0; FA88_carry_reg  <= 0;
			FA89_sum_reg  <= 0; FA89_carry_reg  <= 0;
			FA90_sum_reg  <= 0; FA90_carry_reg  <= 0;
			FA91_sum_reg  <= 0; FA91_carry_reg  <= 0;
			FA92_sum_reg  <= 0; FA92_carry_reg  <= 0;
			FA93_sum_reg  <= 0; FA93_carry_reg  <= 0;
			FA94_sum_reg  <= 0; FA94_carry_reg  <= 0;
			FA95_sum_reg  <= 0; FA95_carry_reg  <= 0;
			FA96_sum_reg  <= 0; FA96_carry_reg  <= 0;
			FA97_sum_reg  <= 0; FA97_carry_reg  <= 0;
			FA98_sum_reg  <= 0; FA98_carry_reg  <= 0;
			FA99_sum_reg  <= 0; FA99_carry_reg  <= 0;
			FA100_sum_reg  <= 0; FA100_carry_reg  <= 0;
			FA101_sum_reg  <= 0; FA101_carry_reg  <= 0;
			FA102_sum_reg  <= 0; FA102_carry_reg  <= 0;
			FA103_sum_reg  <= 0; FA103_carry_reg  <= 0;
			FA104_sum_reg  <= 0; FA104_carry_reg  <= 0;
			FA105_sum_reg  <= 0; FA105_carry_reg  <= 0;
			FA106_sum_reg  <= 0; FA106_carry_reg  <= 0;
			FA107_sum_reg  <= 0; FA107_carry_reg  <= 0;
			FA108_sum_reg  <= 0; FA108_carry_reg  <= 0;
			FA109_sum_reg  <= 0; FA109_carry_reg  <= 0;
			FA110_sum_reg  <= 0; FA110_carry_reg  <= 0;
			FA111_sum_reg  <= 0; FA111_carry_reg  <= 0;
			FA112_sum_reg  <= 0; FA112_carry_reg  <= 0;
			FA113_sum_reg  <= 0; FA113_carry_reg  <= 0;
			FA114_sum_reg  <= 0; FA114_carry_reg  <= 0;
			FA115_sum_reg  <= 0; FA115_carry_reg  <= 0;
			FA116_sum_reg  <= 0; FA116_carry_reg  <= 0;
			FA117_sum_reg  <= 0; FA117_carry_reg  <= 0;
			FA118_sum_reg  <= 0; FA118_carry_reg  <= 0;
			FA119_sum_reg  <= 0; FA119_carry_reg  <= 0;
			FA120_sum_reg  <= 0; FA120_carry_reg  <= 0;
			FA121_sum_reg  <= 0; FA121_carry_reg  <= 0;
			FA122_sum_reg  <= 0; FA122_carry_reg  <= 0;
			FA123_sum_reg  <= 0; FA123_carry_reg  <= 0;
			FA124_sum_reg  <= 0; FA124_carry_reg  <= 0;
			FA125_sum_reg  <= 0; FA125_carry_reg  <= 0;
			FA126_sum_reg  <= 0; FA126_carry_reg  <= 0;
			FA127_sum_reg  <= 0; FA127_carry_reg  <= 0;
			FA128_sum_reg  <= 0; FA128_carry_reg  <= 0;
			FA129_sum_reg  <= 0; FA129_carry_reg  <= 0;
			FA130_sum_reg  <= 0; FA130_carry_reg  <= 0;
			FA131_sum_reg  <= 0; FA131_carry_reg  <= 0;
			FA132_sum_reg  <= 0; FA132_carry_reg  <= 0;
			FA133_sum_reg  <= 0; FA133_carry_reg  <= 0;
			FA134_sum_reg  <= 0; FA134_carry_reg  <= 0;
			FA135_sum_reg  <= 0; FA135_carry_reg  <= 0;
			FA136_sum_reg  <= 0; FA136_carry_reg  <= 0;
			FA137_sum_reg  <= 0; FA137_carry_reg  <= 0;
			FA138_sum_reg  <= 0; FA138_carry_reg  <= 0;
			FA139_sum_reg  <= 0; FA139_carry_reg  <= 0;
			FA140_sum_reg  <= 0; FA140_carry_reg  <= 0;
			FA141_sum_reg  <= 0; FA141_carry_reg  <= 0;
			FA142_sum_reg  <= 0; FA142_carry_reg  <= 0;
			FA143_sum_reg  <= 0; FA143_carry_reg  <= 0;
			FA144_sum_reg  <= 0; FA144_carry_reg  <= 0;
			FA145_sum_reg  <= 0; FA145_carry_reg  <= 0;
			FA146_sum_reg  <= 0; FA146_carry_reg  <= 0;
			FA147_sum_reg  <= 0; FA147_carry_reg  <= 0;
			FA148_sum_reg  <= 0; FA148_carry_reg  <= 0;
			FA149_sum_reg  <= 0; FA149_carry_reg  <= 0;
			FA150_sum_reg  <= 0; FA150_carry_reg  <= 0;
			FA151_sum_reg  <= 0; FA151_carry_reg  <= 0;
			FA152_sum_reg  <= 0; FA152_carry_reg  <= 0;
			FA153_sum_reg  <= 0; FA153_carry_reg  <= 0;
			FA154_sum_reg  <= 0; FA154_carry_reg  <= 0;
			FA155_sum_reg  <= 0; FA155_carry_reg  <= 0;
			FA156_sum_reg  <= 0; FA156_carry_reg  <= 0;
			FA157_sum_reg  <= 0; FA157_carry_reg  <= 0;
			FA158_sum_reg  <= 0; FA158_carry_reg  <= 0;
			FA159_sum_reg  <= 0; FA159_carry_reg  <= 0;
			FA160_sum_reg  <= 0; FA160_carry_reg  <= 0;
			FA161_sum_reg  <= 0; FA161_carry_reg  <= 0;
			FA162_sum_reg  <= 0; FA162_carry_reg  <= 0;
			FA163_sum_reg  <= 0; FA163_carry_reg  <= 0;
			FA164_sum_reg  <= 0; FA164_carry_reg  <= 0;
			FA165_sum_reg  <= 0; FA165_carry_reg  <= 0;
			FA166_sum_reg  <= 0; FA166_carry_reg  <= 0;
			FA167_sum_reg  <= 0; FA167_carry_reg  <= 0;
			FA168_sum_reg  <= 0; FA168_carry_reg  <= 0;
			FA169_sum_reg  <= 0; FA169_carry_reg  <= 0;
			FA170_sum_reg  <= 0; FA170_carry_reg  <= 0;
			FA171_sum_reg  <= 0; FA171_carry_reg  <= 0;
			FA172_sum_reg  <= 0; FA172_carry_reg  <= 0;
			FA173_sum_reg  <= 0; FA173_carry_reg  <= 0;
			FA174_sum_reg  <= 0; FA174_carry_reg  <= 0;
			FA175_sum_reg  <= 0; FA175_carry_reg  <= 0;
			FA176_sum_reg  <= 0; FA176_carry_reg  <= 0;
			FA177_sum_reg  <= 0; FA177_carry_reg  <= 0;
			FA178_sum_reg  <= 0; FA178_carry_reg  <= 0;
			FA179_sum_reg  <= 0; FA179_carry_reg  <= 0;
			FA180_sum_reg  <= 0; FA180_carry_reg  <= 0;
			FA181_sum_reg  <= 0; FA181_carry_reg  <= 0;
			FA182_sum_reg  <= 0; FA182_carry_reg  <= 0;
			FA183_sum_reg  <= 0; FA183_carry_reg  <= 0;
			FA184_sum_reg  <= 0; FA184_carry_reg  <= 0;
			FA185_sum_reg  <= 0; FA185_carry_reg  <= 0;
			FA186_sum_reg  <= 0; FA186_carry_reg  <= 0;
			FA187_sum_reg  <= 0; FA187_carry_reg  <= 0;
			FA188_sum_reg  <= 0; FA188_carry_reg  <= 0;
			FA189_sum_reg  <= 0; FA189_carry_reg  <= 0;
			FA190_sum_reg  <= 0; FA190_carry_reg  <= 0;
			FA191_sum_reg  <= 0; FA191_carry_reg  <= 0;
			FA192_sum_reg  <= 0; FA192_carry_reg  <= 0;
			FA193_sum_reg  <= 0; FA193_carry_reg  <= 0;
			FA194_sum_reg  <= 0; FA194_carry_reg  <= 0;
			FA195_sum_reg  <= 0; FA195_carry_reg  <= 0;
			FA196_sum_reg  <= 0; FA196_carry_reg  <= 0;
			FA197_sum_reg  <= 0; FA197_carry_reg  <= 0;
			FA198_sum_reg  <= 0; FA198_carry_reg  <= 0;
			FA199_sum_reg  <= 0; FA199_carry_reg  <= 0;
			FA200_sum_reg  <= 0; FA200_carry_reg  <= 0;
			FA201_sum_reg  <= 0; FA201_carry_reg  <= 0;
			FA202_sum_reg  <= 0; FA202_carry_reg  <= 0;
			FA203_sum_reg  <= 0; FA203_carry_reg  <= 0;
			FA204_sum_reg  <= 0; FA204_carry_reg  <= 0;
			FA205_sum_reg  <= 0; FA205_carry_reg  <= 0;
			FA206_sum_reg  <= 0; FA206_carry_reg  <= 0;
			FA207_sum_reg  <= 0; FA207_carry_reg  <= 0;
			FA208_sum_reg  <= 0; FA208_carry_reg  <= 0;
			FA209_sum_reg  <= 0; FA209_carry_reg  <= 0;
			FA210_sum_reg  <= 0; FA210_carry_reg  <= 0;
			FA211_sum_reg  <= 0; FA211_carry_reg  <= 0;
			FA212_sum_reg  <= 0; FA212_carry_reg  <= 0;
			FA213_sum_reg  <= 0; FA213_carry_reg  <= 0;
			FA214_sum_reg  <= 0; FA214_carry_reg  <= 0;
			FA215_sum_reg  <= 0; FA215_carry_reg  <= 0;
			FA216_sum_reg  <= 0; FA216_carry_reg  <= 0;
			FA217_sum_reg  <= 0; FA217_carry_reg  <= 0;
			FA218_sum_reg  <= 0; FA218_carry_reg  <= 0;
			FA219_sum_reg  <= 0; FA219_carry_reg  <= 0;
			FA220_sum_reg  <= 0; FA220_carry_reg  <= 0;
			FA221_sum_reg  <= 0; FA221_carry_reg  <= 0;
			FA222_sum_reg  <= 0; FA222_carry_reg  <= 0;
			FA223_sum_reg  <= 0; FA223_carry_reg  <= 0;
			FA224_sum_reg  <= 0; FA224_carry_reg  <= 0;
			FA225_sum_reg  <= 0; FA225_carry_reg  <= 0;
			FA226_sum_reg  <= 0; FA226_carry_reg  <= 0;
			FA227_sum_reg  <= 0; FA227_carry_reg  <= 0;
			FA228_sum_reg  <= 0; FA228_carry_reg  <= 0;
			FA229_sum_reg  <= 0; FA229_carry_reg  <= 0;
			FA230_sum_reg  <= 0; FA230_carry_reg  <= 0;
			FA231_sum_reg  <= 0; FA231_carry_reg  <= 0;
			FA232_sum_reg  <= 0; FA232_carry_reg  <= 0;
			FA233_sum_reg  <= 0; FA233_carry_reg  <= 0;
			FA234_sum_reg  <= 0; FA234_carry_reg  <= 0;
			FA235_sum_reg  <= 0; FA235_carry_reg  <= 0;
			FA236_sum_reg  <= 0; FA236_carry_reg  <= 0;
			FA237_sum_reg  <= 0; FA237_carry_reg  <= 0;
			FA238_sum_reg  <= 0; FA238_carry_reg  <= 0;
			FA239_sum_reg  <= 0; FA239_carry_reg  <= 0;		
		end
		else begin
			HA1_sum_reg   <= HA1_sum;
			HA1_carry_reg <= HA1_carry;
			HA2_sum_reg   <= HA2_sum;
			HA2_carry_reg <= HA2_carry;
			HA3_sum_reg   <= HA3_sum;
			HA3_carry_reg <= HA3_carry;
			HA4_sum_reg   <= HA4_sum;
			HA4_carry_reg <= HA4_carry;
			HA5_sum_reg   <= HA5_sum;
			HA5_carry_reg <= HA5_carry;
			HA6_sum_reg   <= HA6_sum;
			HA6_carry_reg <= HA6_carry;
			HA7_sum_reg   <= HA7_sum;
			HA7_carry_reg <= HA7_carry;
			HA8_sum_reg   <= HA8_sum;
			HA8_carry_reg <= HA8_carry;
			HA9_sum_reg   <= HA9_sum;
			HA9_carry_reg <= HA9_carry;
			HA10_sum_reg  <= HA10_sum;
			HA10_carry_reg<= HA10_carry;
			HA11_sum_reg  <= HA11_sum;
			HA11_carry_reg<= HA11_carry;
			HA12_sum_reg  <= HA12_sum;
			HA12_carry_reg<= HA12_carry;
			HA13_sum_reg  <= HA13_sum;
			HA13_carry_reg<= HA13_carry;
			HA14_sum_reg  <= HA14_sum;
			HA14_carry_reg<= HA14_carry;
			HA15_sum_reg  <= HA15_sum;
			HA15_carry_reg<= HA15_carry;
			HA16_sum_reg  <= HA16_sum;
			HA16_carry_reg<= HA16_carry;
			HA17_sum_reg  <= HA17_sum;
			HA17_carry_reg<= HA17_carry;
			HA18_sum_reg  <= HA18_sum;
			HA18_carry_reg<= HA18_carry;
			HA19_sum_reg  <= HA19_sum;
			HA19_carry_reg<= HA19_carry;
			HA20_sum_reg  <= HA20_sum;
			HA20_carry_reg<= HA20_carry;
			HA21_sum_reg  <= HA21_sum;
			HA21_carry_reg<= HA21_carry;
			HA22_sum_reg  <= HA22_sum;
			HA22_carry_reg<= HA22_carry;
			HA23_sum_reg  <= HA23_sum;
			HA23_carry_reg<= HA23_carry;
			HA24_sum_reg  <= HA24_sum;
			HA24_carry_reg<= HA24_carry;
			
			FA1_sum_reg <= FA1_sum; FA1_carry_reg <= FA1_carry;
			FA2_sum_reg <= FA2_sum; FA2_carry_reg <= FA2_carry;
			FA3_sum_reg <= FA3_sum; FA3_carry_reg <= FA3_carry;
			FA4_sum_reg <= FA4_sum; FA4_carry_reg <= FA4_carry;
			FA5_sum_reg <= FA5_sum; FA5_carry_reg <= FA5_carry;
			FA6_sum_reg <= FA6_sum; FA6_carry_reg <= FA6_carry;
			FA7_sum_reg <= FA7_sum; FA7_carry_reg <= FA7_carry;
			FA8_sum_reg <= FA8_sum; FA8_carry_reg <= FA8_carry;
			FA9_sum_reg <= FA9_sum; FA9_carry_reg <= FA9_carry;
			FA10_sum_reg <= FA10_sum; FA10_carry_reg <= FA10_carry;
			FA11_sum_reg <= FA11_sum; FA11_carry_reg <= FA11_carry;
			FA12_sum_reg <= FA12_sum; FA12_carry_reg <= FA12_carry;
			FA13_sum_reg <= FA13_sum; FA13_carry_reg <= FA13_carry;
			FA14_sum_reg <= FA14_sum; FA14_carry_reg <= FA14_carry;
			FA15_sum_reg <= FA15_sum; FA15_carry_reg <= FA15_carry;
			FA16_sum_reg <= FA16_sum; FA16_carry_reg <= FA16_carry;
			FA17_sum_reg <= FA17_sum; FA17_carry_reg <= FA17_carry;
			FA18_sum_reg <= FA18_sum; FA18_carry_reg <= FA18_carry;
			FA19_sum_reg <= FA19_sum; FA19_carry_reg <= FA19_carry;
			FA20_sum_reg <= FA20_sum; FA20_carry_reg <= FA20_carry;
			FA21_sum_reg <= FA21_sum; FA21_carry_reg <= FA21_carry;
			FA22_sum_reg <= FA22_sum; FA22_carry_reg <= FA22_carry;
			FA23_sum_reg <= FA23_sum; FA23_carry_reg <= FA23_carry;
			FA24_sum_reg <= FA24_sum; FA24_carry_reg <= FA24_carry;
			FA25_sum_reg <= FA25_sum; FA25_carry_reg <= FA25_carry;
			FA26_sum_reg <= FA26_sum; FA26_carry_reg <= FA26_carry;
			FA27_sum_reg <= FA27_sum; FA27_carry_reg <= FA27_carry;
			FA28_sum_reg <= FA28_sum; FA28_carry_reg <= FA28_carry;
			FA29_sum_reg <= FA29_sum; FA29_carry_reg <= FA29_carry;
			FA30_sum_reg <= FA30_sum; FA30_carry_reg <= FA30_carry;
			FA31_sum_reg <= FA31_sum; FA31_carry_reg <= FA31_carry;
			FA32_sum_reg <= FA32_sum; FA32_carry_reg <= FA32_carry;
			FA33_sum_reg <= FA33_sum; FA33_carry_reg <= FA33_carry;
			FA34_sum_reg <= FA34_sum; FA34_carry_reg <= FA34_carry;
			FA35_sum_reg <= FA35_sum; FA35_carry_reg <= FA35_carry;
			FA36_sum_reg <= FA36_sum; FA36_carry_reg <= FA36_carry;
			FA37_sum_reg <= FA37_sum; FA37_carry_reg <= FA37_carry;
			FA38_sum_reg <= FA38_sum; FA38_carry_reg <= FA38_carry;
			FA39_sum_reg <= FA39_sum; FA39_carry_reg <= FA39_carry;
			FA40_sum_reg <= FA40_sum; FA40_carry_reg <= FA40_carry;
			FA41_sum_reg <= FA41_sum; FA41_carry_reg <= FA41_carry;
			FA42_sum_reg <= FA42_sum; FA42_carry_reg <= FA42_carry;
			FA43_sum_reg <= FA43_sum; FA43_carry_reg <= FA43_carry;
			FA44_sum_reg <= FA44_sum; FA44_carry_reg <= FA44_carry;
			FA45_sum_reg <= FA45_sum; FA45_carry_reg <= FA45_carry;
			FA46_sum_reg <= FA46_sum; FA46_carry_reg <= FA46_carry;
			FA47_sum_reg <= FA47_sum; FA47_carry_reg <= FA47_carry;
			FA48_sum_reg <= FA48_sum; FA48_carry_reg <= FA48_carry;
			FA49_sum_reg <= FA49_sum; FA49_carry_reg <= FA49_carry;
			FA50_sum_reg <= FA50_sum; FA50_carry_reg <= FA50_carry;
			FA51_sum_reg <= FA51_sum; FA51_carry_reg <= FA51_carry;
			FA52_sum_reg <= FA52_sum; FA52_carry_reg <= FA52_carry;
			FA53_sum_reg <= FA53_sum; FA53_carry_reg <= FA53_carry;
			FA54_sum_reg <= FA54_sum; FA54_carry_reg <= FA54_carry;
			FA55_sum_reg <= FA55_sum; FA55_carry_reg <= FA55_carry;
			FA56_sum_reg <= FA56_sum; FA56_carry_reg <= FA56_carry;
			FA57_sum_reg <= FA57_sum; FA57_carry_reg <= FA57_carry;
			FA58_sum_reg <= FA58_sum; FA58_carry_reg <= FA58_carry;
			FA59_sum_reg <= FA59_sum; FA59_carry_reg <= FA59_carry;
			FA60_sum_reg <= FA60_sum; FA60_carry_reg <= FA60_carry;
			FA61_sum_reg <= FA61_sum; FA61_carry_reg <= FA61_carry;
			FA62_sum_reg <= FA62_sum; FA62_carry_reg <= FA62_carry;
			FA63_sum_reg <= FA63_sum; FA63_carry_reg <= FA63_carry;
			FA64_sum_reg <= FA64_sum; FA64_carry_reg <= FA64_carry;
			FA65_sum_reg <= FA65_sum; FA65_carry_reg <= FA65_carry;
			FA66_sum_reg <= FA66_sum; FA66_carry_reg <= FA66_carry;
			FA67_sum_reg <= FA67_sum; FA67_carry_reg <= FA67_carry;
			FA68_sum_reg <= FA68_sum; FA68_carry_reg <= FA68_carry;
			FA69_sum_reg <= FA69_sum; FA69_carry_reg <= FA69_carry;
			FA70_sum_reg <= FA70_sum; FA70_carry_reg <= FA70_carry;
			FA71_sum_reg <= FA71_sum; FA71_carry_reg <= FA71_carry;
			FA72_sum_reg <= FA72_sum; FA72_carry_reg <= FA72_carry;
			FA73_sum_reg <= FA73_sum; FA73_carry_reg <= FA73_carry;
			FA74_sum_reg <= FA74_sum; FA74_carry_reg <= FA74_carry;
			FA75_sum_reg <= FA75_sum; FA75_carry_reg <= FA75_carry;
			FA76_sum_reg <= FA76_sum; FA76_carry_reg <= FA76_carry;
			FA77_sum_reg <= FA77_sum; FA77_carry_reg <= FA77_carry;
			FA78_sum_reg <= FA78_sum; FA78_carry_reg <= FA78_carry;
			FA79_sum_reg <= FA79_sum; FA79_carry_reg <= FA79_carry;
			FA80_sum_reg <= FA80_sum; FA80_carry_reg <= FA80_carry;
			FA81_sum_reg <= FA81_sum; FA81_carry_reg <= FA81_carry;
			FA82_sum_reg <= FA82_sum; FA82_carry_reg <= FA82_carry;
			FA83_sum_reg <= FA83_sum; FA83_carry_reg <= FA83_carry;
			FA84_sum_reg <= FA84_sum; FA84_carry_reg <= FA84_carry;
			FA85_sum_reg <= FA85_sum; FA85_carry_reg <= FA85_carry;
			FA86_sum_reg <= FA86_sum; FA86_carry_reg <= FA86_carry;
			FA87_sum_reg <= FA87_sum; FA87_carry_reg <= FA87_carry;
			FA88_sum_reg <= FA88_sum; FA88_carry_reg <= FA88_carry;
			FA89_sum_reg <= FA89_sum; FA89_carry_reg <= FA89_carry;
			FA90_sum_reg <= FA90_sum; FA90_carry_reg <= FA90_carry;
			FA91_sum_reg <= FA91_sum; FA91_carry_reg <= FA91_carry;
			FA92_sum_reg <= FA92_sum; FA92_carry_reg <= FA92_carry;
			FA93_sum_reg <= FA93_sum; FA93_carry_reg <= FA93_carry;
			FA94_sum_reg <= FA94_sum; FA94_carry_reg <= FA94_carry;
			FA95_sum_reg <= FA95_sum; FA95_carry_reg <= FA95_carry;
			FA96_sum_reg <= FA96_sum; FA96_carry_reg <= FA96_carry;
			FA97_sum_reg <= FA97_sum; FA97_carry_reg <= FA97_carry;
			FA98_sum_reg <= FA98_sum; FA98_carry_reg <= FA98_carry;
			FA99_sum_reg <= FA99_sum; FA99_carry_reg <= FA99_carry;
			FA100_sum_reg <= FA100_sum; FA100_carry_reg <= FA100_carry;
			FA101_sum_reg <= FA101_sum; FA101_carry_reg <= FA101_carry;
			FA102_sum_reg <= FA102_sum; FA102_carry_reg <= FA102_carry;
			FA103_sum_reg <= FA103_sum; FA103_carry_reg <= FA103_carry;
			FA104_sum_reg <= FA104_sum; FA104_carry_reg <= FA104_carry;
			FA105_sum_reg <= FA105_sum; FA105_carry_reg <= FA105_carry;
			FA106_sum_reg <= FA106_sum; FA106_carry_reg <= FA106_carry;
			FA107_sum_reg <= FA107_sum; FA107_carry_reg <= FA107_carry;
			FA108_sum_reg <= FA108_sum; FA108_carry_reg <= FA108_carry;
			FA109_sum_reg <= FA109_sum; FA109_carry_reg <= FA109_carry;
			FA110_sum_reg <= FA110_sum; FA110_carry_reg <= FA110_carry;
			FA111_sum_reg <= FA111_sum; FA111_carry_reg <= FA111_carry;
			FA112_sum_reg <= FA112_sum; FA112_carry_reg <= FA112_carry;
			FA113_sum_reg <= FA113_sum; FA113_carry_reg <= FA113_carry;
			FA114_sum_reg <= FA114_sum; FA114_carry_reg <= FA114_carry;
			FA115_sum_reg <= FA115_sum; FA115_carry_reg <= FA115_carry;
			FA116_sum_reg <= FA116_sum; FA116_carry_reg <= FA116_carry;
			FA117_sum_reg <= FA117_sum; FA117_carry_reg <= FA117_carry;
			FA118_sum_reg <= FA118_sum; FA118_carry_reg <= FA118_carry;
			FA119_sum_reg <= FA119_sum; FA119_carry_reg <= FA119_carry;
			FA120_sum_reg <= FA120_sum; FA120_carry_reg <= FA120_carry;
			FA121_sum_reg <= FA121_sum; FA121_carry_reg <= FA121_carry;
			FA122_sum_reg <= FA122_sum; FA122_carry_reg <= FA122_carry;
			FA123_sum_reg <= FA123_sum; FA123_carry_reg <= FA123_carry;
			FA124_sum_reg <= FA124_sum; FA124_carry_reg <= FA124_carry;
			FA125_sum_reg <= FA125_sum; FA125_carry_reg <= FA125_carry;
			FA126_sum_reg <= FA126_sum; FA126_carry_reg <= FA126_carry;
			FA127_sum_reg <= FA127_sum; FA127_carry_reg <= FA127_carry;
			FA128_sum_reg <= FA128_sum; FA128_carry_reg <= FA128_carry;
			FA129_sum_reg <= FA129_sum; FA129_carry_reg <= FA129_carry;
			FA130_sum_reg <= FA130_sum; FA130_carry_reg <= FA130_carry;
			FA131_sum_reg <= FA131_sum; FA131_carry_reg <= FA131_carry;
			FA132_sum_reg <= FA132_sum; FA132_carry_reg <= FA132_carry;
			FA133_sum_reg <= FA133_sum; FA133_carry_reg <= FA133_carry;
			FA134_sum_reg <= FA134_sum; FA134_carry_reg <= FA134_carry;
			FA135_sum_reg <= FA135_sum; FA135_carry_reg <= FA135_carry;
			FA136_sum_reg <= FA136_sum; FA136_carry_reg <= FA136_carry;
			FA137_sum_reg <= FA137_sum; FA137_carry_reg <= FA137_carry;
			FA138_sum_reg <= FA138_sum; FA138_carry_reg <= FA138_carry;
			FA139_sum_reg <= FA139_sum; FA139_carry_reg <= FA139_carry;
			FA140_sum_reg <= FA140_sum; FA140_carry_reg <= FA140_carry;
			FA141_sum_reg <= FA141_sum; FA141_carry_reg <= FA141_carry;
			FA142_sum_reg <= FA142_sum; FA142_carry_reg <= FA142_carry;
			FA143_sum_reg <= FA143_sum; FA143_carry_reg <= FA143_carry;
			FA144_sum_reg <= FA144_sum; FA144_carry_reg <= FA144_carry;
			FA145_sum_reg <= FA145_sum; FA145_carry_reg <= FA145_carry;
			FA146_sum_reg <= FA146_sum; FA146_carry_reg <= FA146_carry;
			FA147_sum_reg <= FA147_sum; FA147_carry_reg <= FA147_carry;
			FA148_sum_reg <= FA148_sum; FA148_carry_reg <= FA148_carry;
			FA149_sum_reg <= FA149_sum; FA149_carry_reg <= FA149_carry;
			FA150_sum_reg <= FA150_sum; FA150_carry_reg <= FA150_carry;
			FA151_sum_reg <= FA151_sum; FA151_carry_reg <= FA151_carry;
			FA152_sum_reg <= FA152_sum; FA152_carry_reg <= FA152_carry;
			FA153_sum_reg <= FA153_sum; FA153_carry_reg <= FA153_carry;
			FA154_sum_reg <= FA154_sum; FA154_carry_reg <= FA154_carry;
			FA155_sum_reg <= FA155_sum; FA155_carry_reg <= FA155_carry;
			FA156_sum_reg <= FA156_sum; FA156_carry_reg <= FA156_carry;
			FA157_sum_reg <= FA157_sum; FA157_carry_reg <= FA157_carry;
			FA158_sum_reg <= FA158_sum; FA158_carry_reg <= FA158_carry;
			FA159_sum_reg <= FA159_sum; FA159_carry_reg <= FA159_carry;
			FA160_sum_reg <= FA160_sum; FA160_carry_reg <= FA160_carry;
			FA161_sum_reg <= FA161_sum; FA161_carry_reg <= FA161_carry;
			FA162_sum_reg <= FA162_sum; FA162_carry_reg <= FA162_carry;
			FA163_sum_reg <= FA163_sum; FA163_carry_reg <= FA163_carry;
			FA164_sum_reg <= FA164_sum; FA164_carry_reg <= FA164_carry;
			FA165_sum_reg <= FA165_sum; FA165_carry_reg <= FA165_carry;
			FA166_sum_reg <= FA166_sum; FA166_carry_reg <= FA166_carry;
			FA167_sum_reg <= FA167_sum; FA167_carry_reg <= FA167_carry;
			FA168_sum_reg <= FA168_sum; FA168_carry_reg <= FA168_carry;
			FA169_sum_reg <= FA169_sum; FA169_carry_reg <= FA169_carry;
			FA170_sum_reg <= FA170_sum; FA170_carry_reg <= FA170_carry;
			FA171_sum_reg <= FA171_sum; FA171_carry_reg <= FA171_carry;
			FA172_sum_reg <= FA172_sum; FA172_carry_reg <= FA172_carry;
			FA173_sum_reg <= FA173_sum; FA173_carry_reg <= FA173_carry;
			FA174_sum_reg <= FA174_sum; FA174_carry_reg <= FA174_carry;
			FA175_sum_reg <= FA175_sum; FA175_carry_reg <= FA175_carry;
			FA176_sum_reg <= FA176_sum; FA176_carry_reg <= FA176_carry;
			FA177_sum_reg <= FA177_sum; FA177_carry_reg <= FA177_carry;
			FA178_sum_reg <= FA178_sum; FA178_carry_reg <= FA178_carry;
			FA179_sum_reg <= FA179_sum; FA179_carry_reg <= FA179_carry;
			FA180_sum_reg <= FA180_sum; FA180_carry_reg <= FA180_carry;
			FA181_sum_reg <= FA181_sum; FA181_carry_reg <= FA181_carry;
			FA182_sum_reg <= FA182_sum; FA182_carry_reg <= FA182_carry;
			FA183_sum_reg <= FA183_sum; FA183_carry_reg <= FA183_carry;
			FA184_sum_reg <= FA184_sum; FA184_carry_reg <= FA184_carry;
			FA185_sum_reg <= FA185_sum; FA185_carry_reg <= FA185_carry;
			FA186_sum_reg <= FA186_sum; FA186_carry_reg <= FA186_carry;
			FA187_sum_reg <= FA187_sum; FA187_carry_reg <= FA187_carry;
			FA188_sum_reg <= FA188_sum; FA188_carry_reg <= FA188_carry;
			FA189_sum_reg <= FA189_sum; FA189_carry_reg <= FA189_carry;
			FA190_sum_reg <= FA190_sum; FA190_carry_reg <= FA190_carry;
			FA191_sum_reg <= FA191_sum; FA191_carry_reg <= FA191_carry;
			FA192_sum_reg <= FA192_sum; FA192_carry_reg <= FA192_carry;
			FA193_sum_reg <= FA193_sum; FA193_carry_reg <= FA193_carry;
			FA194_sum_reg <= FA194_sum; FA194_carry_reg <= FA194_carry;
			FA195_sum_reg <= FA195_sum; FA195_carry_reg <= FA195_carry;
			FA196_sum_reg <= FA196_sum; FA196_carry_reg <= FA196_carry;
			FA197_sum_reg <= FA197_sum; FA197_carry_reg <= FA197_carry;
			FA198_sum_reg <= FA198_sum; FA198_carry_reg <= FA198_carry;
			FA199_sum_reg <= FA199_sum; FA199_carry_reg <= FA199_carry;
			FA200_sum_reg <= FA200_sum; FA200_carry_reg <= FA200_carry;
			FA201_sum_reg <= FA201_sum; FA201_carry_reg <= FA201_carry;
			FA202_sum_reg <= FA202_sum; FA202_carry_reg <= FA202_carry;
			FA203_sum_reg <= FA203_sum; FA203_carry_reg <= FA203_carry;
			FA204_sum_reg <= FA204_sum; FA204_carry_reg <= FA204_carry;
			FA205_sum_reg <= FA205_sum; FA205_carry_reg <= FA205_carry;
			FA206_sum_reg <= FA206_sum; FA206_carry_reg <= FA206_carry;
			FA207_sum_reg <= FA207_sum; FA207_carry_reg <= FA207_carry;
			FA208_sum_reg <= FA208_sum; FA208_carry_reg <= FA208_carry;
			FA209_sum_reg <= FA209_sum; FA209_carry_reg <= FA209_carry;
			FA210_sum_reg <= FA210_sum; FA210_carry_reg <= FA210_carry;
			FA211_sum_reg <= FA211_sum; FA211_carry_reg <= FA211_carry;
			FA212_sum_reg <= FA212_sum; FA212_carry_reg <= FA212_carry;
			FA213_sum_reg <= FA213_sum; FA213_carry_reg <= FA213_carry;
			FA214_sum_reg <= FA214_sum; FA214_carry_reg <= FA214_carry;
			FA215_sum_reg <= FA215_sum; FA215_carry_reg <= FA215_carry;
			FA216_sum_reg <= FA216_sum; FA216_carry_reg <= FA216_carry;
			FA217_sum_reg <= FA217_sum; FA217_carry_reg <= FA217_carry;
			FA218_sum_reg <= FA218_sum; FA218_carry_reg <= FA218_carry;
			FA219_sum_reg <= FA219_sum; FA219_carry_reg <= FA219_carry;
			FA220_sum_reg <= FA220_sum; FA220_carry_reg <= FA220_carry;
			FA221_sum_reg <= FA221_sum; FA221_carry_reg <= FA221_carry;
			FA222_sum_reg <= FA222_sum; FA222_carry_reg <= FA222_carry;
			FA223_sum_reg <= FA223_sum; FA223_carry_reg <= FA223_carry;
			FA224_sum_reg <= FA224_sum; FA224_carry_reg <= FA224_carry;
			FA225_sum_reg <= FA225_sum; FA225_carry_reg <= FA225_carry;
			FA226_sum_reg <= FA226_sum; FA226_carry_reg <= FA226_carry;
			FA227_sum_reg <= FA227_sum; FA227_carry_reg <= FA227_carry;
			FA228_sum_reg <= FA228_sum; FA228_carry_reg <= FA228_carry;
			FA229_sum_reg <= FA229_sum; FA229_carry_reg <= FA229_carry;
			FA230_sum_reg <= FA230_sum; FA230_carry_reg <= FA230_carry;
			FA231_sum_reg <= FA231_sum; FA231_carry_reg <= FA231_carry;
			FA232_sum_reg <= FA232_sum; FA232_carry_reg <= FA232_carry;
			FA233_sum_reg <= FA233_sum; FA233_carry_reg <= FA233_carry;
			FA234_sum_reg <= FA234_sum; FA234_carry_reg <= FA234_carry;
			FA235_sum_reg <= FA235_sum; FA235_carry_reg <= FA235_carry;
			FA236_sum_reg <= FA236_sum; FA236_carry_reg <= FA236_carry;
			FA237_sum_reg <= FA237_sum; FA237_carry_reg <= FA237_carry;
			FA238_sum_reg <= FA238_sum; FA238_carry_reg <= FA238_carry;
			FA239_sum_reg <= FA239_sum; FA239_carry_reg <= FA239_carry;
		end
	end

	HalfAdder HA_3_1 (FA_2_3_sum_reg, HA2_carry_reg, HA_3_1_sum, HA_3_1_carry);
    FullAdder FA_3_1 (FA_2_4_sum_reg, FA_2_3_carry_reg, HA3_carry_reg, FA_3_1_sum, FA_3_1_carry);
    FullAdder FA_3_2  (FA_2_5_sum_reg,  FA_2_4_carry_reg,  FA7_carry_reg,  FA_3_2_sum,  FA_3_2_carry);
    FullAdder FA_3_3  (FA_2_6_sum_reg,  FA_2_5_carry_reg,  HA_2_2_sum_reg, FA_3_3_sum,  FA_3_3_carry);
    FullAdder FA_3_4  (FA_2_7_sum_reg,  FA_2_6_carry_reg,  HA_2_3_sum_reg, FA_3_4_sum,  FA_3_4_carry);
    FullAdder FA_3_5  (FA_2_8_sum_reg, FA_2_7_carry_reg,  HA_2_4_sum_reg, FA_3_5_sum,  FA_3_5_carry);
    FullAdder FA_3_6  (FA_2_9_sum_reg, FA_2_8_carry_reg, FA_2_10_sum_reg, FA_3_6_sum,  FA_3_6_carry);
    FullAdder FA_3_7  (FA_2_11_sum_reg, FA_2_9_carry_reg, FA_2_12_sum_reg, FA_3_7_sum,  FA_3_7_carry);

    FullAdder FA_3_8  (FA_2_13_sum_reg, FA_2_11_carry_reg, FA_2_14_sum_reg, FA_3_8_sum,  FA_3_8_carry);
    FullAdder FA_3_9  (FA_2_15_sum_reg, FA23_carry_reg, FA_2_16_sum_reg, FA_3_9_sum,  FA_3_9_carry);
    HalfAdder HA_3_2 (FA_2_13_carry_reg, FA_2_14_carry_reg, HA_3_2_sum, HA_3_2_carry);


    FullAdder FA_3_10 (FA_2_17_sum_reg, FA26_carry_reg, FA_2_18_sum_reg, FA_3_10_sum, FA_3_10_carry);
    HalfAdder HA_3_3 (FA_2_15_carry_reg, FA_2_16_carry_reg, HA_3_3_sum, HA_3_3_carry);

    FullAdder FA_3_11 (FA_2_19_sum_reg, FA29_carry_reg, FA_2_20_sum_reg, FA_3_11_sum, FA_3_11_carry);
    HalfAdder HA_3_4 (FA_2_17_carry_reg, FA_2_18_carry_reg, HA_3_4_sum, HA_3_4_carry);
    
    FullAdder FA_3_12 (FA_2_21_sum_reg, HA_2_5_sum_reg, FA_2_22_sum_reg, FA_3_12_sum, FA_3_12_carry);
    HalfAdder HA_3_5 (FA_2_19_carry_reg, FA_2_20_carry_reg, HA_3_5_sum, HA_3_5_carry);

    FullAdder FA_3_13 (FA_2_23_sum_reg, HA_2_6_sum_reg, FA_2_24_sum_reg, FA_3_13_sum, FA_3_13_carry);
    FullAdder FA_3_14 (FA_2_21_carry_reg, HA_2_5_carry_reg, FA_2_22_carry_reg, FA_3_14_sum, FA_3_14_carry);

    FullAdder FA_3_15 (FA_2_25_sum_reg, HA_2_7_sum_reg, FA_2_26_sum_reg, FA_3_15_sum, FA_3_15_carry);
    FullAdder FA_3_16 (FA_2_23_carry_reg, HA_2_6_carry_reg, FA_2_24_carry_reg, FA_3_16_sum, FA_3_16_carry);
    
    FullAdder FA_3_17 (FA_2_27_sum_reg, FA_2_28_sum_reg, FA_2_29_sum_reg, FA_3_17_sum, FA_3_17_carry);
    FullAdder FA_3_18 (FA_2_25_carry_reg, HA_2_7_carry_reg, FA_2_26_carry_reg, FA_3_18_sum, FA_3_18_carry);

    FullAdder FA_3_19 (FA_2_30_sum_reg, FA_2_31_sum_reg, FA_2_32_sum_reg, FA_3_19_sum, FA_3_19_carry);
    FullAdder FA_3_20 (FA_2_27_carry_reg, FA_2_28_carry_reg, FA_2_29_carry_reg, FA_3_20_sum, FA_3_20_carry);

    FullAdder FA_3_21 (FA_2_33_sum_reg, FA_2_34_sum_reg, FA_2_35_sum_reg, FA_3_21_sum, FA_3_21_carry);
    FullAdder FA_3_22 (FA_2_30_carry_reg, FA_2_31_carry_reg, FA_2_32_carry_reg, FA_3_22_sum, FA_3_22_carry);

    FullAdder FA_3_23 (FA_2_36_sum_reg, FA_2_37_sum_reg, FA_2_38_sum_reg, FA_3_23_sum, FA_3_23_carry);
    FullAdder FA_3_24 (HA8_carry_reg, FA_2_33_carry_reg, FA_2_34_carry_reg, FA_3_24_sum, FA_3_24_carry);
    
    FullAdder FA_3_25 (FA_2_39_sum_reg, FA_2_40_sum_reg, FA_2_41_sum_reg, FA_3_25_sum, FA_3_25_carry);
    FullAdder FA_3_26 (HA9_carry_reg, FA_2_36_carry_reg, FA_2_37_carry_reg, FA_3_26_sum, FA_3_26_carry);
    
    FullAdder FA_3_27 (FA_2_42_sum_reg, FA_2_43_sum_reg, FA_2_44_sum_reg, FA_3_27_sum, FA_3_27_carry);
    FullAdder FA_3_28 (FA64_carry_reg, FA_2_39_carry_reg, FA_2_40_carry_reg, FA_3_28_sum, FA_3_28_carry);
    
    FullAdder FA_3_29 (FA_2_45_sum_reg, FA_2_46_sum_reg, FA_2_47_sum_reg, FA_3_29_sum, FA_3_29_carry);
    FullAdder FA_3_30 (HA_2_8_sum_reg, FA_2_42_carry_reg, FA_2_43_carry_reg, FA_3_30_sum, FA_3_30_carry);
    
    FullAdder FA_3_31 (FA_2_48_sum_reg, FA_2_49_sum_reg, FA_2_50_sum_reg, FA_3_31_sum, FA_3_31_carry);
    FullAdder FA_3_32 (HA_2_9_sum_reg, FA_2_45_carry_reg, FA_2_46_carry_reg, FA_3_32_sum, FA_3_32_carry);  
    HalfAdder HA_3_6 (FA_2_47_carry_reg, HA_2_8_carry_reg, HA_3_6_sum, HA_3_6_carry);
    
    FullAdder FA_3_33 (FA_2_51_sum_reg, FA_2_52_sum_reg, FA_2_53_sum_reg, FA_3_33_sum, FA_3_33_carry);
    FullAdder FA_3_34 (HA_2_10_sum_reg, FA_2_48_carry_reg, FA_2_49_carry_reg, FA_3_34_sum, FA_3_34_carry);  
    HalfAdder HA_3_7 (FA_2_50_carry_reg, HA_2_9_carry_reg, HA_3_7_sum, HA_3_7_carry);    
    
    
        FullAdder FA_3_35 (FA_2_54_sum_reg, FA_2_55_sum_reg, FA_2_56_sum_reg, FA_3_35_sum, FA_3_35_carry);
    FullAdder FA_3_36 (HA_2_11_sum_reg, FA_2_51_carry_reg, FA_2_52_carry_reg, FA_3_36_sum, FA_3_36_carry);  
    HalfAdder HA_3_8 (FA_2_53_carry_reg, HA_2_10_carry_reg, HA_3_8_sum, HA_3_8_carry);
    
    FullAdder FA_3_37 (FA_2_57_sum_reg, FA_2_58_sum_reg, FA_2_59_sum_reg, FA_3_37_sum, FA_3_37_carry);
    FullAdder FA_3_38 (HA_2_12_sum_reg, FA_2_54_carry_reg, FA_2_55_carry_reg, FA_3_38_sum, FA_3_38_carry);  
    HalfAdder HA_3_9 (FA_2_56_carry_reg, HA_2_11_carry_reg, HA_3_9_sum, HA_3_9_carry);
    
    FullAdder FA_3_39 (FA_2_60_sum_reg, FA_2_61_sum_reg, FA_2_62_sum_reg, FA_3_39_sum, FA_3_39_carry);
    FullAdder FA_3_40 (HA_2_13_sum_reg, FA_2_57_carry_reg, FA_2_58_carry_reg, FA_3_40_sum, FA_3_40_carry);  
    HalfAdder HA_3_10 (FA_2_59_carry_reg, HA_2_12_carry_reg, HA_3_10_sum, HA_3_10_carry);
    
    FullAdder FA_3_41 (FA_2_63_sum_reg, FA_2_64_sum_reg, FA_2_65_sum_reg, FA_3_41_sum, FA_3_41_carry);
    FullAdder FA_3_42 (HA_2_14_sum_reg, FA_2_60_carry_reg, FA_2_61_carry_reg, FA_3_42_sum, FA_3_42_carry);  
    HalfAdder HA_3_11 (FA_2_62_carry_reg, HA_2_13_carry_reg, HA_3_11_sum, HA_3_11_carry);
    
    FullAdder FA_3_43 (FA_2_66_sum_reg, FA_2_67_sum_reg, FA_2_68_sum_reg, FA_3_43_sum, FA_3_43_carry);
    FullAdder FA_3_44 (HA_2_15_sum_reg, FA_2_63_carry_reg, FA_2_64_carry_reg, FA_3_44_sum, FA_3_44_carry);  
    HalfAdder HA_3_12 (FA_2_65_carry_reg, HA_2_14_carry_reg, HA_3_12_sum, HA_3_12_carry);
    
    FullAdder FA_3_45 (FA_2_69_sum_reg, FA_2_70_sum_reg, FA_2_71_sum_reg, FA_3_45_sum, FA_3_45_carry);
    FullAdder FA_3_46 (HA_2_16_sum_reg, FA_2_66_carry_reg, FA_2_67_carry_reg, FA_3_46_sum, FA_3_46_carry);  
    HalfAdder HA_3_13 (FA_2_68_carry_reg, HA_2_15_carry_reg, HA_3_13_sum, HA_3_13_carry);
    
    FullAdder FA_3_47 (FA_2_72_sum_reg, FA_2_73_sum_reg, FA_2_74_sum_reg, FA_3_47_sum, FA_3_47_carry);
    FullAdder FA_3_48 (HA_2_17_sum_reg, FA_2_69_carry_reg, FA_2_70_carry_reg, FA_3_48_sum, FA_3_48_carry);  
    HalfAdder HA_3_14 (FA_2_71_carry_reg, HA_2_16_carry_reg, HA_3_14_sum, HA_3_14_carry);
    
    FullAdder FA_3_49 (FA_2_75_sum_reg, FA_2_76_sum_reg, FA_2_77_sum_reg, FA_3_49_sum, FA_3_49_carry);
    FullAdder FA_3_50 (HA_2_18_sum_reg, FA_2_72_carry_reg, FA_2_73_carry_reg, FA_3_50_sum, FA_3_50_carry);  
    HalfAdder HA_3_15 (FA_2_74_carry_reg, HA_2_17_carry_reg, HA_3_15_sum, HA_3_15_carry);
    
    FullAdder FA_3_51 (FA_2_78_sum_reg, FA_2_79_sum_reg, FA_2_80_sum_reg, FA_3_51_sum, FA_3_51_carry);
    FullAdder FA_3_52 (HA_2_19_sum_reg, FA_2_75_carry_reg, FA_2_76_carry_reg, FA_3_52_sum, FA_3_52_carry);  
    HalfAdder HA_3_16 (FA_2_77_carry_reg, HA_2_18_carry_reg, HA_3_16_sum, HA_3_16_carry);
    
    FullAdder FA_3_53 (FA_2_81_sum_reg, FA_2_82_sum_reg, FA_2_83_sum_reg, FA_3_53_sum, FA_3_53_carry);
    FullAdder FA_3_54 (HA_2_20_sum_reg, FA_2_78_carry_reg, FA_2_79_carry_reg, FA_3_54_sum, FA_3_54_carry);  
    HalfAdder HA_3_17 (FA_2_80_carry_reg, HA_2_19_carry_reg, HA_3_17_sum, HA_3_17_carry);
    
    FullAdder FA_3_55 (FA_2_84_sum_reg, FA_2_85_sum_reg, FA_2_86_sum_reg, FA_3_55_sum, FA_3_55_carry);
    FullAdder FA_3_56 (HA_2_21_sum_reg, FA_2_81_carry_reg, FA_2_82_carry_reg, FA_3_56_sum, FA_3_56_carry);  
    HalfAdder HA_3_18 (FA_2_83_carry_reg, HA_2_20_carry_reg, HA_3_18_sum, HA_3_18_carry);
    
    FullAdder FA_3_57 (FA_2_87_sum_reg, FA_2_88_sum_reg, FA_2_89_sum_reg, FA_3_57_sum, FA_3_57_carry);
    FullAdder FA_3_58 (HA_2_22_sum_reg, FA_2_84_carry_reg, FA_2_85_carry_reg, FA_3_58_sum, FA_3_58_carry);  
    HalfAdder HA_3_19 (FA_2_86_carry_reg, HA_2_21_carry_reg, HA_3_19_sum, HA_3_19_carry);
    
    FullAdder FA_3_59 (FA_2_90_sum_reg, FA_2_91_sum_reg, FA_2_92_sum_reg, FA_3_59_sum, FA_3_59_carry);
    FullAdder FA_3_60 (HA_2_23_sum_reg, FA_2_87_carry_reg, FA_2_88_carry_reg, FA_3_60_sum, FA_3_60_carry);  
    HalfAdder HA_3_20 (FA_2_89_carry_reg, HA_2_22_carry_reg, HA_3_20_sum, HA_3_20_carry);
    
    FullAdder FA_3_61 (FA_2_93_sum_reg, FA_2_94_sum_reg, FA_2_95_sum_reg, FA_3_61_sum, FA_3_61_carry);
    FullAdder FA_3_62 (HA_2_24_sum_reg, FA_2_90_carry_reg, FA_2_91_carry_reg, FA_3_62_sum, FA_3_62_carry);  
    HalfAdder HA_3_21 (FA_2_92_carry_reg, HA_2_23_carry_reg, HA_3_21_sum, HA_3_21_carry);
    
    FullAdder FA_3_63 (FA_2_96_sum_reg, FA_2_97_sum_reg, FA_2_98_sum_reg, FA_3_63_sum, FA_3_63_carry);
    FullAdder FA_3_64 (HA_2_25_sum_reg, FA_2_93_carry_reg, FA_2_94_carry_reg, FA_3_64_sum, FA_3_64_carry);  
    HalfAdder HA_3_22 (FA_2_95_carry_reg, HA_2_24_carry_reg, HA_3_22_sum, HA_3_22_carry);
    
    FullAdder FA_3_65 (FA_2_99_sum_reg, FA_2_100_sum_reg, FA_2_101_sum_reg, FA_3_65_sum, FA_3_65_carry);
    FullAdder FA_3_66 (HA_2_26_sum_reg, FA_2_96_carry_reg, FA_2_97_carry_reg, FA_3_66_sum, FA_3_66_carry);  
    HalfAdder HA_3_23 (FA_2_98_carry_reg, HA_2_25_carry_reg, HA_3_23_sum, HA_3_23_carry);
    
    FullAdder FA_3_67 (FA_2_102_sum_reg, FA_2_103_sum_reg, FA_2_104_sum_reg, FA_3_67_sum, FA_3_67_carry);
    FullAdder FA_3_68 (HA_2_27_sum_reg, FA_2_99_carry_reg, FA_2_100_carry_reg, FA_3_68_sum, FA_3_68_carry);  
    HalfAdder HA_3_24 (FA_2_101_carry_reg, HA_2_26_carry_reg, HA_3_24_sum, HA_3_24_carry);
    
    FullAdder FA_3_69 (FA_2_105_sum_reg, FA_2_106_sum_reg, FA_2_107_sum_reg, FA_3_69_sum, FA_3_69_carry);
    FullAdder FA_3_70 (HA_2_28_sum_reg, FA_2_102_carry_reg, FA_2_103_carry_reg, FA_3_70_sum, FA_3_70_carry);  
    HalfAdder HA_3_25 (FA_2_104_carry_reg, HA_2_27_carry_reg, HA_3_25_sum, HA_3_25_carry);
    
    FullAdder FA_3_71 (FA_2_108_sum_reg, FA_2_109_sum_reg, FA_2_110_sum_reg, FA_3_71_sum, FA_3_71_carry);
    FullAdder FA_3_72 (HA_2_29_sum_reg, FA_2_105_carry_reg, FA_2_106_carry_reg, FA_3_72_sum, FA_3_72_carry);  
    HalfAdder HA_3_26 (FA_2_107_carry_reg, HA_2_28_carry_reg, HA_3_26_sum, HA_3_26_carry);
    
    FullAdder FA_3_73 (FA_2_111_sum_reg, FA_2_112_sum_reg, FA_2_113_sum_reg, FA_3_73_sum, FA_3_73_carry);
    FullAdder FA_3_74 (HA_2_30_sum_reg, FA_2_108_carry_reg, FA_2_109_carry_reg, FA_3_74_sum, FA_3_74_carry);  
    HalfAdder HA_3_27 (FA_2_110_carry_reg, HA_2_29_carry_reg, HA_3_27_sum, HA_3_27_carry);
    
    FullAdder FA_3_75 (FA_2_114_sum_reg, FA_2_115_sum_reg, FA_2_116_sum_reg, FA_3_75_sum, FA_3_75_carry);
    FullAdder FA_3_76 (HA_2_31_sum_reg, FA_2_111_carry_reg, FA_2_112_carry_reg, FA_3_76_sum, FA_3_76_carry);  
    HalfAdder HA_3_28 (FA_2_113_carry_reg, HA_2_30_carry_reg, HA_3_28_sum, HA_3_28_carry);
    
    FullAdder FA_3_77 (FA_2_117_sum_reg, FA_2_118_sum_reg, FA_2_119_sum_reg, FA_3_77_sum, FA_3_77_carry);
    FullAdder FA_3_78 (HA_2_32_sum_reg, FA_2_114_carry_reg, FA_2_115_carry_reg, FA_3_78_sum, FA_3_78_carry);  
    HalfAdder HA_3_29 (FA_2_116_carry_reg, HA_2_31_carry_reg, HA_3_29_sum, HA_3_29_carry);
    
    FullAdder FA_3_79 (FA_2_120_sum_reg, FA_2_121_sum_reg, FA_2_122_sum_reg, FA_3_79_sum, FA_3_79_carry);
    FullAdder FA_3_80 (HA_2_33_sum_reg, FA_2_117_carry_reg, FA_2_118_carry_reg, FA_3_80_sum, FA_3_80_carry);  
    HalfAdder HA_3_30 (FA_2_119_carry_reg, HA_2_32_carry_reg, HA_3_30_sum, HA_3_30_carry);
    
    FullAdder FA_3_81 (FA_2_123_sum_reg, FA_2_124_sum_reg, FA_2_125_sum_reg, FA_3_81_sum, FA_3_81_carry);
    FullAdder FA_3_82 (HA_2_34_sum_reg, FA_2_120_carry_reg, FA_2_121_carry_reg, FA_3_82_sum, FA_3_82_carry);  
    HalfAdder HA_3_31 (FA_2_122_carry_reg, HA_2_33_carry_reg, HA_3_31_sum, HA_3_31_carry);
    
    FullAdder FA_3_83 (FA_2_126_sum_reg, FA_2_127_sum_reg, FA_2_128_sum_reg, FA_3_83_sum, FA_3_83_carry);
    FullAdder FA_3_84 (HA_2_35_sum_reg, FA_2_123_carry_reg, FA_2_124_carry_reg, FA_3_84_sum, FA_3_84_carry);  
    HalfAdder HA_3_32 (FA_2_125_carry_reg, HA_2_34_carry_reg, HA_3_32_sum, HA_3_32_carry);
    
    FullAdder FA_3_85 (FA_2_129_sum_reg, FA_2_130_sum_reg, FA_2_131_sum_reg, FA_3_85_sum, FA_3_85_carry);
    FullAdder FA_3_86 (HA_2_36_sum_reg, FA_2_126_carry_reg, FA_2_127_carry_reg, FA_3_86_sum, FA_3_86_carry);  
    HalfAdder HA_3_33 (FA_2_128_carry_reg, HA_2_35_carry_reg, HA_3_33_sum, HA_3_33_carry);
    
    FullAdder FA_3_87 (FA_2_132_sum_reg, FA_2_133_sum_reg, FA_2_134_sum_reg, FA_3_87_sum, FA_3_87_carry);
    FullAdder FA_3_88 (HA_2_37_sum_reg, FA_2_129_carry_reg, FA_2_130_carry_reg, FA_3_88_sum, FA_3_88_carry);  
    HalfAdder HA_3_34 (FA_2_131_carry_reg, HA_2_36_carry_reg, HA_3_34_sum, HA_3_34_carry);
    
    FullAdder FA_3_89 (FA_2_135_sum_reg, FA_2_136_sum_reg, FA_2_137_sum_reg, FA_3_89_sum, FA_3_89_carry);
    FullAdder FA_3_90 (HA_2_38_sum_reg, FA_2_132_carry_reg, FA_2_133_carry_reg, FA_3_90_sum, FA_3_90_carry);  
    HalfAdder HA_3_35 (FA_2_134_carry_reg, HA_2_37_carry_reg, HA_3_35_sum, HA_3_35_carry);
    
    FullAdder FA_3_91 (FA_2_138_sum_reg, FA_2_139_sum_reg, FA_2_140_sum_reg, FA_3_91_sum, FA_3_91_carry);
    FullAdder FA_3_92 (HA_2_39_sum_reg, FA_2_135_carry_reg, FA_2_136_carry_reg, FA_3_92_sum, FA_3_92_carry);  
    HalfAdder HA_3_36 (FA_2_137_carry_reg, HA_2_38_carry_reg, HA_3_36_sum, HA_3_36_carry);
    
    FullAdder FA_3_93 (FA_2_141_sum_reg, FA_2_142_sum_reg, FA_2_143_sum_reg, FA_3_93_sum, FA_3_93_carry);
    FullAdder FA_3_94 (HA_2_40_sum_reg, FA_2_138_carry_reg, FA_2_139_carry_reg, FA_3_94_sum, FA_3_94_carry);  
    HalfAdder HA_3_37 (FA_2_140_carry_reg, HA_2_39_carry_reg, HA_3_37_sum, HA_3_37_carry);
    
    FullAdder FA_3_95 (FA_2_144_sum_reg, FA_2_145_sum_reg, FA_2_146_sum_reg, FA_3_95_sum, FA_3_95_carry);
    FullAdder FA_3_96 (HA_2_41_sum_reg, FA_2_141_carry_reg, FA_2_142_carry_reg, FA_3_96_sum, FA_3_96_carry);  
    HalfAdder HA_3_38 (FA_2_143_carry_reg, HA_2_40_carry_reg, HA_3_38_sum, HA_3_38_carry);
    
          
        
// stage 4

    HalfAdder HA_4_1 (FA_3_4_sum, FA_3_3_carry, HA_4_1_sum, HA_4_1_carry);
    FullAdder FA_4_1 (FA_3_5_sum, FA_3_4_carry , HA_2_3_carry_reg, FA_4_1_sum, FA_4_1_carry);
    FullAdder FA_4_2  (FA_3_6_sum,  FA_3_5_carry,  HA_2_4_carry_reg,  FA_4_2_sum,  FA_4_2_carry);
    FullAdder FA_4_3  (FA_3_7_sum,  FA_3_6_carry,  FA_2_10_carry_reg, FA_4_3_sum,  FA_4_3_carry);
    FullAdder FA_4_4  (FA_3_8_sum,  FA_3_7_carry,  FA_2_12_carry_reg, FA_4_4_sum,  FA_4_4_carry);
    FullAdder FA_4_5  (FA_3_9_sum,  FA_3_8_carry,  HA_3_2_sum, FA_4_5_sum,  FA_4_5_carry);

    FullAdder FA_4_6  (FA_3_10_sum, FA_3_9_carry,  HA_3_3_sum, FA_4_6_sum,  FA_4_6_carry);
    FullAdder FA_4_7  (FA_3_11_sum, FA_3_10_carry, HA_3_4_sum, FA_4_7_sum,  FA_4_7_carry);
    FullAdder FA_4_8  (FA_3_12_sum, FA_3_11_carry, HA_3_5_sum, FA_4_8_sum,  FA_4_8_carry);
    FullAdder FA_4_9  (FA_3_13_sum, FA_3_12_carry, FA_3_14_sum, FA_4_9_sum,  FA_4_9_carry);
    FullAdder FA_4_10 (FA_3_15_sum, FA_3_13_carry, FA_3_16_sum, FA_4_10_sum, FA_4_10_carry);
    FullAdder FA_4_11 (FA_3_17_sum, FA_3_15_carry, FA_3_18_sum, FA_4_11_sum, FA_4_11_carry);
    FullAdder FA_4_12 (FA_3_19_sum, FA_3_17_carry, FA_3_20_sum, FA_4_12_sum, FA_4_12_carry);
    FullAdder FA_4_13 (FA_3_21_sum, FA_3_19_carry, FA_3_22_sum, FA_4_13_sum, FA_4_13_carry);
    
    FullAdder FA_4_14 (FA_3_23_sum, FA_3_21_carry, FA_3_24_sum, FA_4_14_sum, FA_4_14_carry);
    HalfAdder HA_4_2 (FA_2_35_carry, FA_3_22_carry, HA_4_2_sum, HA_4_2_carry);
    
    FullAdder FA_4_15 (FA_3_25_sum, FA_3_23_carry, FA_3_26_sum, FA_4_15_sum, FA_4_15_carry);
    HalfAdder HA_4_3 (FA_2_38_sum, FA_3_24_carry, HA_4_3_sum, HA_4_3_carry);

    
    FullAdder FA_4_16 (FA_3_27_sum, FA_3_25_carry, FA_3_28_sum, FA_4_16_sum, FA_4_16_carry);
    HalfAdder HA_4_4 (FA_2_41_sum, FA_3_26_carry, HA_4_4_sum, HA_4_4_carry);
    
    FullAdder FA_4_17 (FA_3_29_sum, FA_3_27_carry, FA_3_30_sum, FA_4_17_sum, FA_4_17_carry);
    HalfAdder HA_4_5 (FA_2_44_sum, FA_3_28_carry, HA_4_5_sum, HA_4_5_carry);
    
    FullAdder FA_4_18 (FA_3_31_sum, FA_3_29_carry, FA_3_32_sum, FA_4_18_sum, FA_4_18_carry);
    HalfAdder HA_4_6 (HA_3_6_sum, FA_3_30_carry, HA_4_6_sum, HA_4_6_carry);

    FullAdder FA_4_19 (FA_3_33_sum, FA_3_31_carry, FA_3_34_sum, FA_4_19_sum, FA_4_19_carry);
    FullAdder FA_4_20 (HA_3_7_sum, FA_3_32_carry, HA_3_6_carry, FA_4_20_sum, FA_4_20_carry);

    FullAdder FA_4_21 (FA_3_35_sum, FA_3_33_carry, FA_3_36_sum, FA_4_21_sum, FA_4_21_carry);
    FullAdder FA_4_22 (HA_3_8_sum, FA_3_34_carry, HA_3_7_carry, FA_4_22_sum, FA_4_22_carry);
    
    
    FullAdder FA_4_23 (FA_3_37_sum, FA_3_35_carry, FA_3_38_sum, FA_4_23_sum, FA_4_23_carry);
    FullAdder FA_4_24 (HA_3_9_sum, FA_3_36_carry, HA_3_8_carry, FA_4_24_sum, FA_4_24_carry);
    FullAdder FA_4_25 (FA_3_39_sum, FA_3_37_carry, FA_3_40_sum, FA_4_25_sum, FA_4_25_carry);
    FullAdder FA_4_26 (HA_3_10_sum, FA_3_38_carry, HA_3_9_carry, FA_4_26_sum, FA_4_26_carry);

    FullAdder FA_4_27 (FA_3_41_sum, FA_3_39_carry, FA_3_42_sum, FA_4_27_sum, FA_4_27_carry);
    FullAdder FA_4_28 (HA_3_11_sum, FA_3_40_carry, HA_3_10_carry, FA_4_28_sum, FA_4_28_carry);
    FullAdder FA_4_29 (FA_3_43_sum, FA_3_41_carry, FA_3_44_sum, FA_4_29_sum, FA_4_29_carry);
    FullAdder FA_4_30 (HA_3_12_sum, FA_3_42_carry, HA_3_11_carry, FA_4_30_sum, FA_4_30_carry);

    FullAdder FA_4_31 (FA_3_45_sum, FA_3_43_carry, FA_3_46_sum, FA_4_31_sum, FA_4_31_carry);
    FullAdder FA_4_32 (HA_3_13_sum, FA_3_44_carry, HA_3_12_carry, FA_4_32_sum, FA_4_32_carry);
    FullAdder FA_4_33 (FA_3_47_sum, FA_3_45_carry, FA_3_48_sum, FA_4_33_sum, FA_4_33_carry);
    FullAdder FA_4_34 (HA_3_14_sum, FA_3_46_carry, HA_3_13_carry, FA_4_34_sum, FA_4_34_carry);

    FullAdder FA_4_35 (FA_3_49_sum, FA_3_47_carry, FA_3_50_sum, FA_4_35_sum, FA_4_35_carry);
    FullAdder FA_4_36 (HA_3_15_sum, FA_3_48_carry, HA_3_14_carry, FA_4_36_sum, FA_4_36_carry);
    FullAdder FA_4_37 (FA_3_51_sum, FA_3_49_carry, FA_3_52_sum, FA_4_37_sum, FA_4_37_carry);
    FullAdder FA_4_38 (HA_3_16_sum, FA_3_50_carry, HA_3_15_carry, FA_4_38_sum, FA_4_38_carry);

    FullAdder FA_4_39 (FA_3_53_sum, FA_3_51_carry, FA_3_54_sum, FA_4_39_sum, FA_4_39_carry);
    FullAdder FA_4_40 (HA_3_17_sum, FA_3_52_carry, HA_3_16_carry, FA_4_40_sum, FA_4_40_carry);
    FullAdder FA_4_41 (FA_3_55_sum, FA_3_53_carry, FA_3_56_sum, FA_4_41_sum, FA_4_41_carry);
    FullAdder FA_4_42 (HA_3_18_sum, FA_3_54_carry, HA_3_17_carry, FA_4_42_sum, FA_4_42_carry);

    FullAdder FA_4_43 (FA_3_57_sum, FA_3_55_carry, FA_3_58_sum, FA_4_43_sum, FA_4_43_carry);
    FullAdder FA_4_44 (HA_3_19_sum, FA_3_56_carry, HA_3_18_carry, FA_4_44_sum, FA_4_44_carry);
    FullAdder FA_4_45 (FA_3_59_sum, FA_3_57_carry, FA_3_60_sum, FA_4_45_sum, FA_4_45_carry);
    FullAdder FA_4_46 (HA_3_20_sum, FA_3_58_carry, HA_3_19_carry, FA_4_46_sum, FA_4_46_carry);

    FullAdder FA_4_47 (FA_3_61_sum, FA_3_59_carry, FA_3_62_sum, FA_4_47_sum, FA_4_47_carry);
    FullAdder FA_4_48 (HA_3_21_sum, FA_3_60_carry, HA_3_20_carry, FA_4_48_sum, FA_4_48_carry);
    FullAdder FA_4_49 (FA_3_63_sum, FA_3_61_carry, FA_3_64_sum, FA_4_49_sum, FA_4_49_carry);
    FullAdder FA_4_50 (HA_3_22_sum, FA_3_62_carry, HA_3_21_carry, FA_4_50_sum, FA_4_50_carry);

    FullAdder FA_4_51 (FA_3_65_sum, FA_3_63_carry, FA_3_66_sum, FA_4_51_sum, FA_4_51_carry);
    FullAdder FA_4_52 (HA_3_23_sum, FA_3_64_carry, HA_3_22_carry, FA_4_52_sum, FA_4_52_carry);
    FullAdder FA_4_53 (FA_3_67_sum, FA_3_65_carry, FA_3_68_sum, FA_4_53_sum, FA_4_53_carry);
    FullAdder FA_4_54 (HA_3_24_sum, FA_3_66_carry, HA_3_23_carry, FA_4_54_sum, FA_4_54_carry);

    FullAdder FA_4_55 (FA_3_69_sum, FA_3_67_carry, FA_3_70_sum, FA_4_55_sum, FA_4_55_carry);
    FullAdder FA_4_56 (HA_3_25_sum, FA_3_68_carry, HA_3_24_carry, FA_4_56_sum, FA_4_56_carry);
    FullAdder FA_4_57 (FA_3_71_sum, FA_3_69_carry, FA_3_72_sum, FA_4_57_sum, FA_4_57_carry);
    FullAdder FA_4_58 (HA_3_26_sum, FA_3_70_carry, HA_3_25_carry, FA_4_58_sum, FA_4_58_carry);
    

    FullAdder FA_4_59 (FA_3_73_sum, FA_3_71_carry, FA_3_74_sum, FA_4_59_sum, FA_4_59_carry);
    FullAdder FA_4_60 (HA_3_27_sum, FA_3_72_carry, HA_3_26_carry, FA_4_60_sum, FA_4_60_carry);
    FullAdder FA_4_61 (FA_3_75_sum, FA_3_73_carry, FA_3_76_sum, FA_4_61_sum, FA_4_61_carry);
    FullAdder FA_4_62 (HA_3_28_sum, FA_3_74_carry, HA_3_27_carry, FA_4_62_sum, FA_4_62_carry);

    FullAdder FA_4_63 (FA_3_77_sum, FA_3_75_carry, FA_3_78_sum, FA_4_63_sum, FA_4_63_carry);
    FullAdder FA_4_64 (HA_3_29_sum, FA_3_76_carry, HA_3_28_carry, FA_4_64_sum, FA_4_64_carry);
    FullAdder FA_4_65 (FA_3_79_sum, FA_3_77_carry, FA_3_80_sum, FA_4_65_sum, FA_4_65_carry);
    FullAdder FA_4_66 (HA_3_30_sum, FA_3_78_carry, HA_3_29_carry, FA_4_66_sum, FA_4_66_carry);
    
    FullAdder FA_4_67 (FA_3_81_sum, FA_3_79_carry, FA_3_82_sum, FA_4_67_sum, FA_4_67_carry);
    FullAdder FA_4_68 (HA_3_31_sum, FA_3_80_carry, HA_3_30_carry, FA_4_68_sum, FA_4_68_carry);
    FullAdder FA_4_69 (FA_3_83_sum, FA_3_81_carry, FA_3_84_sum, FA_4_69_sum, FA_4_69_carry);
    FullAdder FA_4_70 (HA_3_32_sum, FA_3_82_carry, HA_3_31_carry, FA_4_70_sum, FA_4_70_carry);

    FullAdder FA_4_71 (FA_3_85_sum, FA_3_83_carry, FA_3_86_sum, FA_4_71_sum, FA_4_71_carry);
    FullAdder FA_4_72 (HA_3_33_sum, FA_3_84_carry, HA_3_32_carry, FA_4_72_sum, FA_4_72_carry);
    FullAdder FA_4_73 (FA_3_87_sum, FA_3_85_carry, FA_3_88_sum, FA_4_73_sum, FA_4_73_carry);
    FullAdder FA_4_74 (HA_3_34_sum, FA_3_86_carry, HA_3_33_carry, FA_4_74_sum, FA_4_74_carry);

    FullAdder FA_4_75 (FA_3_89_sum, FA_3_87_carry, FA_3_90_sum, FA_4_75_sum, FA_4_75_carry);
    FullAdder FA_4_76 (HA_3_35_sum, FA_3_88_carry, HA_3_34_carry, FA_4_76_sum, FA_4_76_carry);
    FullAdder FA_4_77 (FA_3_91_sum, FA_3_89_carry, FA_3_92_sum, FA_4_77_sum, FA_4_77_carry);
    FullAdder FA_4_78 (HA_3_36_sum, FA_3_90_carry, HA_3_35_carry, FA_4_78_sum, FA_4_78_carry);

    FullAdder FA_4_79 (FA_3_93_sum, FA_3_91_carry, FA_3_94_sum, FA_4_79_sum, FA_4_79_carry);
    FullAdder FA_4_80 (HA_3_37_sum, FA_3_92_carry, HA_3_36_carry, FA_4_80_sum, FA_4_80_carry);
    FullAdder FA_4_81 (FA_3_95_sum, FA_3_93_carry, FA_3_96_sum, FA_4_81_sum, FA_4_81_carry);
    FullAdder FA_4_82 (HA_3_38_sum, FA_3_94_carry, HA_3_37_carry, FA_4_82_sum, FA_4_82_carry);
    
    //stage 5 
    
    HalfAdder HA_5_1 (FA_4_6_sum, HA_3_2_carry, HA_5_1_sum, HA_5_1_carry);
    FullAdder FA_5_1 (FA_4_7_sum, FA_4_6_carry , HA_3_3_carry, FA_5_1_sum, FA_5_1_carry);
    FullAdder FA_5_2 (FA_4_8_sum, FA_4_7_carry , HA_3_4_carry, FA_5_2_sum, FA_5_2_carry);
    FullAdder FA_5_3 (FA_4_9_sum, FA_4_8_carry , HA_3_5_carry, FA_5_3_sum, FA_5_3_carry);
    FullAdder FA_5_4 (FA_4_10_sum, FA_4_9_carry , FA_3_14_carry, FA_5_4_sum, FA_5_4_carry);
    FullAdder FA_5_5 (FA_4_11_sum, FA_4_10_carry , FA_3_16_carry, FA_5_5_sum, FA_5_5_carry);
    FullAdder FA_5_6 (FA_4_12_sum, FA_4_11_carry , FA_3_18_carry, FA_5_6_sum, FA_5_6_carry);
    FullAdder FA_5_7 (FA_4_13_sum, FA_4_12_carry , FA_3_20_carry, FA_5_7_sum, FA_5_7_carry);
    FullAdder FA_5_8 (FA_4_14_sum, FA_4_13_carry , HA_4_2_sum, FA_5_8_sum, FA_5_8_carry);
    FullAdder FA_5_9 (FA_4_15_sum, FA_4_14_carry , HA_4_3_sum, FA_5_9_sum, FA_5_9_carry);
    FullAdder FA_5_10 (FA_4_16_sum, FA_4_15_carry, HA_4_4_sum, FA_5_10_sum, FA_5_10_carry);
    FullAdder FA_5_11 (FA_4_17_sum, FA_4_16_carry, HA_4_5_sum, FA_5_11_sum, FA_5_11_carry);
    FullAdder FA_5_12 (FA_4_18_sum, FA_4_17_carry, HA_4_6_sum, FA_5_12_sum, FA_5_12_carry);
    FullAdder FA_5_13 (FA_4_19_sum, FA_4_18_carry, FA_4_20_sum, FA_5_13_sum, FA_5_13_carry);
    FullAdder FA_5_14 (FA_4_21_sum, FA_4_19_carry, FA_4_22_sum, FA_5_14_sum, FA_5_14_carry);

    FullAdder FA_5_15 (FA_4_23_sum, FA_4_21_carry, FA_4_24_sum, FA_5_15_sum, FA_5_15_carry);
    FullAdder FA_5_16 (FA_4_25_sum, FA_4_23_carry, FA_4_26_sum, FA_5_16_sum, FA_5_16_carry);
    FullAdder FA_5_17 (FA_4_27_sum, FA_4_25_carry, FA_4_28_sum, FA_5_17_sum, FA_5_17_carry);
    FullAdder FA_5_18 (FA_4_29_sum, FA_4_27_carry, FA_4_30_sum, FA_5_18_sum, FA_5_18_carry);
    FullAdder FA_5_19 (FA_4_31_sum, FA_4_29_carry, FA_4_32_sum, FA_5_19_sum, FA_5_19_carry);
    FullAdder FA_5_20 (FA_4_33_sum, FA_4_31_carry, FA_4_34_sum, FA_5_20_sum, FA_5_20_carry);
    FullAdder FA_5_21 (FA_4_35_sum, FA_4_33_carry, FA_4_36_sum, FA_5_21_sum, FA_5_21_carry);
    FullAdder FA_5_22 (FA_4_37_sum, FA_4_35_carry, FA_4_38_sum, FA_5_22_sum, FA_5_22_carry);
    FullAdder FA_5_23 (FA_4_39_sum, FA_4_37_carry, FA_4_40_sum, FA_5_23_sum, FA_5_23_carry);
    FullAdder FA_5_24 (FA_4_41_sum, FA_4_39_carry, FA_4_42_sum, FA_5_24_sum, FA_5_24_carry);
    FullAdder FA_5_25 (FA_4_43_sum, FA_4_41_carry, FA_4_44_sum, FA_5_25_sum, FA_5_25_carry);
    FullAdder FA_5_26 (FA_4_45_sum, FA_4_43_carry, FA_4_46_sum, FA_5_26_sum, FA_5_26_carry);
    FullAdder FA_5_27 (FA_4_47_sum, FA_4_45_carry, FA_4_48_sum, FA_5_27_sum, FA_5_27_carry);
    FullAdder FA_5_28 (FA_4_49_sum, FA_4_47_carry, FA_4_50_sum, FA_5_28_sum, FA_5_28_carry);
    FullAdder FA_5_29 (FA_4_51_sum, FA_4_49_carry, FA_4_52_sum, FA_5_29_sum, FA_5_29_carry);
    FullAdder FA_5_30 (FA_4_53_sum, FA_4_51_carry, FA_4_54_sum, FA_5_30_sum, FA_5_30_carry);
    FullAdder FA_5_31 (FA_4_55_sum, FA_4_53_carry, FA_4_56_sum, FA_5_31_sum, FA_5_31_carry);
    FullAdder FA_5_32 (FA_4_57_sum, FA_4_55_carry, FA_4_58_sum, FA_5_32_sum, FA_5_32_carry);
    FullAdder FA_5_33 (FA_4_59_sum, FA_4_57_carry, FA_4_60_sum, FA_5_33_sum, FA_5_33_carry);
    FullAdder FA_5_34 (FA_4_61_sum, FA_4_59_carry, FA_4_62_sum, FA_5_34_sum, FA_5_34_carry);
    FullAdder FA_5_35 (FA_4_63_sum, FA_4_61_carry, FA_4_64_sum, FA_5_35_sum, FA_5_35_carry);
    FullAdder FA_5_36 (FA_4_65_sum, FA_4_63_carry, FA_4_66_sum, FA_5_36_sum, FA_5_36_carry);
    FullAdder FA_5_37 (FA_4_67_sum, FA_4_65_carry, FA_4_68_sum, FA_5_37_sum, FA_5_37_carry);
    FullAdder FA_5_38 (FA_4_69_sum, FA_4_67_carry, FA_4_70_sum, FA_5_38_sum, FA_5_38_carry);
    FullAdder FA_5_39 (FA_4_71_sum, FA_4_69_carry, FA_4_72_sum, FA_5_39_sum, FA_5_39_carry);
    FullAdder FA_5_40 (FA_4_73_sum, FA_4_71_carry, FA_4_74_sum, FA_5_40_sum, FA_5_40_carry);
    FullAdder FA_5_41 (FA_4_75_sum, FA_4_73_carry, FA_4_76_sum, FA_5_41_sum, FA_5_41_carry);
    FullAdder FA_5_42 (FA_4_77_sum, FA_4_75_carry, FA_4_78_sum, FA_5_42_sum, FA_5_42_carry);
    FullAdder FA_5_43 (FA_4_79_sum, FA_4_77_carry, FA_4_80_sum, FA_5_43_sum, FA_5_43_carry);
    FullAdder FA_5_44 (FA_4_81_sum, FA_4_79_carry, FA_4_82_sum, FA_5_44_sum, FA_5_44_carry);
    
    //stage 6
    
    // Full Adder and Half Adder carry registers
	reg FA_5_8_carry_reg;
	reg FA_5_7_carry_reg;
	reg FA_5_6_carry_reg;
	reg FA_5_5_carry_reg;
	reg FA_5_4_carry_reg;
	reg FA_5_3_carry_reg;
	reg FA_5_2_carry_reg;
	reg FA_5_1_carry_reg;
	reg HA_5_1_carry_reg;
	reg FA_4_5_carry_reg;
	reg FA_4_4_carry_reg;
	reg FA_4_3_carry_reg;
	reg FA_4_2_carry_reg;
	reg FA_4_1_carry_reg;
	reg HA_4_1_carry_reg;
	reg HA_2_2_carry_double_reg;
	reg FA_3_2_carry_reg;
	reg FA_3_1_carry_reg;
	reg HA_3_1_carry_reg;
	reg FA_2_2_carry_double_reg;
	reg FA_2_1_carry_double_reg;
	reg HA_2_1_carry_double_reg;
	reg HA1_carry_double_reg;
	
	// Full Adder and Half Adder sum registers
	reg FA_5_8_sum_reg;
	reg FA_5_7_sum_reg;
	reg FA_5_6_sum_reg;
	reg FA_5_5_sum_reg;
	reg FA_5_4_sum_reg;
	reg FA_5_3_sum_reg;
	reg FA_5_2_sum_reg;
	reg FA_5_1_sum_reg;
	reg HA_5_1_sum_reg;
	reg FA_4_5_sum_reg;
	reg FA_4_4_sum_reg;
	reg FA_4_3_sum_reg;
	reg FA_4_2_sum_reg;
	reg FA_4_1_sum_reg;
	reg HA_4_1_sum_reg;
	reg FA_3_3_sum_reg;
	reg FA_3_2_sum_reg;
	reg FA_3_1_sum_reg;
	reg HA_3_1_sum_reg;
//	reg FA_2_2_sum_reg;
	reg FA_2_1_sum_double_reg;
	reg HA_2_1_sum_double_reg;
	reg FA1_sum_double_reg;
	reg HA1_sum_double_reg;
	
	// Register declarations for all inputs to the adders
reg FA_5_9_sum_reg;
reg HA_4_2_carry_reg;
reg FA_5_10_sum_reg;
reg FA_5_9_carry_reg;
reg HA_4_3_carry_reg;
reg FA_5_11_sum_reg;
reg FA_5_10_carry_reg;
reg HA_4_4_carry_reg;
reg FA_5_12_sum_reg;
reg FA_5_11_carry_reg;
reg HA_4_5_carry_reg;
reg FA_5_13_sum_reg;
reg FA_5_12_carry_reg;
reg HA_4_6_carry_reg;
reg FA_5_14_sum_reg;
reg FA_5_13_carry_reg;
reg FA_4_20_carry_reg;
reg FA_5_15_sum_reg;
reg FA_5_14_carry_reg;
reg FA_4_22_carry_reg;
reg FA_5_16_sum_reg;
reg FA_5_15_carry_reg;
reg FA_4_24_carry_reg;
reg FA_5_17_sum_reg;
reg FA_5_16_carry_reg;
reg FA_4_26_carry_reg;
reg FA_5_18_sum_reg;
reg FA_5_17_carry_reg;
reg FA_4_28_carry_reg;
reg FA_5_19_sum_reg;
reg FA_5_18_carry_reg;
reg FA_4_30_carry_reg;
reg FA_5_20_sum_reg;
reg FA_5_19_carry_reg;
reg FA_4_32_carry_reg;
reg FA_5_21_sum_reg;
reg FA_5_20_carry_reg;
reg FA_4_34_carry_reg;
reg FA_5_22_sum_reg;
reg FA_5_21_carry_reg;
reg FA_4_36_carry_reg;
reg FA_5_23_sum_reg;
reg FA_5_22_carry_reg;
reg FA_4_38_carry_reg;
reg FA_5_24_sum_reg;
reg FA_5_23_carry_reg;
reg FA_4_40_carry_reg;
reg FA_5_25_sum_reg;
reg FA_5_24_carry_reg;
reg FA_4_42_carry_reg;
reg FA_5_26_sum_reg;
reg FA_5_25_carry_reg;
reg FA_4_44_carry_reg;
reg FA_5_27_sum_reg;
reg FA_5_26_carry_reg;
reg FA_4_46_carry_reg;
reg FA_5_28_sum_reg;
reg FA_5_27_carry_reg;
reg FA_4_48_carry_reg;
reg FA_5_29_sum_reg;
reg FA_5_28_carry_reg;
reg FA_4_50_carry_reg;
reg FA_5_30_sum_reg;
reg FA_5_29_carry_reg;
reg FA_4_52_carry_reg;
reg FA_5_31_sum_reg;
reg FA_5_30_carry_reg;
reg FA_4_54_carry_reg;
reg FA_5_32_sum_reg;
reg FA_5_31_carry_reg;
reg FA_4_56_carry_reg;
reg FA_5_33_sum_reg;
reg FA_5_32_carry_reg;
reg FA_4_58_carry_reg;
reg FA_5_34_sum_reg;
reg FA_5_33_carry_reg;
reg FA_4_60_carry_reg;
reg FA_5_35_sum_reg;
reg FA_5_34_carry_reg;
reg FA_4_62_carry_reg;
reg FA_5_36_sum_reg;
reg FA_5_35_carry_reg;
reg FA_4_64_carry_reg;
reg FA_5_37_sum_reg;
reg FA_5_36_carry_reg;
reg FA_4_66_carry_reg;
reg FA_5_38_sum_reg;
reg FA_5_37_carry_reg;
reg FA_4_68_carry_reg;
reg FA_5_39_sum_reg;
reg FA_5_38_carry_reg;
reg FA_4_70_carry_reg;
reg FA_5_40_sum_reg;
reg FA_5_39_carry_reg;
reg FA_4_72_carry_reg;
reg FA_5_41_sum_reg;
reg FA_5_40_carry_reg;
reg FA_4_74_carry_reg;
reg FA_5_42_sum_reg;
reg FA_5_41_carry_reg;
reg FA_4_76_carry_reg;
reg FA_5_43_sum_reg;
reg FA_5_42_carry_reg;
reg FA_4_78_carry_reg;
reg FA_5_44_sum_reg;
reg FA_5_43_carry_reg;
reg FA_4_80_carry_reg;
reg FA_2_2_sum_double_reg;

// Assuming you have clock and reset signals defined
	always @(posedge clk or negedge rst) begin
		if (!rst) begin
			// Initialize all registers to 0 during reset
			FA_5_9_sum_reg <= 0;
			HA_4_2_carry_reg <= 0;
			FA_5_10_sum_reg <= 0;
			FA_5_9_carry_reg <= 0;
			HA_4_3_carry_reg <= 0;
			FA_5_11_sum_reg <= 0;
			FA_5_10_carry_reg <= 0;
			HA_4_4_carry_reg <= 0;
			FA_5_12_sum_reg <= 0;
			FA_5_11_carry_reg <= 0;
			HA_4_5_carry_reg <= 0;
			FA_5_13_sum_reg <= 0;
			FA_5_12_carry_reg <= 0;
			HA_4_6_carry_reg <= 0;
			FA_5_14_sum_reg <= 0;
			FA_5_13_carry_reg <= 0;
			FA_4_20_carry_reg <= 0;
			FA_5_15_sum_reg <= 0;
			FA_5_14_carry_reg <= 0;
			FA_4_22_carry_reg <= 0;
			FA_5_16_sum_reg <= 0;
			FA_5_15_carry_reg <= 0;
			FA_4_24_carry_reg <= 0;
			FA_5_17_sum_reg <= 0;
			FA_5_16_carry_reg <= 0;
			FA_4_26_carry_reg <= 0;
			FA_5_18_sum_reg <= 0;
			FA_5_17_carry_reg <= 0;
			FA_4_28_carry_reg <= 0;
			FA_5_19_sum_reg <= 0;
			FA_5_18_carry_reg <= 0;
			FA_4_30_carry_reg <= 0;
			FA_5_20_sum_reg <= 0;
			FA_5_19_carry_reg <= 0;
			FA_4_32_carry_reg <= 0;
			FA_5_21_sum_reg <= 0;
			FA_5_20_carry_reg <= 0;
			FA_4_34_carry_reg <= 0;
			FA_5_22_sum_reg <= 0;
			FA_5_21_carry_reg <= 0;
			FA_4_36_carry_reg <= 0;
			FA_5_23_sum_reg <= 0;
			FA_5_22_carry_reg <= 0;
			FA_4_38_carry_reg <= 0;
			FA_5_24_sum_reg <= 0;
			FA_5_23_carry_reg <= 0;
			FA_4_40_carry_reg <= 0;
			FA_5_25_sum_reg <= 0;
			FA_5_24_carry_reg <= 0;
			FA_4_42_carry_reg <= 0;
			FA_5_26_sum_reg <= 0;
			FA_5_25_carry_reg <= 0;
			FA_4_44_carry_reg <= 0;
			FA_5_27_sum_reg <= 0;
			FA_5_26_carry_reg <= 0;
			FA_4_46_carry_reg <= 0;
			FA_5_28_sum_reg <= 0;
			FA_5_27_carry_reg <= 0;
			FA_4_48_carry_reg <= 0;
			FA_5_29_sum_reg <= 0;
			FA_5_28_carry_reg <= 0;
			FA_4_50_carry_reg <= 0;
			FA_5_30_sum_reg <= 0;
			FA_5_29_carry_reg <= 0;
			FA_4_52_carry_reg <= 0;
			FA_5_31_sum_reg <= 0;
			FA_5_30_carry_reg <= 0;
			FA_4_54_carry_reg <= 0;
			FA_5_32_sum_reg <= 0;
			FA_5_31_carry_reg <= 0;
			FA_4_56_carry_reg <= 0;
			FA_5_33_sum_reg <= 0;
			FA_5_32_carry_reg <= 0;
			FA_4_58_carry_reg <= 0;
			FA_5_34_sum_reg <= 0;
			FA_5_33_carry_reg <= 0;
			FA_4_60_carry_reg <= 0;
			FA_5_35_sum_reg <= 0;
			FA_5_34_carry_reg <= 0;
			FA_4_62_carry_reg <= 0;
			FA_5_36_sum_reg <= 0;
			FA_5_35_carry_reg <= 0;
			FA_4_64_carry_reg <= 0;
			FA_5_37_sum_reg <= 0;
			FA_5_36_carry_reg <= 0;
			FA_4_66_carry_reg <= 0;
			FA_5_38_sum_reg <= 0;
			FA_5_37_carry_reg <= 0;
			FA_4_68_carry_reg <= 0;
			FA_5_39_sum_reg <= 0;
			FA_5_38_carry_reg <= 0;
			FA_4_70_carry_reg <= 0;
			FA_5_40_sum_reg <= 0;
			FA_5_39_carry_reg <= 0;
			FA_4_72_carry_reg <= 0;
			FA_5_41_sum_reg <= 0;
			FA_5_40_carry_reg <= 0;
			FA_4_74_carry_reg <= 0;
			FA_5_42_sum_reg <= 0;
			FA_5_41_carry_reg <= 0;
			FA_4_76_carry_reg <= 0;
			FA_5_43_sum_reg <= 0;
			FA_5_42_carry_reg <= 0;
			FA_4_78_carry_reg <= 0;
			FA_5_44_sum_reg <= 0;
			FA_5_43_carry_reg <= 0;
			FA_4_80_carry_reg <= 0;
		end
		else begin
			// Assign non-register counterparts during normal operation
			FA_5_9_sum_reg <= FA_5_9_sum;
			HA_4_2_carry_reg <= HA_4_2_carry;
			FA_5_10_sum_reg <= FA_5_10_sum;
			FA_5_9_carry_reg <= FA_5_9_carry;
			HA_4_3_carry_reg <= HA_4_3_carry;
			FA_5_11_sum_reg <= FA_5_11_sum;
			FA_5_10_carry_reg <= FA_5_10_carry;
			HA_4_4_carry_reg <= HA_4_4_carry;
			FA_5_12_sum_reg <= FA_5_12_sum;
			FA_5_11_carry_reg <= FA_5_11_carry;
			HA_4_5_carry_reg <= HA_4_5_carry;
			FA_5_13_sum_reg <= FA_5_13_sum;
			FA_5_12_carry_reg <= FA_5_12_carry;
			HA_4_6_carry_reg <= HA_4_6_carry;
			FA_5_14_sum_reg <= FA_5_14_sum;
			FA_5_13_carry_reg <= FA_5_13_carry;
			FA_4_20_carry_reg <= FA_4_20_carry;
			FA_5_15_sum_reg <= FA_5_15_sum;
			FA_5_14_carry_reg <= FA_5_14_carry;
			FA_4_22_carry_reg <= FA_4_22_carry;
			FA_5_16_sum_reg <= FA_5_16_sum;
			FA_5_15_carry_reg <= FA_5_15_carry;
			FA_4_24_carry_reg <= FA_4_24_carry;
			FA_5_17_sum_reg <= FA_5_17_sum;
			FA_5_16_carry_reg <= FA_5_16_carry;
			FA_4_26_carry_reg <= FA_4_26_carry;
			FA_5_18_sum_reg <= FA_5_18_sum;
			FA_5_17_carry_reg <= FA_5_17_carry;
			FA_4_28_carry_reg <= FA_4_28_carry;
			FA_5_19_sum_reg <= FA_5_19_sum;
			FA_5_18_carry_reg <= FA_5_18_carry;
			FA_4_30_carry_reg <= FA_4_30_carry;
			FA_5_20_sum_reg <= FA_5_20_sum;
			FA_5_19_carry_reg <= FA_5_19_carry;
			FA_4_32_carry_reg <= FA_4_32_carry;
			FA_5_21_sum_reg <= FA_5_21_sum;
			FA_5_20_carry_reg <= FA_5_20_carry;
			FA_4_34_carry_reg <= FA_4_34_carry;
			FA_5_22_sum_reg <= FA_5_22_sum;
			FA_5_21_carry_reg <= FA_5_21_carry;
			FA_4_36_carry_reg <= FA_4_36_carry;
			FA_5_23_sum_reg <= FA_5_23_sum;
			FA_5_22_carry_reg <= FA_5_22_carry;
			FA_4_38_carry_reg <= FA_4_38_carry;
			FA_5_24_sum_reg <= FA_5_24_sum;
			FA_5_23_carry_reg <= FA_5_23_carry;
			FA_4_40_carry_reg <= FA_4_40_carry;
			FA_5_25_sum_reg <= FA_5_25_sum;
			FA_5_24_carry_reg <= FA_5_24_carry;
			FA_4_42_carry_reg <= FA_4_42_carry;
			FA_5_26_sum_reg <= FA_5_26_sum;
			FA_5_25_carry_reg <= FA_5_25_carry;
			FA_4_44_carry_reg <= FA_4_44_carry;
			FA_5_27_sum_reg <= FA_5_27_sum;
			FA_5_26_carry_reg <= FA_5_26_carry;
			FA_4_46_carry_reg <= FA_4_46_carry;
			FA_5_28_sum_reg <= FA_5_28_sum;
			FA_5_27_carry_reg <= FA_5_27_carry;
			FA_4_48_carry_reg <= FA_4_48_carry;
			FA_5_29_sum_reg <= FA_5_29_sum;
			FA_5_28_carry_reg <= FA_5_28_carry;
			FA_4_50_carry_reg <= FA_4_50_carry;
			FA_5_30_sum_reg <= FA_5_30_sum;
			FA_5_29_carry_reg <= FA_5_29_carry;
			FA_4_52_carry_reg <= FA_4_52_carry;
			FA_5_31_sum_reg <= FA_5_31_sum;
			FA_5_30_carry_reg <= FA_5_30_carry;
			FA_4_54_carry_reg <= FA_4_54_carry;
			FA_5_32_sum_reg <= FA_5_32_sum;
			FA_5_31_carry_reg <= FA_5_31_carry;
			FA_4_56_carry_reg <= FA_4_56_carry;
			FA_5_33_sum_reg <= FA_5_33_sum;
			FA_5_32_carry_reg <= FA_5_32_carry;
			FA_4_58_carry_reg <= FA_4_58_carry;
			FA_5_34_sum_reg <= FA_5_34_sum;
			FA_5_33_carry_reg <= FA_5_33_carry;
			FA_4_60_carry_reg <= FA_4_60_carry;
			FA_5_35_sum_reg <= FA_5_35_sum;
			FA_5_34_carry_reg <= FA_5_34_carry;
			FA_4_62_carry_reg <= FA_4_62_carry;
			FA_5_36_sum_reg <= FA_5_36_sum;
			FA_5_35_carry_reg <= FA_5_35_carry;
			FA_4_64_carry_reg <= FA_4_64_carry;
			FA_5_37_sum_reg <= FA_5_37_sum;
			FA_5_36_carry_reg <= FA_5_36_carry;
			FA_4_66_carry_reg <= FA_4_66_carry;
			FA_5_38_sum_reg <= FA_5_38_sum;
			FA_5_37_carry_reg <= FA_5_37_carry;
			FA_4_68_carry_reg <= FA_4_68_carry;
			FA_5_39_sum_reg <= FA_5_39_sum;
			FA_5_38_carry_reg <= FA_5_38_carry;
			FA_4_70_carry_reg <= FA_4_70_carry;
			FA_5_40_sum_reg <= FA_5_40_sum;
			FA_5_39_carry_reg <= FA_5_39_carry;
			FA_4_72_carry_reg <= FA_4_72_carry;
			FA_5_41_sum_reg <= FA_5_41_sum;
			FA_5_40_carry_reg <= FA_5_40_carry;
			FA_4_74_carry_reg <= FA_4_74_carry;
			FA_5_42_sum_reg <= FA_5_42_sum;
			FA_5_41_carry_reg <= FA_5_41_carry;
			FA_4_76_carry_reg <= FA_4_76_carry;
			FA_5_43_sum_reg <= FA_5_43_sum;
			FA_5_42_carry_reg <= FA_5_42_carry;
			FA_4_78_carry_reg <= FA_4_78_carry;
			FA_5_44_sum_reg <= FA_5_44_sum;
			FA_5_43_carry_reg <= FA_5_43_carry;
			FA_4_80_carry_reg <= FA_4_80_carry;
		end
	end
    
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
			P12_triple <= 0;
			P13_triple <= 0;
			P14_triple <= 0;
			P15_triple <= 0;
			P16_triple <= 0;
			
			FA_5_8_carry_reg <= 0;
			FA_5_7_carry_reg <= 0;
			FA_5_6_carry_reg <= 0;
			FA_5_5_carry_reg <= 0;
			FA_5_4_carry_reg <= 0;
			FA_5_3_carry_reg <= 0;
			FA_5_2_carry_reg <= 0;
			FA_5_1_carry_reg <= 0;
			HA_5_1_carry_reg <= 0;
			FA_4_5_carry_reg <= 0;
			FA_4_4_carry_reg <= 0;
			FA_4_3_carry_reg <= 0;
			FA_4_2_carry_reg <= 0;
			FA_4_1_carry_reg <= 0;
			HA_4_1_carry_reg <= 0;
			HA_2_2_carry_double_reg <= 0;
			FA_3_2_carry_reg <= 0;
			FA_3_1_carry_reg <= 0;
			HA_3_1_carry_reg <= 0;
			FA_2_2_carry_double_reg <= 0;
			FA_2_1_carry_double_reg <= 0;
			HA_2_1_carry_double_reg <= 0;
			HA1_carry_double_reg <= 0;
			
			// Full Adder and Half Adder sum registers
			FA_5_8_sum_reg <= 0;
			FA_5_7_sum_reg <= 0;
			FA_5_6_sum_reg <= 0;
			FA_5_5_sum_reg <= 0;
			FA_5_4_sum_reg <= 0;
			FA_5_3_sum_reg <= 0;
			FA_5_2_sum_reg <= 0;
			FA_5_1_sum_reg <= 0;
			HA_5_1_sum_reg <= 0;
			FA_4_5_sum_reg <= 0;
			FA_4_4_sum_reg <= 0;
			FA_4_3_sum_reg <= 0;
			FA_4_2_sum_reg <= 0;
			FA_4_1_sum_reg <= 0;
			HA_4_1_sum_reg <= 0;
			FA_3_3_sum_reg <= 0;
			FA_3_2_sum_reg <= 0;
			FA_3_1_sum_reg <= 0;
			HA_3_1_sum_reg <= 0;
			FA_2_2_sum_double_reg <= 0;
			FA_2_1_sum_double_reg <= 0;
			HA_2_1_sum_double_reg <= 0;
			FA1_sum_double_reg <= 0;
			HA1_sum_double_reg <= 0;
			
			
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
			P12_triple <= P12_double;
			P13_triple <= P13_double;
			P14_triple <= P14_double;
			P15_triple <= P15_double;
			P16_triple <= P16_double;
			
			FA_5_8_carry_reg <= FA_5_8_carry;
			FA_5_7_carry_reg <= FA_5_7_carry;
			FA_5_6_carry_reg <= FA_5_6_carry;
			FA_5_5_carry_reg <= FA_5_5_carry;
			FA_5_4_carry_reg <= FA_5_4_carry;
			FA_5_3_carry_reg <= FA_5_3_carry;
			FA_5_2_carry_reg <= FA_5_2_carry;
			FA_5_1_carry_reg <= FA_5_1_carry;
			HA_5_1_carry_reg <= HA_5_1_carry;
			FA_4_5_carry_reg <= FA_4_5_carry;
			FA_4_4_carry_reg <= FA_4_4_carry;
			FA_4_3_carry_reg <= FA_4_3_carry;
			FA_4_2_carry_reg <= FA_4_2_carry;
			FA_4_1_carry_reg <= FA_4_1_carry;
			HA_4_1_carry_reg <= HA_4_1_carry;
			HA_2_2_carry_double_reg <= HA_2_2_carry_reg;
			FA_3_2_carry_reg <= FA_3_2_carry;
			FA_3_1_carry_reg <= FA_3_1_carry;
			HA_3_1_carry_reg <= HA_3_1_carry;
			FA_2_2_carry_double_reg <= FA_2_2_carry_reg;
			FA_2_1_carry_double_reg <= FA_2_1_carry_reg;
			HA_2_1_carry_double_reg <= HA_2_1_carry_reg;
			HA1_carry_double_reg <= HA1_carry_reg;
			
			// Full Adder and Half Adder sum registers
			FA_5_8_sum_reg <= FA_5_8_sum;
			FA_5_7_sum_reg <= FA_5_7_sum;
			FA_5_6_sum_reg <= FA_5_6_sum;
			FA_5_5_sum_reg <= FA_5_5_sum;
			FA_5_4_sum_reg <= FA_5_4_sum;
			FA_5_3_sum_reg <= FA_5_3_sum;
			FA_5_2_sum_reg <= FA_5_2_sum;
			FA_5_1_sum_reg <= FA_5_1_sum;
			HA_5_1_sum_reg <= HA_5_1_sum;
			FA_4_5_sum_reg <= FA_4_5_sum;
			FA_4_4_sum_reg <= FA_4_4_sum;
			FA_4_3_sum_reg <= FA_4_3_sum;
			FA_4_2_sum_reg <= FA_4_2_sum;
			FA_4_1_sum_reg <= FA_4_1_sum;
			HA_4_1_sum_reg <= HA_4_1_sum;
			FA_3_3_sum_reg <= FA_3_3_sum;
			FA_3_2_sum_reg <= FA_3_2_sum;
			FA_3_1_sum_reg <= FA_3_1_sum;
			HA_3_1_sum_reg <= HA_3_1_sum;
			FA_2_2_sum_double_reg <= FA_2_2_sum_reg;
			FA_2_1_sum_double_reg <= FA_2_1_sum_reg;
			HA_2_1_sum_double_reg <= HA_2_1_sum_reg;
			FA1_sum_double_reg <= FA1_sum_reg;
			HA1_sum_double_reg <= HA1_sum_reg;
    	end
    end


//    HalfAdder HA_6_1 (FA_5_9_sum, HA_4_2_carry, HA_6_1_sum, HA_6_1_carry);
//    FullAdder FA_6_1 (FA_5_10_sum, FA_5_9_carry , HA_4_3_carry, FA_6_1_sum, FA_6_1_carry);
//    FullAdder FA_6_2 (FA_5_11_sum, FA_5_10_carry , HA_4_4_carry, FA_6_2_sum, FA_6_2_carry);
//    FullAdder FA_6_3 (FA_5_12_sum, FA_5_11_carry , HA_4_5_carry, FA_6_3_sum, FA_6_3_carry);
//    FullAdder FA_6_4 (FA_5_13_sum, FA_5_12_carry , HA_4_6_carry, FA_6_4_sum, FA_6_4_carry);
//    FullAdder FA_6_5 (FA_5_14_sum, FA_5_13_carry , FA_4_20_carry, FA_6_5_sum, FA_6_5_carry);
//    FullAdder FA_6_6 (FA_5_15_sum, FA_5_14_carry , FA_4_22_carry, FA_6_6_sum, FA_6_6_carry);
    
//    FullAdder FA_6_7 (FA_5_16_sum, FA_5_15_carry, FA_4_24_carry, FA_6_7_sum, FA_6_7_carry);
//    FullAdder FA_6_8 (FA_5_17_sum, FA_5_16_carry, FA_4_26_carry, FA_6_8_sum, FA_6_8_carry);
//    FullAdder FA_6_9 (FA_5_18_sum, FA_5_17_carry, FA_4_28_carry, FA_6_9_sum, FA_6_9_carry);
//    FullAdder FA_6_10 (FA_5_19_sum, FA_5_18_carry, FA_4_30_carry, FA_6_10_sum, FA_6_10_carry);
//    FullAdder FA_6_11 (FA_5_20_sum, FA_5_19_carry, FA_4_32_carry, FA_6_11_sum, FA_6_11_carry);
//    FullAdder FA_6_12 (FA_5_21_sum, FA_5_20_carry, FA_4_34_carry, FA_6_12_sum, FA_6_12_carry);
//    FullAdder FA_6_13 (FA_5_22_sum, FA_5_21_carry, FA_4_36_carry, FA_6_13_sum, FA_6_13_carry);
//    FullAdder FA_6_14 (FA_5_23_sum, FA_5_22_carry, FA_4_38_carry, FA_6_14_sum, FA_6_14_carry);
//    FullAdder FA_6_15 (FA_5_24_sum, FA_5_23_carry, FA_4_40_carry, FA_6_15_sum, FA_6_15_carry);
//    FullAdder FA_6_16 (FA_5_25_sum, FA_5_24_carry, FA_4_42_carry, FA_6_16_sum, FA_6_16_carry);
//    FullAdder FA_6_17 (FA_5_26_sum, FA_5_25_carry, FA_4_44_carry, FA_6_17_sum, FA_6_17_carry);
//    FullAdder FA_6_18 (FA_5_27_sum, FA_5_26_carry, FA_4_46_carry, FA_6_18_sum, FA_6_18_carry);
//    FullAdder FA_6_19 (FA_5_28_sum, FA_5_27_carry, FA_4_48_carry, FA_6_19_sum, FA_6_19_carry);
//    FullAdder FA_6_20 (FA_5_29_sum, FA_5_28_carry, FA_4_50_carry, FA_6_20_sum, FA_6_20_carry);
//    FullAdder FA_6_21 (FA_5_30_sum, FA_5_29_carry, FA_4_52_carry, FA_6_21_sum, FA_6_21_carry);
//    FullAdder FA_6_22 (FA_5_31_sum, FA_5_30_carry, FA_4_54_carry, FA_6_22_sum, FA_6_22_carry);
//    FullAdder FA_6_23 (FA_5_32_sum, FA_5_31_carry, FA_4_56_carry, FA_6_23_sum, FA_6_23_carry);
//    FullAdder FA_6_24 (FA_5_33_sum, FA_5_32_carry, FA_4_58_carry, FA_6_24_sum, FA_6_24_carry);
//    FullAdder FA_6_25 (FA_5_34_sum, FA_5_33_carry, FA_4_60_carry, FA_6_25_sum, FA_6_25_carry);
//    FullAdder FA_6_26 (FA_5_35_sum, FA_5_34_carry, FA_4_62_carry, FA_6_26_sum, FA_6_26_carry);
//    FullAdder FA_6_27 (FA_5_36_sum, FA_5_35_carry, FA_4_64_carry, FA_6_27_sum, FA_6_27_carry);
//    FullAdder FA_6_28 (FA_5_37_sum, FA_5_36_carry, FA_4_66_carry, FA_6_28_sum, FA_6_28_carry);
//    FullAdder FA_6_29 (FA_5_38_sum, FA_5_37_carry, FA_4_68_carry, FA_6_29_sum, FA_6_29_carry);
//    FullAdder FA_6_30 (FA_5_39_sum, FA_5_38_carry, FA_4_70_carry, FA_6_30_sum, FA_6_30_carry);
//    FullAdder FA_6_31 (FA_5_40_sum, FA_5_39_carry, FA_4_72_carry, FA_6_31_sum, FA_6_31_carry);
//    FullAdder FA_6_32 (FA_5_41_sum, FA_5_40_carry, FA_4_74_carry, FA_6_32_sum, FA_6_32_carry);
//    FullAdder FA_6_33 (FA_5_42_sum, FA_5_41_carry, FA_4_76_carry, FA_6_33_sum, FA_6_33_carry);
//    FullAdder FA_6_34 (FA_5_43_sum, FA_5_42_carry, FA_4_78_carry, FA_6_34_sum, FA_6_34_carry);
//    FullAdder FA_6_35 (FA_5_44_sum, FA_5_43_carry, FA_4_80_carry, FA_6_35_sum, FA_6_35_carry);

	HalfAdder HA_6_1 (FA_5_9_sum_reg, HA_4_2_carry_reg, HA_6_1_sum, HA_6_1_carry);
	FullAdder FA_6_1 (FA_5_10_sum_reg, FA_5_9_carry_reg, HA_4_3_carry_reg, FA_6_1_sum, FA_6_1_carry);
	FullAdder FA_6_2 (FA_5_11_sum_reg, FA_5_10_carry_reg, HA_4_4_carry_reg, FA_6_2_sum, FA_6_2_carry);
	FullAdder FA_6_3 (FA_5_12_sum_reg, FA_5_11_carry_reg, HA_4_5_carry_reg, FA_6_3_sum, FA_6_3_carry);
	FullAdder FA_6_4 (FA_5_13_sum_reg, FA_5_12_carry_reg, HA_4_6_carry_reg, FA_6_4_sum, FA_6_4_carry);
	FullAdder FA_6_5 (FA_5_14_sum_reg, FA_5_13_carry_reg, FA_4_20_carry_reg, FA_6_5_sum, FA_6_5_carry);
	FullAdder FA_6_6 (FA_5_15_sum_reg, FA_5_14_carry_reg, FA_4_22_carry_reg, FA_6_6_sum, FA_6_6_carry);
	
	FullAdder FA_6_7 (FA_5_16_sum_reg, FA_5_15_carry_reg, FA_4_24_carry_reg, FA_6_7_sum, FA_6_7_carry);
	FullAdder FA_6_8 (FA_5_17_sum_reg, FA_5_16_carry_reg, FA_4_26_carry_reg, FA_6_8_sum, FA_6_8_carry);
	FullAdder FA_6_9 (FA_5_18_sum_reg, FA_5_17_carry_reg, FA_4_28_carry_reg, FA_6_9_sum, FA_6_9_carry);
	FullAdder FA_6_10 (FA_5_19_sum_reg, FA_5_18_carry_reg, FA_4_30_carry_reg, FA_6_10_sum, FA_6_10_carry);
	FullAdder FA_6_11 (FA_5_20_sum_reg, FA_5_19_carry_reg, FA_4_32_carry_reg, FA_6_11_sum, FA_6_11_carry);
	FullAdder FA_6_12 (FA_5_21_sum_reg, FA_5_20_carry_reg, FA_4_34_carry_reg, FA_6_12_sum, FA_6_12_carry);
	FullAdder FA_6_13 (FA_5_22_sum_reg, FA_5_21_carry_reg, FA_4_36_carry_reg, FA_6_13_sum, FA_6_13_carry);
	FullAdder FA_6_14 (FA_5_23_sum_reg, FA_5_22_carry_reg, FA_4_38_carry_reg, FA_6_14_sum, FA_6_14_carry);
	FullAdder FA_6_15 (FA_5_24_sum_reg, FA_5_23_carry_reg, FA_4_40_carry_reg, FA_6_15_sum, FA_6_15_carry);
	FullAdder FA_6_16 (FA_5_25_sum_reg, FA_5_24_carry_reg, FA_4_42_carry_reg, FA_6_16_sum, FA_6_16_carry);
	FullAdder FA_6_17 (FA_5_26_sum_reg, FA_5_25_carry_reg, FA_4_44_carry_reg, FA_6_17_sum, FA_6_17_carry);
	FullAdder FA_6_18 (FA_5_27_sum_reg, FA_5_26_carry_reg, FA_4_46_carry_reg, FA_6_18_sum, FA_6_18_carry);
	FullAdder FA_6_19 (FA_5_28_sum_reg, FA_5_27_carry_reg, FA_4_48_carry_reg, FA_6_19_sum, FA_6_19_carry);
	FullAdder FA_6_20 (FA_5_29_sum_reg, FA_5_28_carry_reg, FA_4_50_carry_reg, FA_6_20_sum, FA_6_20_carry);
	FullAdder FA_6_21 (FA_5_30_sum_reg, FA_5_29_carry_reg, FA_4_52_carry_reg, FA_6_21_sum, FA_6_21_carry);
	FullAdder FA_6_22 (FA_5_31_sum_reg, FA_5_30_carry_reg, FA_4_54_carry_reg, FA_6_22_sum, FA_6_22_carry);
	FullAdder FA_6_23 (FA_5_32_sum_reg, FA_5_31_carry_reg, FA_4_56_carry_reg, FA_6_23_sum, FA_6_23_carry);
	FullAdder FA_6_24 (FA_5_33_sum_reg, FA_5_32_carry_reg, FA_4_58_carry_reg, FA_6_24_sum, FA_6_24_carry);
	FullAdder FA_6_25 (FA_5_34_sum_reg, FA_5_33_carry_reg, FA_4_60_carry_reg, FA_6_25_sum, FA_6_25_carry);
	FullAdder FA_6_26 (FA_5_35_sum_reg, FA_5_34_carry_reg, FA_4_62_carry_reg, FA_6_26_sum, FA_6_26_carry);
	FullAdder FA_6_27 (FA_5_36_sum_reg, FA_5_35_carry_reg, FA_4_64_carry_reg, FA_6_27_sum, FA_6_27_carry);
	FullAdder FA_6_28 (FA_5_37_sum_reg, FA_5_36_carry_reg, FA_4_66_carry_reg, FA_6_28_sum, FA_6_28_carry);
	FullAdder FA_6_29 (FA_5_38_sum_reg, FA_5_37_carry_reg, FA_4_68_carry_reg, FA_6_29_sum, FA_6_29_carry);
	FullAdder FA_6_30 (FA_5_39_sum_reg, FA_5_38_carry_reg, FA_4_70_carry_reg, FA_6_30_sum, FA_6_30_carry);
	FullAdder FA_6_31 (FA_5_40_sum_reg, FA_5_39_carry_reg, FA_4_72_carry_reg, FA_6_31_sum, FA_6_31_carry);
	FullAdder FA_6_32 (FA_5_41_sum_reg, FA_5_40_carry_reg, FA_4_74_carry_reg, FA_6_32_sum, FA_6_32_carry);
	FullAdder FA_6_33 (FA_5_42_sum_reg, FA_5_41_carry_reg, FA_4_76_carry_reg, FA_6_33_sum, FA_6_33_carry);
	FullAdder FA_6_34 (FA_5_43_sum_reg, FA_5_42_carry_reg, FA_4_78_carry_reg, FA_6_34_sum, FA_6_34_carry);
	FullAdder FA_6_35 (FA_5_44_sum_reg, FA_5_43_carry_reg, FA_4_80_carry_reg, FA_6_35_sum, FA_6_35_carry);

    
    
        

    // Final Addition Stage using Carry Propagate Adder

wire [63:0] arg1 = {
    FA_6_35_sum, FA_6_34_sum, FA_6_33_sum, FA_6_32_sum,
    FA_6_31_sum, FA_6_30_sum, FA_6_29_sum, FA_6_28_sum,
    FA_6_27_sum, FA_6_26_sum, FA_6_25_sum, FA_6_24_sum,
    FA_6_23_sum, FA_6_22_sum, FA_6_21_sum, FA_6_20_sum,
    FA_6_19_sum, FA_6_18_sum, FA_6_17_sum, FA_6_16_sum,
    FA_6_15_sum, FA_6_14_sum, FA_6_13_sum, FA_6_12_sum,
    FA_6_11_sum, FA_6_10_sum, FA_6_9_sum, FA_6_8_sum,
    FA_6_7_sum, FA_6_6_sum, FA_6_5_sum, FA_6_4_sum,
    FA_6_3_sum, FA_6_2_sum, FA_6_1_sum, HA_6_1_sum,
    FA_5_8_sum_reg, FA_5_7_sum_reg, FA_5_6_sum_reg, FA_5_5_sum_reg,
    FA_5_4_sum_reg, FA_5_3_sum_reg, FA_5_2_sum_reg, FA_5_1_sum_reg,
    HA_5_1_sum_reg, FA_4_5_sum_reg, FA_4_4_sum_reg, FA_4_3_sum_reg,
    FA_4_2_sum_reg, FA_4_1_sum_reg, HA_4_1_sum_reg, FA_3_3_sum_reg,
    FA_3_2_sum_reg, FA_3_1_sum_reg, HA_3_1_sum_reg, FA_2_2_sum_double_reg,
    FA_2_1_sum_double_reg, HA_2_1_sum_double_reg, FA1_sum_double_reg, HA1_sum_double_reg,
    P1_triple[3], P1_triple[2], P1_triple[1], P1_triple[0]
};
wire [63:0] arg2 = {
    FA_6_34_carry, FA_6_33_carry, FA_6_32_carry, FA_6_31_carry,
    FA_6_30_carry, FA_6_29_carry, FA_6_28_carry, FA_6_27_carry,
    FA_6_26_carry, FA_6_25_carry, FA_6_24_carry, FA_6_23_carry,
    FA_6_22_carry, FA_6_21_carry, FA_6_20_carry, FA_6_19_carry,
    FA_6_18_carry, FA_6_17_carry, FA_6_16_carry, FA_6_15_carry,
    FA_6_14_carry, FA_6_13_carry, FA_6_12_carry, FA_6_11_carry,
    FA_6_10_carry, FA_6_9_carry, FA_6_8_carry, FA_6_7_carry,
    FA_6_6_carry, FA_6_5_carry, FA_6_4_carry, FA_6_3_carry,
    FA_6_2_carry, FA_6_1_carry, HA_6_1_carry, FA_5_8_carry_reg,
    FA_5_7_carry_reg, FA_5_6_carry_reg, FA_5_5_carry_reg, FA_5_4_carry_reg,
    FA_5_3_carry_reg, FA_5_2_carry_reg, FA_5_1_carry_reg, HA_5_1_carry_reg,
    FA_4_5_carry_reg, FA_4_4_carry_reg, FA_4_3_carry_reg, FA_4_2_carry_reg,
    FA_4_1_carry_reg, HA_4_1_carry_reg, HA_2_2_carry_double_reg, FA_3_2_carry_reg,
    FA_3_1_carry_reg, HA_3_1_carry_reg, FA_2_2_carry_double_reg, FA_2_1_carry_double_reg,
    HA_2_1_carry_double_reg, P4_double[0], HA1_carry_double_reg, P3_triple[0],
    P2_triple[1], P2_triple[0], 1'b0, 1'b0
};

    
    //FA9_carry?
    //16:0 and truncate?
    
    // Implement CPA (CRA)
    
    
    // Initialize first carry-in
    assign carries[0] = 1'b0;
    
    // Generate all the carries and sums
    genvar i;
    generate
      for (i = 0; i < 64; i = i + 1) begin: cpa_loop
        assign sum[i] = arg1[i] ^ arg2[i] ^ carries[i];
        assign carries[i+1] = (arg1[i] & arg2[i]) | (arg1[i] & carries[i]) | (arg2[i] & carries[i]);
      end
    endgenerate

endmodule


