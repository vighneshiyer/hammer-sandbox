`timescale 1ns/10ps

module mac_tb();
    localparam WIDTH = 8;
    localparam N = 4;
    localparam density = 0.5;
    localparam cycles = 1_000_000;

    logic clk = 0;
    logic [N-1:0] [WIDTH-1:0] a, b;
    logic [N-1:0] [(2*WIDTH)-1:0] c;
    logic [N-1:0] [(2*WIDTH)-1:0] out;
    always #(2) clk <= ~clk;

    mac_array #(.WIDTH(WIDTH), .N(N)) dut (
        .clk(clk), .a(a), .b(b), .c(c), .out(out)
    );

    integer i;
    initial begin
        for (i = 0; i < cycles; i = i + 1) begin
            a = $urandom();
            b = $urandom();
            if (($urandom() / 32'hffff_ffff) < density) begin
                c = $urandom();
            end else begin
                c = 'd0;
            end
            @(posedge clk);
        end
    end
endmodule
