`timescale 1ns / 1ps

module SA_tb;

    parameter SIZE = 2;
    parameter DATA_WIDTH = 8;

    // Inputs
    reg clk;
    reg rst;
    reg [SIZE*SIZE*DATA_WIDTH-1:0] A;
    reg [SIZE*SIZE*DATA_WIDTH-1:0] B;

    // Outputs
    wire [SIZE*SIZE*DATA_WIDTH-1:0] C;
    wire done;

    // Instantiate the SA module
    SA #(.SIZE(SIZE), .DATA_WIDTH(DATA_WIDTH)) uut (
        .A(A),
        .B(B),
        .clk(clk),
        .rst(rst),
        .C(C),
        .done(done)
    );

    // Clock generation (50% duty cycle, period = 10ns)
    always #5 clk = ~clk;

    // Task to print the output matrix
    task print_matrix;
        integer r, c;
        reg [DATA_WIDTH-1:0] C_2D [0:SIZE-1][0:SIZE-1];
        
        begin
            // Unpack packed C into C_2D
            for (r = 0; r < SIZE; r = r + 1)
                for (c = 0; c < SIZE; c = c + 1)
                    C_2D[r][c] = C[(r * SIZE + c) * DATA_WIDTH +: DATA_WIDTH];

            // Print the matrix
            $display("Output Matrix C:");
            for (r = 0; r < SIZE; r = r + 1) begin
                $write("[ ");
                for (c = 0; c < SIZE; c = c + 1) begin
                    $write("%d ", C_2D[r][c]);
                end
                $write("]\n");
            end
        end
    endtask

    // Test procedure
    initial begin
        // Initialize clock and reset
        clk = 0;
        rst = 1;
        #10 rst = 0; // Release reset after 10ns

        // Initialize input matrices A and B (row-major order)
        A = { 8'd4, 8'd3,
              8'd2, 8'd1 };

        B = { 8'd4, 8'd3,
              8'd2, 8'd1 };

        // Wait for computation to complete
        wait(done);

        // Print output matrix
        #10;
        print_matrix();

        // End simulation
        $stop;
    end
endmodule

