module filter(
    input clk,
    
    input signed [7:0] data,
    input signed [1:0] data_en,
    
    output signed [17:0] result
);
    reg [2:0] step = 0;

    reg signed [7:0] buff1 = 0;
    reg signed [7:0] buff2 = 0;
    reg signed [7:0] buff3 = 0;

    reg signed [15:0] mult = 0;
    reg signed [15:0] summ = 0;
    reg signed [17:0] result_reg = 0;

    always @(posedge clk) 
    begin
        case (step)
            1: begin 
                mult <= buff1 * 1;
            end
            2: begin 
                mult <= buff2 * 2;
            end
            3: begin 
                mult <= buff3 * 3;
            end
            default: begin
                mult <= 0;
            end
        endcase 
    end

    always @(posedge clk) 
    begin
        if (step == 5) begin
            result_reg <= summ + mult;
            summ <= 0;
            step <= 0;
        end else if (step != 0) begin
            summ <= summ + mult;
            step <= step + 1;
        end
    end
    
    always @(posedge clk) 
    begin
        if (data_en) begin 
            buff1 <= buff2;
            buff2 <= buff3;
            buff3 <= data;
            step <= 1;
        end
    end

    assign result = result_reg;
endmodule
