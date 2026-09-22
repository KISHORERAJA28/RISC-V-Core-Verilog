`timescale 1ns/1ps

module tb_riscv_core();
    reg clk;
    reg rst;

    riscv_core_top DUT (.clk(clk), .rst(rst));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("riscv_core.vcd");
        $dumpvars(0, tb_riscv_core);

        clk = 0;
        rst = 1;
        #12;
        rst = 0;
        #100;

        if (DUT.RF.registers[1] !== 32'd5) $display("FAIL: x1 = %0d (expected 5)", DUT.RF.registers[1]);
        else $display("PASS: x1 = %0d", DUT.RF.registers[1]);

        if (DUT.RF.registers[2] !== 32'd5) $display("FAIL: x2 = %0d (expected 5)", DUT.RF.registers[2]);
        else $display("PASS: x2 = %0d", DUT.RF.registers[2]);

        if (DUT.RF.registers[3] !== 32'd8) $display("FAIL: x3 (ADD) = %0d (expected 8)", DUT.RF.registers[3]);
        else $display("PASS: x3 (ADD) = %0d", DUT.RF.registers[3]);

        if (DUT.RF.registers[4] !== 32'd2) $display("FAIL: x4 (SUB) = %0d (expected 2)", DUT.RF.registers[4]);
        else $display("PASS: x4 (SUB) = %0d", DUT.RF.registers[4]);

        if (DUT.RF.registers[5] !== 32'd0) $display("FAIL: x5 = %0d (expected 0)", DUT.RF.registers[5]);
        else $display("PASS: x5 = %0d (branch correctly taken, instruction skipped)", DUT.RF.registers[5]);

        $display("Final PC = %0d (expected 28, core halted in self-loop)", DUT.pc_current);
        $finish;
    end

    initial begin
        $monitor("t=%0t rst=%b PC=%0d instr=%h alu_res=%0d zero=%b branch=%b pc_src=%b",
                  $time, rst, DUT.pc_current, DUT.instruction, DUT.alu_result,
                  DUT.zero_flag, DUT.branch, DUT.pc_src);
    end
endmodule
