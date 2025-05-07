module collector2 (
    input                    clk,
    input [47:0]             datain,
    output reg signed [79:0] input_a = 0,
    output reg signed [79:0] input_b = 0,
    output reg [2:0]         app = 0,
    output reg               sel = 0,
    output reg               en = 0
);
             
reg [2:0] packet = 0;
reg input_a_or_input_b = 0;
reg [39:0] data = 0;
integer count = 0;
always @(posedge clk) begin
    app <= datain[47:45];
    input_a_or_input_b <= datain[44];
    sel <= datain[43];
    packet <= datain[42:40];
    data <= datain[39:0];
    
    if (input_a_or_input_b == 0 && (app == 3'b001 || app == 3'b010 || app == 3'b011)) begin
        if (packet == 3'b000) begin
            input_a[79:40] <= data;
            en <= 0;
            count <= 0;
        end else if (packet == 3'b001) begin
            input_a[39:0] <= data;
            en <= 0;
        end
    end else if (input_a_or_input_b == 1 && (app == 3'b001 || app == 3'b010 || app == 3'b011)) begin
        if (packet == 3'b000) begin
            input_b[79:40] <= data;
            en <= 0;
        end else if (packet == 3'b001) begin
            input_b[39:0] <= data;
            if (count <= 7) begin
                en <= 1;
                count <= count + 1;
            end else en <= 0;
        end
    end else begin
        input_a <= 0;
        input_b <= 0;
        en <= 0;
    end
end    
endmodule