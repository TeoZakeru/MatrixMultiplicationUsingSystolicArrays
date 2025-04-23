module SystolicArray #(parameter SIZE = 8, parameter DATA_WIDTH = 8)(
    input [SIZE*DATA_WIDTH-1:0] A,
    input [SIZE*DATA_WIDTH-1:0] B,
    input clk,
    input rst,
    output reg done,
    output reg [SIZE*SIZE*2*DATA_WIDTH-1:0] C
);

wire [(SIZE*SIZE)*DATA_WIDTH-1:0] c;
wire [(SIZE*SIZE)*DATA_WIDTH-1:0] d;
wire [(SIZE*SIZE)*2*DATA_WIDTH-1:0] C_out;
wire [DATA_WIDTH-1:0] A_array [0 : SIZE-1];
wire [DATA_WIDTH-1:0] B_array [0 : SIZE-1];
//wire [DATA_WIDTH+1:0] x3_Y_in [0 : SIZE-1];
wire [DATA_WIDTH-1:0] Y_out [0 : SIZE-1][0 : SIZE-1];
wire [DATA_WIDTH+1:0] x3_Y_out [0 : SIZE-1][0 : SIZE-1];
reg [7:0] count;  // Register for counting cycles
reg [SIZE*DATA_WIDTH - 1:0] A_reg, B_reg;
//wire [SIZE*DATA_WIDTH-1 : 0] A_wire, B_wire;

wire [((DATA_WIDTH+2)/3)-1:0] s_in[0 : SIZE-1];
wire [((DATA_WIDTH+2)/3)-1:0] t_in[0 : SIZE-1];
wire [((DATA_WIDTH+2)/3)-1:0] d_in[0 : SIZE-1];
wire [((DATA_WIDTH+2)/3)-1:0] q_in[0 : SIZE-1];
wire [((DATA_WIDTH+2)/3)-1:0] n_in[0 : SIZE-1];

wire [((DATA_WIDTH+2)/3)-1:0] s_out[0 : SIZE-1][0 : SIZE-1];
wire [((DATA_WIDTH+2)/3)-1:0] t_out[0 : SIZE-1][0 : SIZE-1];
wire [((DATA_WIDTH+2)/3)-1:0] d_out[0 : SIZE-1][0 : SIZE-1];
wire [((DATA_WIDTH+2)/3)-1:0] q_out[0 : SIZE-1][0 : SIZE-1];
wire [((DATA_WIDTH+2)/3)-1:0] n_out[0 : SIZE-1][0 : SIZE-1];

wire [2:0] PC [0:SIZE-1];
wire [2:0] PC_out [0:SIZE-1][0 : SIZE-1];

genvar m;
//always @(*) begin
generate
	for (m = 0; m < SIZE; m = m + 1) begin
		assign A_array[m] = (A_reg[m*DATA_WIDTH + DATA_WIDTH - 1] & B_reg[m*DATA_WIDTH + DATA_WIDTH - 1])?~A_reg[m*DATA_WIDTH +: DATA_WIDTH]+1'b1:((A_reg[m*DATA_WIDTH + DATA_WIDTH - 1])?B_reg[m*DATA_WIDTH +: DATA_WIDTH]:A_reg[m*DATA_WIDTH +: DATA_WIDTH]);
		assign B_array[m] = (A_reg[m*DATA_WIDTH + DATA_WIDTH - 1] & B_reg[m*DATA_WIDTH + DATA_WIDTH - 1])?~B_reg[m*DATA_WIDTH +: DATA_WIDTH]+1'b1:((A_reg[m*DATA_WIDTH + DATA_WIDTH - 1])?A_reg[m*DATA_WIDTH +: DATA_WIDTH]:B_reg[m*DATA_WIDTH +: DATA_WIDTH]);
		
		HCP_2222 hcp_outside_PE(
            .Y(B_array[m]),
            .PC(PC[m])
        );
        
//		assign x3_Y_in[m] = ({{2{B_array[m][DATA_WIDTH-1]}}, B_array[m]} << 1) + {{2{B_array[m][DATA_WIDTH-1]}}, B_array[m]};
	end
