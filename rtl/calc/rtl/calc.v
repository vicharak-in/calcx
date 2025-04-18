module calc(
    input         clk,
    input [47:0]  datain,
    input         empty,
    output [47:0] dataout,
    output reg    rden,
    output        wren
);

wire [79:0]  input_a;
wire [79:0]  input_b;
wire [2:0]   app;
wire         sel;
wire         en;
wire         done;
wire [159:0] output_c;

always @(posedge clk) begin
    if (empty == 0) rden = 1;
    else if (empty == 1) rden = 0;
end

collector2 uc(
    .clk     (clk),
    .datain  (datain),
    .input_a (input_a),
    .input_b (input_b),
    .app     (app),
    .sel     (sel),
    .en      (en)
);

alu ua(
    .clk      (clk),
    .en       (en),
    .app      (app),
    .sel      (sel),
    .input_a  (input_a),
    .input_b  (input_b),
    .output_c (output_c),
    .done     (done)
);

dout2 du(
    .clk      (clk),
    .output_c (output_c),
    .app      (app),
    .sel      (sel),
    .done     (done),
    .dataout  (dataout),
    .wren     (wren)
);
endmodule