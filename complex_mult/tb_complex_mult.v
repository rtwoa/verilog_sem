`timescale 1ns / 1ns

module tb_complex_mult();
    reg clk = 0;
    
    reg signed [7:0] a_re = 0;
    reg signed [7:0] a_im = 0;
    reg signed [7:0] b_re = 0;
    reg signed [7:0] b_im = 0;
    
    wire signed [15:0] res_re;
    wire signed [15:0] res_im;

    initial
        forever #5 clk = ~clk;

    initial
    begin
        a_re <= 8'sd3;
        a_im <= 8'sd2;
        b_re <= 8'sd5;
        b_im <= 8'sd4;

        #10;  
        a_re <= 8'sd00;
        a_im <= 8'sd00;
        b_re <= 8'sd00;
        b_im <= 8'sd00;

        #20;
        $finish;
    end

    complex_mult dut (
        .clk(clk), 
        .a_re(a_re), 
        .a_im(a_im), 
        .b_re(b_re), 
        .b_im(b_im), 
        .res_re(res_re), 
        .res_im(res_im)
    );

    initial
    begin
        $dumpfile("test.vsd");
        $dumpvars;
    end

endmodule