endgenerate





always @(posedge clk or negedge rst) begin
	if(!rst) begin
		A_reg <= 0;
		B_reg <= 0;
		C <= 0;
	end
	else begin
		A_reg <= A;
		B_reg <= B;
		C <= C_out;
	end
end

genvar i,j;
generate
	for(i = 0;i <SIZE;i = i+1) begin
		for(j = 0; j< SIZE; j = j+1) begin
			if(i == 0 && j == 0) begin
				boothRecoding #(
				.DATA_WIDTH(DATA_WIDTH)
				) booth(
				.X(A_array[0]),
				.clk(clk),
				.rst(rst),
				.s(s_in[0]),
				.d(d_in[0]),
				.t(t_in[0]),
				.q(q_in[0]),
				.n(n_in[0])
				);
				PE #(
				.DATA_WIDTH(DATA_WIDTH)
				) pe(
				.Y_in(B_array[0]), 
				.PC(PC[0]), 
				.s_in(s_in[0]),
				.t_in(t_in[0]),
				.d_in(d_in[0]),
				.q_in(q_in[0]),
				.n_in(n_in[0]),
				.clk(clk), 
				.rst(rst),
				.Y_out(Y_out[0][0]),
				.PC_out(PC_out[0][0]),
				.s_out(s_out[0][0]),
				.t_out(t_out[0][0]),
				.d_out(d_out[0][0]),
				.q_out(q_out[0][0]),
				.n_out(n_out[0][0]),
				.C_out(C_out[0 +: (2*DATA_WIDTH)])
			);
			end
			else if(j == 0) begin
				boothRecoding #(
				.DATA_WIDTH(DATA_WIDTH)
				) booth(
				.X(A_array[i]),
				.clk(clk),
				.rst(rst),
				.s(s_in[i]),
				.d(d_in[i]),
				.t(t_in[i]),
				.q(q_in[i]),
				.n(n_in[i])
				);
				PE #(
				.DATA_WIDTH(DATA_WIDTH)
				) pe(
				.Y_in(Y_out[i-1][0]), 
				.PC(PC_out[i-1][0]), 
				.s_in(s_in[i]),
				.t_in(t_in[i]),
				.d_in(d_in[i]),
				.q_in(q_in[i]),
				.n_in(n_in[i]),
				.clk(clk), 
				.rst(rst),
				.Y_out(Y_out[i][0]),
				.PC_out(PC_out[i][0]),
				.s_out(s_out[i][0]),
				.t_out(t_out[i][0]),
				.d_out(d_out[i][0]),
				.q_out(q_out[i][0]),
				.n_out(n_out[i][0]),
				.C_out(C_out[(i*SIZE+j)*2*DATA_WIDTH +: (2*DATA_WIDTH)])
			);
			end
			else if(i == 0) begin
				PE #(
				.DATA_WIDTH(DATA_WIDTH)
				) pe(
				.Y_in(B_array[j]), 
				.PC(PC[j]), 
				.s_in(s_out[0][j-1]),
				.t_in(t_out[0][j-1]),
				.d_in(d_out[0][j-1]),
				.q_in(q_out[0][j-1]),
				.n_in(n_out[0][j-1]),
				.clk(clk), 
				.rst(rst),
				.Y_out(Y_out[0][j]),
				.PC_out(PC_out[0][j]),
				.s_out(s_out[0][j]),
				.t_out(t_out[0][j]),
				.d_out(d_out[0][j]),
				.q_out(q_out[0][j]),
				.n_out(n_out[0][j]),
				.C_out(C_out[(i*SIZE+j)*2*DATA_WIDTH +: (2*DATA_WIDTH)])
			);
			end
			else begin
				PE #(
				.DATA_WIDTH(DATA_WIDTH)
				) pe(
				.Y_in(Y_out[i-1][j]), 
				.PC(PC_out[i-1][j]), 
				.s_in(s_out[i][j-1]),
				.t_in(t_out[i][j-1]),
				.d_in(d_out[i][j-1]),
				.q_in(q_out[i][j-1]),
				.n_in(n_out[i][j-1]),
				.clk(clk), 
				.rst(rst),
				.Y_out(Y_out[i][j]),
				.PC_out(PC_out[i][j]),
				.s_out(s_out[i][j]),
				.t_out(t_out[i][j]),
				.d_out(d_out[i][j]),
				.q_out(q_out[i][j]),
				.n_out(n_out[i][j]),
				.C_out(C_out[(i*SIZE+j)*2*DATA_WIDTH +: (2*DATA_WIDTH)])
			);
			end
		end
	end
