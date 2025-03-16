`timescale 1ns / 1ps

module SA_tb;

    parameter SIZE = 3;
    parameter DATA_WIDTH = 10;

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
//        A = {8'd0, 8'd1};
//        B = {8'd0, 8'd4};
//        #10;
//        A = {8'd3, 8'd2};
//        B = {8'd3, 8'd2};
//        #10;
//        A = {8'd4, 8'd0};
//        B = {8'd1, 8'd0};
//        #10;
//        A = {8'd0, 8'd0};
//        B = {8'd0, 8'd0};
//        #10;
//        A = {8'd0, 8'd0};
//        B = {8'd0, 8'd0};
//        #10;
//        A = {8'd0, 8'd0};
//        B = {8'd0, 8'd0};
//        #10;
//        A = {8'd0, 8'd0};
//        B = {8'd0, 8'd0};
//        #10;
//        A = {8'd0, 8'd0};
//        B = {8'd0, 8'd0};
		A = {10'd0,10'd0,10'd4};
		B = {10'd0,10'd0,10'd6};
		#10;
		A = {10'd0,10'd16,10'd5};
		B = {10'd0,10'd12,10'd19};
		#10;
		A = {10'd2,10'd5,10'd7};
		B = {10'd2,10'd7,10'd18};
		#10;
		A = {10'd8,10'd15,10'd0};
		B = {10'd16,10'd2,10'd0};
		#10;
		A = {10'd4,10'd0,10'd0};
		B = {10'd18,10'd0,10'd0};
		#10;
		A = {10'd0,10'd0,10'd0};
		B = {10'd0,10'd0,10'd0};
		#10;
		A = {10'd0,10'd0,10'd0};
		B = {10'd0,10'd0,10'd0};
		#10;A = {10'd0,10'd0,10'd0};
		B = {10'd0,10'd0,10'd0};
		#10;
		A = {10'd0,10'd0,10'd0};
		B = {10'd0,10'd0,10'd0};
		#10;A = {10'd0,10'd0,10'd0};
		B = {10'd0,10'd0,10'd0};
		#10;
		A = {10'd0,10'd0,10'd0};
		B = {10'd0,10'd0,10'd0};
		#10;
		
        // Wait for computation to complete
        wait(done);

        // Print output matrix
//        #1000;
        #10;        
        // End simulation
        $stop;
    end
endmodule

