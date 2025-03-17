module SystolicArray #(parameter SIZE = 2, parameter DATA_WIDTH = 8)(
    input [SIZE*DATA_WIDTH-1:0] A,
    input [SIZE*DATA_WIDTH-1:0] B,
    input clk,
    input rst,
    output reg done,
    output wire [SIZE*SIZE*2*DATA_WIDTH-1:0] C_out
);

reg [(SIZE*SIZE)*DATA_WIDTH-1:0] c;
reg [(SIZE*SIZE)*DATA_WIDTH-1:0] d;
//reg [(SIZE*SIZE)*2*DATA_WIDTH-1:0] C_out;
reg [DATA_WIDTH-1:0] A_array [SIZE-1:0];
reg [DATA_WIDTH-1:0] B_array [SIZE-1:0];
reg [DATA_WIDTH+1:0] x3_Y_in [SIZE-1:0];
wire [DATA_WIDTH+1:0] Y_out [SIZE-1:0][SIZE-1:0];
wire [DATA_WIDTH+1:0] x3_Y_out [SIZE-1:0][SIZE-1:0];
reg [7:0] count;  // Register for counting cycles


wire [((DATA_WIDTH+2)/3)-1:0] s_in[SIZE-1:0];
wire [((DATA_WIDTH+2)/3)-1:0] t_in[SIZE-1:0];
wire [((DATA_WIDTH+2)/3)-1:0] d_in[SIZE-1:0];
wire [((DATA_WIDTH+2)/3)-1:0] q_in[SIZE-1:0];
wire [((DATA_WIDTH+2)/3)-1:0] n_in[SIZE-1:0];

wire [((DATA_WIDTH+2)/3)-1:0] s_out[SIZE-1:0][SIZE-1:0];
wire [((DATA_WIDTH+2)/3)-1:0] t_out[SIZE-1:0][SIZE-1:0];
wire [((DATA_WIDTH+2)/3)-1:0] d_out[SIZE-1:0][SIZE-1:0];
wire [((DATA_WIDTH+2)/3)-1:0] q_out[SIZE-1:0][SIZE-1:0];
wire [((DATA_WIDTH+2)/3)-1:0] n_out[SIZE-1:0][SIZE-1:0];

integer m;
always @(*) begin
	for (m = 0; m < SIZE; m = m + 1) begin
		A_array[m] = (A[m*DATA_WIDTH + DATA_WIDTH - 1] & B[m*DATA_WIDTH + DATA_WIDTH - 1])?~A[m*DATA_WIDTH +: DATA_WIDTH]+1'b1:((A[m*DATA_WIDTH + DATA_WIDTH - 1])?B[m*DATA_WIDTH +: DATA_WIDTH]:A[m*DATA_WIDTH +: DATA_WIDTH]);
		B_array[m] = (A[m*DATA_WIDTH + DATA_WIDTH - 1] & B[m*DATA_WIDTH + DATA_WIDTH - 1])?~B[m*DATA_WIDTH +: DATA_WIDTH]+1'b1:((A[m*DATA_WIDTH + DATA_WIDTH - 1])?A[m*DATA_WIDTH +: DATA_WIDTH]:B[m*DATA_WIDTH +: DATA_WIDTH]);
		x3_Y_in[m] = ({{2{B_array[m][DATA_WIDTH-1]}}, B_array[m]} << 1) + {{2{B_array[m][DATA_WIDTH-1]}}, B_array[m]};
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
//				.clk(clk),
//				.rst(rst),
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
				.x3_Y_in(x3_Y_in[0]), 
				.s_in(s_in[0]),
				.t_in(t_in[0]),
				.d_in(d_in[0]),
				.q_in(q_in[0]),
				.n_in(n_in[0]),
				.clk(clk), 
				.rst(rst),
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
//				.clk(clk),
//				.rst(rst),
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
				.x3_Y_in(x3_Y_out[i-1][0]), 
				.s_in(s_in[i]),
				.t_in(t_in[i]),
				.d_in(d_in[i]),
				.q_in(q_in[i]),
				.n_in(n_in[i]),
				.clk(clk), 
				.rst(rst),
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
				.DATA_WIDTH(DATA_WIDTH)
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
				.DATA_WIDTH(DATA_WIDTH)
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