endgenerate

//assign C = C_out;
// Cycle counter for computation completion
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        done <= 0;
        count <= 0;
    end else begin
        if (count == (2*SIZE+1)) begin
            done <= 1;
        end else begin
            done <= 0;
            count <= count + 1;
        end
    end
end

endmodule

module boothRecoding #(parameter DATA_WIDTH = 8)(
	input [DATA_WIDTH-1:0] X,
	input clk,
	input rst,
	output reg [((DATA_WIDTH+2)/3)-1:0] s,
	output reg [((DATA_WIDTH+2)/3)-1:0] t,
	output reg [((DATA_WIDTH+2)/3)-1:0] d,
	output reg [((DATA_WIDTH+2)/3)-1:0] q,
	output reg [((DATA_WIDTH+2)/3)-1:0] n
);
	wire [DATA_WIDTH+3:0] Q;
	assign Q = {{3{X[DATA_WIDTH-1]}}, X, 1'b0}; // Extend sign for Booth encoding
	localparam NUM_PARTIALS = (DATA_WIDTH + 2) / 3; // Compute ceil(N/3)
	genvar i;
	generate
			for (i = 0; i < NUM_PARTIALS; i = i + 1) begin : booth_gen
				always @(posedge clk or negedge rst) begin
					if(!rst) begin
						s[i] <= 0;
						d[i] <= 0;
						t[i] <= 0;
						q[i] <= 0;
						n[i] <= 0;
					end
					else begin
						s[i] <= ~(Q[3*i+3]^Q[3*i+2])^(Q[3*i+1]^Q[3*i]);
						d[i] <= (Q[3*i+2]^Q[3*i+1])^(~(Q[3*i+1]^Q[3*i]));
						t[i] <= (Q[3*i+3]^Q[3*i+2])^(Q[3*i+1]^Q[3*i]);
						q[i] <= (Q[3*i+3]^Q[3*i+2])^(~(Q[3*i+2]^Q[3*i+1]))^(~(Q[3*i+1]^Q[3*i]));
						n[i] <= Q[3*i+3];
					end
				end
			end
	endgenerate
endmodule

module PE #(parameter DATA_WIDTH = 10)(
    input [DATA_WIDTH-1:0] Y_in, 
    input [2:0] PC, 
    input [((DATA_WIDTH+2)/3)-1:0] s_in,
	input [((DATA_WIDTH+2)/3)-1:0] t_in,
	input [((DATA_WIDTH+2)/3)-1:0] d_in,
	input [((DATA_WIDTH+2)/3)-1:0] q_in,
	input [((DATA_WIDTH+2)/3)-1:0] n_in,
    input clk, rst,
    output reg [DATA_WIDTH-1:0] Y_out,
    output reg [2:0] PC_out,
    output reg [((DATA_WIDTH+2)/3)-1:0] s_out,
	output reg [((DATA_WIDTH+2)/3)-1:0] t_out,
	output reg [((DATA_WIDTH+2)/3)-1:0] d_out,
	output reg [((DATA_WIDTH+2)/3)-1:0] q_out,
	output reg [((DATA_WIDTH+2)/3)-1:0] n_out,
    output reg [2*DATA_WIDTH-1:0] C_out
);
//	reg [2*DATA_WIDTH-1:0] multi_reg;
	wire [2*DATA_WIDTH-1:0] multi;
	
	wire [9:0] x3_Y_out;
	
	always @(posedge clk or negedge rst) begin
		if(!rst) begin
			C_out <= 0;
			s_out <= 0;
			t_out <= 0;
			d_out <= 0;
			q_out <= 0;
			n_out <= 0;
			Y_out <= 0;
			PC_out <= 0;
		end
		else begin
			C_out <= C_out + multi;
			s_out <= s_in;
			t_out <= t_in;
			d_out <= d_in;
			q_out <= q_in;
			n_out <= n_in;
			PC_out <= PC;
			Y_out <= Y_in;
		end
	end
	
