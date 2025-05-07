module alu (
    input                     clk,
    input                     rstn,
    input                     en,
    input [2:0]               app,
    input                     sel,
    input signed [79:0]       input_a,
    input signed [79:0]       input_b,
    output reg signed [159:0] output_c = 0,
    output reg                done = 0
);
reg [3:0] count = 0;

always @(posedge clk) begin
    if (en) begin
        if (count < 3) begin
            done <= 0;
            count <= count + 1;
        end else if (count >= 3 && count < 7) begin
            done <= 1;
            count <= count + 1;
        end else if (count == 7) begin
            count <= count + 1;
            done <= 0;
        end else if (count == 8) begin
            count <= 0;
            done <= 0;
        end
        case(app)
            /* ADD */
            3'b001: begin
                if (sel == 0) begin
                    output_c <= input_a + input_b;
                end else if (sel == 1) begin
                    output_c <= input_a - input_b;
                end
            end
            /* MUL */
            3'b010: begin
                output_c <= input_a * input_b;
            end
            /* SHIFT */
            3'b011: begin
                if (sel == 0) begin
                    output_c <= (input_a << input_b);
                end else if (sel == 1) begin
                    output_c <= (input_a >> input_b);
                end
            end
        endcase
    end else begin
        output_c <= 0;
        done <= 0;
        count <= 0;
    end
end
endmodule