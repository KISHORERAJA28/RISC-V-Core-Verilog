// Testbench for functional verification
module tb_alu();
    reg  [31:0] a, b;
    reg  [3:0]  ctrl;
    wire [31:0] out;
    wire        z;

    alu_32bit uut (.operand_a(a), .operand_b(b), .alu_control(ctrl), .alu_result(out), .zero_flag(z));

    initial begin
        // Test Addition
        a = 32'd15; b = 32'd10; ctrl = 4'b0000; #10;
        // Test Subtraction (expect zero flag)
        a = 32'd25; b = 32'd25; ctrl = 4'b0001; #10;
        $finish;
    end
endmodule
