/*
1. (a_re + i * a_im) * (b_re + i * b_im) = 
   = a_re * b_re + i * a_re * b_im + i * a_im * b_re + i * i * a_im * b_im = 
   = a_re * b_re - a_im * b_im + i * (a_re * b_im + a_im * b_re) =

2. k1 = a_re * (b_re + b_im) = a_re * b_re + a_re * b_im
3. k2 = b_im * (a_re + a_im) = b_im * a_re + b_im * a_im
4. k3 = b_re * (a_im - a_re) = b_re * a_im - b_re * a_re

5. res_re = k1 - k2 = 
   = (a_re * b_re + a_re * b_im) - (b_im * a_re + b_im * a_im) = 
   = a_re * b_re - b_im * a_im

6. res_im = k1 + k3 = 
   = (a_re * b_re + a_re * b_im) + (b_re * a_im - b_re * a_re) = 
   = a_re * b_im + b_re * a_im
*/

module complex_mult (
    input clk,
    
    input signed [7:0] a_re,
    input signed [7:0] a_im,
    input signed [7:0] b_re,
    input signed [7:0] b_im,
    
    output signed [15:0] res_re,
    output signed [15:0] res_im
);
    reg signed [7:0] a_re_reg = 0;
    reg signed [7:0] a_im_reg = 0;
    reg signed [7:0] b_re_reg = 0;
    reg signed [7:0] b_im_reg = 0;

    reg signed [15:0] k1 = 0;
    reg signed [15:0] k2 = 0;
    reg signed [15:0] k3 = 0;

    reg [2:0] step = 0;

    always @(posedge clk) 
    begin
        case (step)
            0: begin
                a_re_reg <= a_re;
                a_im_reg <= a_im;
                b_re_reg <= b_re;
                b_im_reg <= b_im;

                k1 <= a_re * (b_re + b_im);
                step <= 1;
            end
            1: begin 
                k2 <= b_im_reg * (a_re_reg + a_im_reg);   
                step <= 2;
            end
            2: begin 
                k3 <= b_re_reg * (a_im_reg - a_re_reg);
                step <= 0;
            end
        endcase 
    end

    assign res_re = k1 - k2;
    assign res_im = k1 + k3;
endmodule
