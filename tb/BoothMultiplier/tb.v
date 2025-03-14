`timescale 1ns / 1ps

module tb_radix8_booth_multiplier();

    // Parameters
    parameter N = 6;  // Change this for different bit-widths

    // Testbench Signals
    reg signed [N-1:0] A, B;  // Inputs (Multiplicand and Multiplier)
    wire signed [2*N-1:0] P;  // Output (Product)
    reg clk, reset;
    // Instantiate the Radix-8 Booth Multiplier
    radix8_booth_multiplier #(N) uut (
        .clk(clk),
        .reset(reset),
        .A(A),
        .B(B),
        .P(P)
    );
    initial clk = 0;
    always #5 clk = ~clk;
    // Test Cases
    initial begin
        $monitor("Time = %0t | A = %d | B = %d | P = %d", $time, A, B, P);
        
        #5;
        reset = 1;
        A = -6'd13; B = 6'd25; #10;
        #10;
        reset = 0;
        #100;
        reset = 1;
        A = -6'd10; B = 6'd25; #10;
        #10;
        reset = 0;
        #10;
        // Test Case 1: Positive x Positive
        
        // Test Case 2: Positive x Negative
//        A = 8'd15; B = -8'd7; #10;

//        // Test Case 3: Negative x Positive
//        A = -8'd12; B = 8'd8; #10;

//        // Test Case 4: Negative x Negative
//        A = -8'd9; B = -8'd11; #10;

//        // Test Case 5: Zero x Any Number
//        A = 8'd0; B = 8'd45; #10;
//        A = 8'd50; B = 8'd0; #10;

        // Test Case 6: Multiplication of Max and Min Values
//        A = 8'sd127; B = 8'sd1; #10;  // Maximum positive value
//        A = -8'sd128; B = 8'sd1; #10; // Minimum negative value

        // End Simulation
        $finish;
    end

endmodule