//	always @(posedge clk or negedge rst) begin
//		if (!rst)
//			multi_reg <= 0;
//		else
//			multi_reg <= multi;
//	end
//	assign multi = a*b;


HCP_inside_PE_2222 inside_PE(

    .PC(PC),
    .Y({1'b0,Y_in}),
    .Y_3(x3_Y_out)


);




	radix8_booth_multiplier #(.N(DATA_WIDTH)) radix(
		.clk(clk),
		.rst(rst),
		.Y(Y_in), 
		.x3_Y(x3_Y_out), 
		.s_in(s_in),
		.t_in(t_in),
		.d_in(d_in),
		.q_in(q_in),
		.n_in(n_in),
		.Prod(multi) 
	);
endmodule
//module PE #(parameter DATA_WIDTH = 10)(
//    input [DATA_WIDTH-1:0] Y_in, 
//    input [DATA_WIDTH+1:0] x3_Y_in, 
//    input [((DATA_WIDTH+2)/3)-1:0] s_in,
//	input [((DATA_WIDTH+2)/3)-1:0] t_in,
//	input [((DATA_WIDTH+2)/3)-1:0] d_in,
//	input [((DATA_WIDTH+2)/3)-1:0] q_in,
//	input [((DATA_WIDTH+2)/3)-1:0] n_in,
//    input clk, rst,
//    output reg [DATA_WIDTH-1:0] Y_out,
//    output reg [DATA_WIDTH+1:0] x3_Y_out,
//    output reg [((DATA_WIDTH+2)/3)-1:0] s_out,
//	output reg [((DATA_WIDTH+2)/3)-1:0] t_out,
//	output reg [((DATA_WIDTH+2)/3)-1:0] d_out,
//	output reg [((DATA_WIDTH+2)/3)-1:0] q_out,
//	output reg [((DATA_WIDTH+2)/3)-1:0] n_out,
//    output reg [2*DATA_WIDTH-1:0] C_out
//);
//	wire [2*DATA_WIDTH-1:0] multi_reg;
//	reg [2*DATA_WIDTH-1:0] multi;
//	reg [DATA_WIDTH-1:0] out_reg;
//	reg [DATA_WIDTH+1:0] x3_out_reg;
	
//	always @(posedge clk or negedge rst) begin
//		if(!rst) begin
//			C_out <= 0;
//			s_out <= 0;
//			t_out <= 0;
//			d_out <= 0;
//			q_out <= 0;
//			n_out <= 0;
//			Y_out <= 0;
//			x3_Y_out <= 0;
//			x3_out_reg <= 0;
//			out_reg <= 0;
//		end
//		else begin
//			C_out <= C_out + multi;
//			s_out <= s_in;
//			t_out <= t_in;
//			d_out <= d_in;
//			q_out <= q_in;
//			n_out <= n_in;
//			x3_out_reg <= x3_Y_in;
//			out_reg <= Y_in;
//		end
//	end
	
//	always @(posedge clk or negedge rst) begin
//		if(rst) begin
//			x3_Y_out <= x3_out_reg;
//			Y_out <= out_reg;
//		end
//	end
////	assign multi = a*b;
//	radix8_booth_multiplier #(.N(DATA_WIDTH)) radix(
//		.Y_in(Y_in), 
//		.x3_Y_in(x3_Y_in), 
//		.s_in(s_in),
//		.t_in(t_in),
//		.d_in(d_in),
//		.q_in(q_in),
//		.n_in(n_in),
//		.Prod(multi_reg) 
//	);
//	always @(posedge clk or negedge rst) begin
//    if (!rst)
//        multi <= 0;
//    else
//        multi <= multi_reg;
//end
//endmodule



module HCP_inside_PE_2222(

    input [2:0] PC,
    input [8:0] Y,
    output [9:0] Y_3


);

    wire [8:0] Y_2;
    wire [8:0] sum;
    
    assign Y_2 = Y<<1;


    wire [3:0] carries;
    wire [2:0] carries_PC_0,carries_PC_1,carries_PC_2;
    
    assign carries[0] = 1'b0;
    assign carries[1] = 1'b0;

    assign sum[0] = Y[0];
    
    genvar i;
    generate
      for (i = 1; i < 3; i = i + 1) begin: cpa_loop1
        assign sum[i] = Y[i] ^ Y_2[i] ^ carries[i];
        assign carries[i+1] = (Y[i] & Y_2[i]) | (Y[i] & carries[i]) | (Y_2[i] & carries[i]);
      end
    endgenerate 
    
    
    assign carries_PC_0[0] = PC[0]; 
    
    generate
      for (i = 3; i < 5; i = i + 1) begin: cpa_loop2
        assign sum[i] = Y[i] ^ Y_2[i] ^ carries_PC_0[i-3];
        assign carries_PC_0[(i+1)-3] = (Y[i] & Y_2[i]) | (Y[i] & carries_PC_0[i-3]) | (Y_2[i] & carries_PC_0[i-3]);
      end
    endgenerate

    assign carries_PC_1[0] = PC[1]; 


    generate
      for (i = 5; i < 7; i = i + 1) begin: cpa_loop3
        assign sum[i] = Y[i] ^ Y_2[i] ^ carries_PC_1[i-5];
        assign carries_PC_1[(i+1)-5] = (Y[i] & Y_2[i]) | (Y[i] & carries_PC_1[i-5]) | (Y_2[i] & carries_PC_1[i-5]);
      end
    endgenerate

    assign carries_PC_2[0] = PC[2]; 

    generate
      for (i = 7; i < 9; i = i + 1) begin: cpa_loop4
        assign sum[i] = Y[i] ^ Y_2[i] ^ carries_PC_2[i-7];
        assign carries_PC_2[(i+1)-7] = (Y[i] & Y_2[i]) | (Y[i] & carries_PC_2[i-7]) | (Y_2[i] & carries_PC_2[i-7]);
      end
    endgenerate

    assign Y_3 = {carries_PC_2[2],sum}; 

endmodule


module HCP_2222(

    input [7:0] Y,
    output [2:0] PC


);

    wire [8:0] Y_2;

    
    assign Y_2 = Y<<1;

    wire [7:0] carries;
    
    assign carries[0] = 1'b0;
    genvar i;
    generate
      for (i = 0; i < 7; i = i + 1) begin: cpa_loop
        assign carries[i+1] = (Y[i] & Y_2[i]) | (Y[i] & carries[i]) | (Y_2[i] & carries[i]);
      end
    endgenerate 
    
    assign PC = {carries[7],carries[5],carries[3]};


endmodule


module HalfAdder 
  (
   A,
   B,
   sum,
   carry
   );
 
  input  A;
  input  B;
  output sum;
  output carry;
 
  assign sum   = A ^ B;  // bitwise xor
  assign carry = A & B;  // bitwise and
 
endmodule // half_adder


module FullAdder (input a, b, c, output sum, cout);
  wire w1, w2, w3;

  HalfAdder HA1 (a, b, w2, w1);
  HalfAdder HA2 (w2, c, sum, w3);
  assign cout = w1 | w3; 

endmodule

module radix8_booth_multiplier #(parameter N = 8) (
	input clk,
	input rst,
	input [N-1:0] Y, 
	input [N+1:0] x3_Y, 
    input [((N+2)/3)-1:0] s_in,
	input [((N+2)/3)-1:0] t_in,
	input [((N+2)/3)-1:0] d_in,
	input [((N+2)/3)-1:0] q_in,
	input [((N+2)/3)-1:0] n_in,
    output reg [2*N-1:0] Prod // Product
);

    localparam NUM_PARTIALS = (N + 2) / 3; // Compute ceil(N/3)
    
    reg [2*N:0] partial_products [NUM_PARTIALS-1:0]; // Array to store partial products
    reg [2*N+1:0] accum; // Final sum accumulation
    reg [N-1:0] Y_in;
    reg [N+1:0] x3_Y_in;
    wire [2*N-1:0] Product;
    // Booth encoding control signals
    wire [N-1:0] neg_Y;
    wire [N:0] x2_Y, x2_neg_Y;
    wire [N+1:0] x3_neg_Y, x4_Y, x4_neg_Y;

    always @(posedge clk or negedge rst) begin
    	if(!rst) begin
    		Y_in <= 0;
    		x3_Y_in <= 0;
    		Prod <= 0;
    	end
    	else begin
    		Y_in <= Y;
    		x3_Y_in <= x3_Y;
    		Prod <= Product;
    	end
    end
    // Compute 2's complement negation
    assign neg_Y = ~Y_in + 1'b1;  
    
    // Compute positive multiples
    assign x2_Y = {Y_in[N-1], Y_in} << 1;  // 2A
    assign x4_Y = {{2{Y_in[N-1]}}, Y_in} << 2;  // 4A

    // Compute negative multiples
    assign x2_neg_Y = (~{Y_in[N-1], Y_in} + 1'b1) << 1;  // -2A
    assign x3_neg_Y = ~x3_Y_in + 1'b1; // -3A
    assign x4_neg_Y = (~{{2{Y_in[N-1]}}, Y_in} + 1'b1) << 2;  // -4A

//	always @(posedge clk or negedge rst) begin
//		Prod <= accum[2*N-1:0];
//	end
	
	integer i;
	always @(*) begin
		for (i = 0; i < NUM_PARTIALS; i = i + 1) begin : booth_gen
			case ({s_in[i],d_in[i],t_in[i],q_in[i],n_in[i]})
				5'b11000, 5'b11001 : partial_products[i] = {2*N+1{1'b0}};
				5'b00110, 5'b01100 : partial_products[i] = {{(N+1){Y_in[N-1]}},Y_in};
				5'b10010, 5'b00100 : partial_products[i] = {{(N){x2_Y[N]}},x2_Y};
				5'b11010, 5'b10000 : partial_products[i] = {{(N-1){x3_Y_in[N+1]}},x3_Y_in};
				5'b01110          : partial_products[i] = {{(N-1){x4_Y[N+1]}},x4_Y};
				5'b01111          : partial_products[i] = {{(N-1){x4_neg_Y[N+1]}},x4_neg_Y};
				5'b10001, 5'b11011 : partial_products[i] = {{(N-1){x3_neg_Y[N+1]}},x3_neg_Y};
				5'b00101, 5'b10011 : partial_products[i] = {{(N){x2_neg_Y[N]}},x2_neg_Y};
				5'b00111, 5'b01101 : partial_products[i] = {{(N+1){neg_Y[N-1]}},neg_Y};
				default          : partial_products[i] = {2*N+1{1'b0}}; 
			endcase
		end
	end
	WallaceTreeMult mul(
	.clk(clk),
	.rst(rst),
    .P1_in(partial_products[0][15:0]),
    .P2_in(partial_products[1][12:0]),
    .P3_in(partial_products[2][9:0]),
    .Out(Product)
);
    // Assign final product
//    assign Prod = accum[2*N-1:0];

endmodule

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
//    wire [15:0] arg1 = {FA9_sum,FA8_sum,FA7_sum,FA6_sum,FA5_sum,FA4_sum,FA3_sum,FA2_sum,FA1_sum,HA1_sum,P1[5],P1[4],P1[3],P1[2],P1[1],P1[0]};
//    wire [15:0] arg2 = {FA8_carry,FA7_carry,FA6_carry,FA5_carry,FA4_carry,FA3_carry,FA2_carry,FA1_carry,HA1_carry,P3[0],P2[2],P2[1],P2[0],1'b0,1'b0,1'b0};
    
    assign carries[0] = 1'b0;
    genvar i;
    generate
      for (i = 0; i < 16; i = i + 1) begin: cpa_loop
        assign sum[i] = arg1[i] ^ arg2[i] ^ carries[i];
        assign carries[i+1] = (arg1[i] & arg2[i]) | (arg1[i] & carries[i]) | (arg2[i] & carries[i]);
      end
    endgenerate
    
endmodule


