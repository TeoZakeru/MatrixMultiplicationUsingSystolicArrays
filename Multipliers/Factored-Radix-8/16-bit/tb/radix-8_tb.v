`timescale 1ns/1ps

module tb_radix8_booth_multiplier;

    parameter N = 16;
    localparam NUM_PARTIALS = (N + 2) / 3;

    // Inputs
    reg signed [N-1:0] X, Y_in;
    reg signed  [N+1:0] x3_Y_in;
    wire signed [NUM_PARTIALS-1:0] s_in;
    wire signed [NUM_PARTIALS-1:0] t_in;
    wire signed [NUM_PARTIALS-1:0] d_in;
    wire signed [NUM_PARTIALS-1:0] q_in;
    wire signed [NUM_PARTIALS-1:0] n_in;
	reg clk,rst;
    // Output
    wire signed [2*N-1:0] Prod;

    // Instantiate the Unit Under Test (UUT)
    radix8_booth_multiplier #(N) uut (
        .Y(Y_in),
        .x3_Y(x3_Y_in),
        .s_in(s_in),
        .t_in(t_in),
        .d_in(d_in),
        .q_in(q_in),
        .n_in(n_in),
        .Prod(Prod),
        .clk(clk),
        .rst(rst)
    );
    
    boothRecoding #(.DATA_WIDTH(N)) dut(
    .X(X),
	.s(s_in),
	.t(t_in),
	.d(d_in),
	.q(q_in),
	.n(n_in),
	.clk(clk),
	.rst(rst)
);
	always #5 clk = ~clk;
    initial begin
    #150;
        $display("Starting Radix-8 Booth Multiplier Testbench...");
        $monitor("%4t\t %0d\t %0d\t | %0d", $time, X, Y_in, Prod);
		clk = 0;
		rst = 0;
        // Initialize Inputs
        #10;
        rst = 1;
//        #5;
        X 		 = 16'd7;
        Y_in     = 16'd13;       // Multiplicand
        x3_Y_in  = 18'd39;      // 3 × Multiplicand
        

        #10;
        X 		 = 16'd4;
        Y_in     = -16'd7;
        x3_Y_in  = -18'd21;
        #10;
        X 		 = 16'd7;
        Y_in     = 16'd11;
        x3_Y_in  = 18'd33;
        #10;
        X 		 = 16'd7;
        Y_in     = 16'd1;
        x3_Y_in  = 18'd3;
        #10;
        X 		 = 16'd3;
        Y_in     = 16'd1;
        x3_Y_in  = 18'd3;
        #10;
        X 		 = 16'd7;
        Y_in     = 16'd10;
        x3_Y_in  = 18'd30;
        #10;
    end

endmodule

