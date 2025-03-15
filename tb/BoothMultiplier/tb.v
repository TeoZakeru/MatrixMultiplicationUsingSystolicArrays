`timescale 1ns / 1ps

module tb;

    // Parameters
    parameter N = 9;  // Change this for different bit-widths

    // Testbench Signals
    reg signed [N-1:0] A, B;  // Inputs (Multiplicand and Multiplier)
    wire signed [2*N-1:0] P;  // Output (Product)
    reg clk, reset;
    integer i, j;
    // Instantiate the Radix-8 Booth Multiplier
    radix8_booth_multiplier #(N) uut (
        .clk(clk),
        .reset(reset),
        .a(A),
        .b(B),
        .Prod(P)
    );
    
    // Clock Generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Test Cases
    initial begin
//        $monitor("Time = %0t | A = %d | B = %d | P = %d", $time, A, B, P);
        
        // Exhaustive Testing for all values of A and B
        for (i = -(2**(N-4)); i < ((2**(N-4))); i = i + 1) begin
            for (j = -(2**(N-4)); j < ((2**(N-4))); j = j + 1) begin
                A <= i;
                B <= j;
                reset <= 1; 
                #10;
                reset <= 0;
                #40;  // Delay to observe output
                $display(" A = %d, B = %d, P = %d", A, B, P);                                
            end
        end

        // End Simulation
        $finish;
    end

endmodule
