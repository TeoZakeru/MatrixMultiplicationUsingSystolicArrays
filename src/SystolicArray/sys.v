module SystolicArray #(parameter SIZE = 3, parameter DATA_WIDTH = 10)(
    input [SIZE*DATA_WIDTH-1:0] A,
    input [SIZE*DATA_WIDTH-1:0] B,
    input clk,
    input rst,
    output reg done,
    output wire [SIZE*SIZE*2*DATA_WIDTH-1:0] C
);

reg [(SIZE*SIZE)*DATA_WIDTH-1:0] c;
reg [(SIZE*SIZE)*DATA_WIDTH-1:0] d;
reg [(SIZE*SIZE)*2*DATA_WIDTH-1:0] C_out;

reg [7:0] count;  // Register for counting cycles

//PE #(.DATA_WIDTH(DATA_WIDTH)) p00(.a(A[0 +: DATA_WIDTH]), .b(B[0 +: DATA_WIDTH]), .clk(clk), .rst(rst), .c(c[0 +: DATA_WIDTH]), .d(d[0 +: DATA_WIDTH]), .C_out(C_out[0 +: (2 * DATA_WIDTH)]));
//PE #(.DATA_WIDTH(DATA_WIDTH)) p01(.a(c[(0*SIZE+0)*DATA_WIDTH +: DATA_WIDTH]), .b(B[1*DATA_WIDTH +: DATA_WIDTH]), .clk(clk), .rst(rst), .c(c[(0*SIZE+1)*DATA_WIDTH +: DATA_WIDTH]), .d(d[(0*SIZE+1)*DATA_WIDTH +: DATA_WIDTH]), .C_out(C_out[(0 * SIZE + 1) * (2 * DATA_WIDTH) +: (2 * DATA_WIDTH)]));
//PE #(.DATA_WIDTH(DATA_WIDTH)) p10(.a(A[1*DATA_WIDTH +: DATA_WIDTH]), .b(d[(0*SIZE+0)*DATA_WIDTH +: DATA_WIDTH]), .clk(clk), .rst(rst), .c(c[(1*SIZE+0)*DATA_WIDTH +: DATA_WIDTH]), .d(d[(1*SIZE+0)*DATA_WIDTH +: DATA_WIDTH]), .C_out(C_out[(1 * SIZE + 0) * (2 * DATA_WIDTH) +: (2 * DATA_WIDTH)]));
//PE #(.DATA_WIDTH(DATA_WIDTH)) p11(.a(c[(1*SIZE+0)*DATA_WIDTH +: DATA_WIDTH]), .b(d[(0*SIZE+1)*DATA_WIDTH +: DATA_WIDTH]), .clk(clk), .rst(rst), .c(c[(1*SIZE+1)*DATA_WIDTH +: DATA_WIDTH]), .d(d[(1*SIZE+1)*DATA_WIDTH +: DATA_WIDTH]), .C_out(C_out[(1 * SIZE + 1) * (2 * DATA_WIDTH) +: (2 * DATA_WIDTH)]));

genvar i,j;
generate
	for(i = 0;i <SIZE;i = i+1) begin
		for(j = 0; j< SIZE; j = j+1) begin
			if(i == 0 && j == 0) begin
				PE #(
				.DATA_WIDTH(DATA_WIDTH)
				) p(
				.a(A[0 +: DATA_WIDTH]),
				.b(B[0 +: DATA_WIDTH]),
				.c(c[0 +: DATA_WIDTH]),
				.d(d[0 +: DATA_WIDTH]),
				.clk(clk),
				.rst(rst),
				.C_out(C_out[0 +: (2*DATA_WIDTH)])
				);
			end
			else if(i == 0) begin
				PE #(
				.DATA_WIDTH(DATA_WIDTH)
				) p(
				.a(c[(i*SIZE+(j-1))*DATA_WIDTH +: DATA_WIDTH]),
				.b(B[j*DATA_WIDTH +: DATA_WIDTH]),
				.c(c[(i*SIZE+j)*DATA_WIDTH +: DATA_WIDTH]),
				.d(d[(i*SIZE+j)*DATA_WIDTH +: DATA_WIDTH]),
				.clk(clk),
				.rst(rst),
				.C_out(C_out[(i*SIZE+j)*2*DATA_WIDTH +: (2*DATA_WIDTH)])
				);
			end
			else if(j == 0) begin
				PE #(
				.DATA_WIDTH(DATA_WIDTH)
				) p(
				.a(A[i*DATA_WIDTH +: DATA_WIDTH]),
				.b(d[((i-1)*SIZE+j)*DATA_WIDTH +: DATA_WIDTH]),
				.c(c[(i*SIZE+j)*DATA_WIDTH +: DATA_WIDTH]),
				.d(d[(i*SIZE+j)*DATA_WIDTH +: DATA_WIDTH]),
				.clk(clk),
				.rst(rst),
				.C_out(C_out[(i*SIZE+j)*2*DATA_WIDTH +: (2*DATA_WIDTH)])
				);
			end
			else begin
				PE #(
				.DATA_WIDTH(DATA_WIDTH)
				) p(
				.a(c[(i*SIZE+(j-1))*DATA_WIDTH +: DATA_WIDTH]),
				.b(d[((i-1)*SIZE+j)*DATA_WIDTH +: DATA_WIDTH]),
				.c(c[(i*SIZE+j)*DATA_WIDTH +: DATA_WIDTH]),
				.d(d[(i*SIZE+j)*DATA_WIDTH +: DATA_WIDTH]),
				.clk(clk),
				.rst(rst),
				.C_out(C_out[(i*SIZE+j)*2*DATA_WIDTH +: (2*DATA_WIDTH)])
				);
			end
		end
	end
endgenerate

assign C = C_out;
// Cycle counter for computation completion
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        done <= 0;
        count <= 0;
//        c <= 'd0;
//        d <= 'd0;
    end else begin
        if (count == (2*SIZE+1)) begin
            done <= 1;
//            count <= 0;
        end else begin
            done <= 0;
            count <= count + 1;
        end
    end
end

endmodule
