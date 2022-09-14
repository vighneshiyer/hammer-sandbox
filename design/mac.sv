module pipelined_mac #(WIDTH = 8) (
    input clk,
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input [(2*WIDTH)-1:0] c,
    output logic [(2*WIDTH)-1:0] out
);
    logic [WIDTH-1:0] a_reg, b_reg;
    logic [(2*WIDTH)-1:0] c_reg;
    always_ff @(posedge clk) begin
        a_reg <= a;
        b_reg <= b;
        c_reg <= c;
        out <= (a_reg * b_reg) + c_reg;
    end
endmodule

module mac_array #(WIDTH = 8, N = 16) (
    input clk,
    input [N-1:0] [WIDTH-1:0] a,
    input [N-1:0] [WIDTH-1:0] b,
    input [N-1:0] [(2*WIDTH)-1:0] c,
    output logic [N-1:0] [(2*WIDTH)-1:0] out
);
    genvar i;
    generate for (i = 0; i < N; i = i + 1) begin
        pipelined_mac #(.WIDTH(WIDTH)) mac (
            .a(a[i]), .b(b[i]), .c(c[i]), .out(out[i])
        );
    end endgenerate
endmodule
