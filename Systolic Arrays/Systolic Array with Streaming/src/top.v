module SystolicArray #(parameter SIZE = 8, parameter DATA_WIDTH = 8)(
    input [SIZE*DATA_WIDTH-1:0] A,
    input [SIZE*DATA_WIDTH-1:0] B,
    input clk,
    input rst,
    input start,
    output reg done,
    output reg [SIZE*SIZE*2*DATA_WIDTH-1:0] C
);

reg start_reg;

wire [(SIZE*SIZE)*DATA_WIDTH-1:0] c;
wire [(SIZE*SIZE)*DATA_WIDTH-1:0] d;
wire [(SIZE*SIZE)*2*DATA_WIDTH-1:0] C_out;
wire [DATA_WIDTH-1:0] A_array [0 : SIZE-1];
wire [DATA_WIDTH-1:0] B_array [0 : SIZE-1];
wire [DATA_WIDTH+1:0] x3_Y_in [0 : SIZE-1];
wire [DATA_WIDTH-1:0] Y_out [0 : SIZE-1][0 : SIZE-1];
wire [DATA_WIDTH+1:0] x3_Y_out [0 : SIZE-1][0 : SIZE-1];
reg [7:0] count;  // Register for counting cycles
reg [SIZE*DATA_WIDTH - 1:0] A_reg, B_reg;
wire [SIZE*DATA_WIDTH-1 : 0] A_wire, B_wire;

//wire [((DATA_WIDTH+2)/3)-1:0] start_in[0 : SIZE-1];
wire start_out_east[0 : SIZE-1][0 : SIZE-1];
wire start_out_south[0 : SIZE-1][0 : SIZE-1];

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

genvar m;
//always @(*) begin
generate
	for (m = 0; m < SIZE; m = m + 1) begin
		assign A_array[m] = (A_reg[m*DATA_WIDTH + DATA_WIDTH - 1] & B_reg[m*DATA_WIDTH + DATA_WIDTH - 1])?~A_reg[m*DATA_WIDTH +: DATA_WIDTH]+1'b1:((A_reg[m*DATA_WIDTH + DATA_WIDTH - 1])?B_reg[m*DATA_WIDTH +: DATA_WIDTH]:A_reg[m*DATA_WIDTH +: DATA_WIDTH]);
		assign B_array[m] = (A_reg[m*DATA_WIDTH + DATA_WIDTH - 1] & B_reg[m*DATA_WIDTH + DATA_WIDTH - 1])?~B_reg[m*DATA_WIDTH +: DATA_WIDTH]+1'b1:((A_reg[m*DATA_WIDTH + DATA_WIDTH - 1])?A_reg[m*DATA_WIDTH +: DATA_WIDTH]:B_reg[m*DATA_WIDTH +: DATA_WIDTH]);
		wire signed [DATA_WIDTH+1:0] x3_val;

        RCA #(DATA_WIDTH) rca_inst (
            .Y(B_array[m]),
            .x3_Y(x3_val)
        );

        assign x3_Y_in[m] = x3_val;
	end
endgenerate

always @(posedge clk or negedge rst) begin
	if(!rst) begin
		A_reg <= 0;
		B_reg <= 0;
		C <= 0;
		start_reg <= 0;
	end
	else begin
		A_reg <= A;
		B_reg <= B;
		start_reg <= start;
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
				.DATA_WIDTH(DATA_WIDTH),
				.SIZE(SIZE)
				) pe(
				.Y_in(B_array[0]), 
				.x3_Y_in(x3_Y_in[0]), 
				.s_in(s_in[0]),
				.t_in(t_in[0]),
				.d_in(d_in[0]),
				.q_in(q_in[0]),
				.n_in(n_in[0]),
				.clk(clk), 
				.rst(rst),
				.start_in(start_reg),
				.start_out_east(start_out_east[0][0]),
				.start_out_south(start_out_south[0][0]),
				.Y_out(Y_out[0][0]),
				.x3_Y_out(x3_Y_out[0][0]),
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
				.DATA_WIDTH(DATA_WIDTH),
				.SIZE(SIZE)
				) pe(
				.Y_in(Y_out[i-1][0]), 
				.x3_Y_in(x3_Y_out[i-1][0]), 
				.s_in(s_in[i]),
				.t_in(t_in[i]),
				.d_in(d_in[i]),
				.q_in(q_in[i]),
				.n_in(n_in[i]),
				.clk(clk), 
				.rst(rst),
				.start_in(start_out_south[i-1][0]),
				.start_out_east(start_out_east[i][0]),
				.start_out_south(start_out_south[i][0]),
				.Y_out(Y_out[i][0]),
				.x3_Y_out(x3_Y_out[i][0]),
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
				.DATA_WIDTH(DATA_WIDTH),
				.SIZE(SIZE)
				) pe(
				.Y_in(B_array[j]), 
				.x3_Y_in(x3_Y_in[j]), 
				.s_in(s_out[0][j-1]),
				.t_in(t_out[0][j-1]),
				.d_in(d_out[0][j-1]),
				.q_in(q_out[0][j-1]),
				.n_in(n_out[0][j-1]),
				.clk(clk), 
				.rst(rst),
				.start_in(start_out_south[0][j-1]),
				.start_out_east(start_out_east[0][j]),
				.start_out_south(start_out_south[0][j]),
				.Y_out(Y_out[0][j]),
				.x3_Y_out(x3_Y_out[0][j]),
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
				.DATA_WIDTH(DATA_WIDTH),
				.SIZE(SIZE)
				) pe(
				.Y_in(Y_out[i-1][j]), 
				.x3_Y_in(x3_Y_out[i-1][j]), 
				.s_in(s_out[i][j-1]),
				.t_in(t_out[i][j-1]),
				.d_in(d_out[i][j-1]),
				.q_in(q_out[i][j-1]),
				.n_in(n_out[i][j-1]),
				.clk(clk), 
				.rst(rst),
				.start_in(start_out_south[i-1][j] & start_out_east[i][j-1]),
				.start_out_east(start_out_east[i][j]),
				.start_out_south(start_out_south[i][j]),
				.Y_out(Y_out[i][j]),
				.x3_Y_out(x3_Y_out[i][j]),
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
