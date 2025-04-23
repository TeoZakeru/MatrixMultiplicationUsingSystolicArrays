`timescale 1ns / 1ps

module SA_tb;

    parameter SIZE = 8;
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
    initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, SA_tb);
    end

    initial begin
        #150;
        clk = 0;
        rst = 0;
        #10 rst = 1;
        $monitor("%t %h", $time, C);

        A = {8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd37};
        B = {8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd2};
        #10;
        A = {8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd45, 8'd60};
        B = {8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd30, 8'd47};
        #10;
        A = {8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd53, 8'd45, 8'd1};
        B = {8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd27, 8'd25, 8'd2};
        #10;
        A = {8'd0, 8'd0, 8'd0, 8'd0, 8'd49, 8'd63, 8'd40, 8'd5};
        B = {8'd0, 8'd0, 8'd0, 8'd0, 8'd48, 8'd61, 8'd56, 8'd5};
        #10;
        A = {8'd0, 8'd0, 8'd0, 8'd14, 8'd24, 8'd35, 8'd48, 8'd52};
        B = {8'd0, 8'd0, 8'd0, 8'd2, 8'd57, 8'd1, 8'd46, 8'd16};
        #10;
        A = {8'd0, 8'd0, 8'd61, 8'd50, 8'd7, 8'd31, 8'd23, 8'd23};
        B = {8'd0, 8'd0, 8'd57, 8'd11, 8'd45, 8'd22, 8'd4, 8'd48};
        #10;
        A = {8'd0, 8'd0, 8'd3, 8'd53, 8'd28, 8'd19, 8'd12, 8'd44};
        B = {8'd0, 8'd42, 8'd22, 8'd42, 8'd2, 8'd19, 8'd23, 8'd46};
        #10;
        A = {8'd56, 8'd46, 8'd54, 8'd56, 8'd38, 8'd35, 8'd29, 8'd50};
        B = {8'd6, 8'd14, 8'd32, 8'd5, 8'd39, 8'd48, 8'd4, 8'd53};
        #10;
        A = {8'd56, 8'd1, 8'd22, 8'd53, 8'd59, 8'd59, 8'd50, 8'd0};
        B = {8'd56, 8'd52, 8'd17, 8'd28, 8'd54, 8'd38, 8'd8, 8'd0};
        #10;
        A = {8'd7, 8'd32, 8'd28, 8'd58, 8'd7, 8'd62, 8'd0, 8'd0};
        B = {8'd56, 8'd2, 8'd0, 8'd7, 8'd15, 8'd47, 8'd0, 8'd0};
        #10;
        A = {8'd42, 8'd9, 8'd13, 8'd19, 8'd19, 8'd0, 8'd0, 8'd0};
        B = {8'd12, 8'd58, 8'd2, 8'd60, 8'd5, 8'd0, 8'd0, 8'd0};
        #10;
        A = {8'd51, 8'd51, 8'd27, 8'd21, 8'd0, 8'd0, 8'd0, 8'd0};
        B = {8'd60, 8'd48, 8'd11, 8'd31, 8'd0, 8'd0, 8'd0, 8'd0};
        #10;
        A = {8'd35, 8'd17, 8'd33, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0};
        B = {8'd51, 8'd1, 8'd16, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0};
        #10;
        A = {8'd3, 8'd62, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0};
        B = {8'd28, 8'd18, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0};
        #10;
        A = {8'd13, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0};
        B = {8'd40, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0};
        #10;
        A = 64'd0;
        B = 64'd0;
        #10;
        A = 64'd0;
        B = 64'd0;
        #10;
        A = 64'd0;
        B = 64'd0;
        #10;
        A = 64'd0;
        B = 64'd0;
        #10;
        A = 64'd0;
        B = 64'd0;
        #10;
        A = 64'd0;
        B = 64'd0;
        #10;
        A = 64'd0;
        B = 64'd0;
        #10;
        A = 64'd0;
        B = 64'd0;

    end
    
    endmodule

