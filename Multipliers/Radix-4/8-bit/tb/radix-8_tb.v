`timescale 1ns / 1ps

module tb_radix4_booth_multiplier;

    parameter N = 8;

    // Inputs
    reg signed [N-1:0] a;
    reg signed [N-1:0] b;
    reg clk;
    reg rst;

    // Output
    wire signed [2*N-1:0] Prod;

    // Instantiate the multiplier
    radix4_booth_multiplier #(N) uut (
        .a(a),
        .b(b),
        .clk(clk),
        .rst(rst),
        .Prod(Prod)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns period
    end

    // Test procedure
    initial begin
    	#100;
        $display("Time\t a\t b\t | Product");
        $monitor("%4t\t %0d\t %0d\t | %0d", $time, a, b, Prod);

        // Initial values
        
        rst = 0;
         #15;
       // Test 1: Positive × Positive
        a = 8'd0;
        b = 8'd0;
        rst = 1;
        #10;

        // Test 2: Negative × Positive
        a = -8'd6;
        b = 8'd4;
        #10;

//        // Test 3: Positive × Negative
        a = 8'd7;
        b = -8'd2;
        #10;

        // Test 4: Negative × Negative
        a = -8'd5;
        b = -8'd3;
        #10;

        // Test 5: Multiply by zero
        a = 8'd0;
        b = 8'd15;
        #10;

        // Test 6: Zero × Zero
        a = 8'd0;
        b = 8'd0;
        #10;

        // Test 7: Large numbers
        a = 8'd127;  // max positive
        b = 8'd127;
        #10;

        a = -8'd126; // min negative
        b = -8'd1;
        #10;

    end
endmodule
