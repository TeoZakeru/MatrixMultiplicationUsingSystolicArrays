module SA #(parameter SIZE = 2, parameter DATA_WIDTH = 8)(
	input [SIZE*SIZE*DATA_WIDTH-1:0] A,
	input [SIZE*SIZE*DATA_WIDTH-1:0] B,
	input clk,
	input rst,
	output [SIZE*SIZE*DATA_WIDTH-1:0] C,
	output reg done 
);
reg [DATA_WIDTH-1:0] A_2D[SIZE-1:0][2*SIZE+1:0];
reg [DATA_WIDTH-1:0] B_2D[SIZE-1:0][2*SIZE+1:0];
reg [SIZE:0] count;
reg [DATA_WIDTH-1:0] a [SIZE-1:0];
reg [DATA_WIDTH-1:0] b [SIZE-1:0];
wire [DATA_WIDTH-1:0] c [SIZE-1:0][SIZE-1:0];
wire [DATA_WIDTH-1:0] d [SIZE-1:0][SIZE-1:0];
wire [DATA_WIDTH-1:0] C_out [SIZE-1:0][SIZE-1:0];
reg [SIZE:0] i,j;
integer r,col,index;

always @(*) begin
        for (index = 0; index < SIZE * (2*SIZE+2); index = index + 1) begin
            r = index / (2*SIZE+2);
            col = index % (2*SIZE+2);

            A_2D[r][col] = 0;
            B_2D[r][col] = 0;

            if (col >= r && col < r + SIZE) begin
                A_2D[r][col] = A[(r * SIZE + (col - r)) * DATA_WIDTH +: DATA_WIDTH];
                B_2D[r][col] = B[((col - r) * SIZE + r) * DATA_WIDTH +: DATA_WIDTH];
            end
        end
    end

genvar row,column;
generate
		for (row = 0; row < SIZE; row=row+1) begin:row_block
			for (column = 0; column < SIZE; column=column+1) begin:col_block
				if (row == 0 && column == 0) begin
					PE p(.a(a[0]),.b(b[0]),.clk(clk),.rst(rst),.done(done),.c(c[0][0]),.d(d[0][0]),.C_out(C_out[0][0]));
					end
				else if (row == 0) begin
					PE p(.a(c[0][column-1]),.b(b[column]),.clk(clk),.rst(rst),.done(done),.c(c[0][column]),.d(d[0][column]),.C_out(C_out[0][column]));
					end
				else if (column == 0) begin
					PE p(.a(a[row]),.b(d[row-1][0]),.clk(clk),.rst(rst),.done(done),.c(c[row][0]),.d(d[row][0]),.C_out(C_out[row][0]));
					end
				else begin
					PE p(.a(c[row][column-1]),.b(d[row-1][column]),.clk(clk),.rst(rst),.done(done),.c(c[row][column]),.d(d[row][column]),.C_out(C_out[row][column]));
					end
			end
		end
	endgenerate

always @(*) begin
        for (r = 0; r < SIZE; r = r + 1) begin
            a[r] = A_2D[r][count];
            b[r] = B_2D[r][count];
        end
    end

always @(posedge clk or posedge rst) begin
		if(rst) begin
			done <= 0;
			count <= 0;
		end
		else begin
			if(count == (2*SIZE+1)) begin
				done <= 1;
				count <= 0;
			end
			else begin
				done <= 0;
				count <= count + 1;
//				a <= 
			end
		end	
	end
endmodule
