`timescale 1ns / 1ps

module SA_tb;

    parameter SIZE = 2;
    parameter DATA_WIDTH = 8;

    // Inputs
    reg clk;
    reg rst;
    reg [SIZE*DATA_WIDTH-1:0] A;
    reg [SIZE*DATA_WIDTH-1:0] B;
    wire [SIZE*SIZE*2*DATA_WIDTH-1:0] C;
    // Outputs
    wire done;
    // Instantiate the SA module
    SystolicArray #(.SIZE(SIZE), .DATA_WIDTH(DATA_WIDTH)) uut (
        .A(A),
        .B(B),
        .clk(clk),
        .rst(rst),
        .done(done),
        .C(C)
    );

    // Clock generation (50% duty cycle, period = 10ns)
    always #5 clk = ~clk;

    // Task to print the output matrix

    // Test procedure
    initial begin
		clk = 0;
        // Initialize clock and reset
        rst = 0;
		#100;
        #10 rst = 1; // Release reset after 10ns
        // Initialize input matrices A and B (row-major order)
        A = {8'd0, 8'd1};
        B = {8'd0, 8'd4};
        #10;
        A = {8'd3, 8'd2};
        B = {8'd3, 8'd2};
        #10;
        A = {8'd4, 8'd0};
        B = {8'd1, 8'd0};
        #10;
        A = {8'd0, 8'd0};
        B = {8'd0, 8'd0};
        #10;
        A = {8'd0, 8'd0};
        B = {8'd0, 8'd0};
        #10;
        A = {8'd0, 8'd0};
        B = {8'd0, 8'd0};
        #10;
        A = {8'd0, 8'd0};
        B = {8'd0, 8'd0};
        #10;
        A = {8'd0, 8'd0};
        B = {8'd0, 8'd0};
//		A = {9'd0,9'd0,9'd4};
//		B = {9'd0,9'd0,9'd6};
//		#10;
//		A = {9'd0,9'd16,9'd5};
//		B = {9'd0,9'd12,9'd19};
//		#10;
//		A = {9'd2,9'd5,9'd7};
//		B = {9'd2,9'd7,9'd18};
//		#10;
//		A = {9'd8,9'd15,9'd0};
//		B = {9'd16,9'd2,9'd0};
//		#10;
//		A = {9'd4,9'd0,9'd0};
//		B = {9'd18,9'd0,9'd0};
//		#10;
//		A = {9'd0,9'd0,9'd0};
//		B = {9'd0,9'd0,9'd0};
//		#10;
//		A = {9'd0,9'd0,9'd0};
//		B = {9'd0,9'd0,9'd0};
//		#10;A = {9'd0,9'd0,9'd0};
//		B = {9'd0,9'd0,9'd0};
//		#10;
//		A = {9'd0,9'd0,9'd0};
//		B = {9'd0,9'd0,9'd0};
//		#10;A = {9'd0,9'd0,9'd0};
//		B = {9'd0,9'd0,9'd0};
//		#10;
//		A = {9'd0,9'd0,9'd0};
//		B = {9'd0,9'd0,9'd0};
//		#10;
		
        // Wait for computation to complete
        wait(done);

        // Print output matrix
//        #1000;
        #10;        
        // End simulation
        $stop;
    end
endmodule
