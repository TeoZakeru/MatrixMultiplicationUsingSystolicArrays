`timescale 1ns / 1ps

module tb_radix8_booth_multiplier;

    parameter N = 32;

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
        a = 32'd0;
        b = 32'd0;
        rst = 1;
        #10;

        // Test 2: Negative × Positive
        a = -32'd6;
        b = 32'd4;
        #10;

//        // Test 3: Positive × Negative
        a = 32'd7;
        b = -32'd2;
        #10;

        // Test 4: Negative × Negative
        a = -32'd5;
        b = -32'd3;
        #10;

        // Test 5: Multiply by zero
        a = 32'd0;
        b = 32'd15;
        #10;

        // Test 6: Zero × Zero
        a = 32'd0;
        b = 32'd0;
        #10;

        // Test 7: Large numbers
        a = 32'd127;  // max positive
        b = 32'd127;
        #10;

        a = -32'd126; // min negative
        b = -32'd1;
        #10;

    end
endmodule


//`timescale 1ns / 1ps

//module WallaceTreeMult_tb;

//    // Inputs
//    reg clk;
//    reg rst;
//    reg [15:0] P1_in;
//    reg [13:0] P2_in;
//    reg [11:0] P3_in;
//    reg [9:0] P4_in;
    
//    // Output
//    wire [15:0] Out;
    
//    WallaceTreeMult uut (
//        .clk(clk),
//        .rst(rst),
//        .P1_in(P1_in),
//        .P2_in(P2_in),
//        .P3_in(P3_in),
//        .P4_in(P4_in),
//        .Out(Out)
//    );
    
//    // Clock generation
//    initial begin
//        clk = 0;
//        forever #5 clk = ~clk; // 10ns period (100 MHz)
//    end
    
//    // Test vectors
//    initial begin
//        // Initialize inputs
//        #150;
//        rst = 0;
//        P1_in = 0;
//        P2_in = 0;
//        P3_in = 0;
//        P4_in = 0;
        
//        // Wait for global reset
//        #15;
//        rst = 1;
////        #10;
        
//        // Test case 1: All inputs are 1
//        P1_in = 16'd0;
//        P2_in = -14'd6;
//        P3_in = 12'd0;
//        P4_in = 10'd0;
//        #10;
        
//        // Test case 2: Different values
//        P1_in = 16'd2;
//        P2_in = -14'd4;
//        P3_in = 12'd0;
//        P4_in = 10'd0;
//        #10;
        
////        // Test case 3: Maximum values
//        P1_in = -16'd5;
//        P2_in = 14'd5;
//        P3_in = 12'd0;
//        P4_in = 10'd0;
//        #10;
        
//        // Test case 4: Zero values
//        P1_in = -16'd127;
//        P2_in = 14'd0;
//        P3_in = 12'd0;
//        P4_in = 10'd254;
//        #10;
     
////         Test case 5: Mixed values
//        P1_in = 16'd0;
//        P2_in = 14'd0;
//        P3_in = 12'd0;
//        P4_in = 10'd0;
//        #10;
//        $finish;
//    end

//    // Monitor changes
//    initial begin
//        $monitor("Time=%0t: rst=%b, P1=%d, P2=%d, P3=%d, P4=%d, Out=%d", 
//                 $time, rst, P1_in, P2_in, P3_in, P4_in, Out);
//    end

//endmodule

