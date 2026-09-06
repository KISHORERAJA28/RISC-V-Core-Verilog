
// ====================================================================
// Module: riscv_core_top.v
// Description: Single-cycle RV32I core integrating Program Counter,
//              Instruction Memory, Register File, Immediate Generator,
//              Control Unit, and ALU. Supports R-type, I-type (ADDI-
//              family), and BEQ branch instructions.
// ====================================================================
module riscv_core_top (
    input  wire clk,
    input  wire rst
);
    wire [31:0] pc_current, branch_target, instruction;
    wire        pc_src;

    program_counter PC (
        .clk(clk), .rst(rst), .pc_src(pc_src),
        .branch_target(branch_target), .pc_out(pc_current)
    );

    instruction_memory IMEM (
        .addr(pc_current), .instruction(instruction)
    );

    wire [6:0] opcode = instruction[6:0];
    wire [4:0] rd     = instruction[11:7];
    wire [2:0] funct3 = instruction[14:12];
    wire [4:0] rs1    = instruction[19:15];
    wire [4:0] rs2    = instruction[24:20];
    wire [6:0] funct7 = instruction[31:25];

    wire [3:0] alu_control;
    wire       alu_src, reg_write, branch;

    control_unit CU (
        .opcode(opcode), .funct3(funct3), .funct7(funct7),
        .alu_control(alu_control), .alu_src(alu_src),
        .reg_write(reg_write), .branch(branch)
    );

    wire [31:0] imm_value;
    imm_generator IMMGEN (.instruction(instruction), .imm_out(imm_value));

    wire [31:0] rs1_data, rs2_data, alu_result;

    register_file RF (
        .clk(clk), .we(reg_write), .rs1_addr(rs1), .rs2_addr(rs2),
        .rd_addr(rd), .rd_data(alu_result),
        .rs1_data(rs1_data), .rs2_data(rs2_data)
    );

    wire [31:0] alu_operand_b = alu_src ? imm_value : rs2_data;
    wire        zero_flag;

    alu_32bit ALU (
        .operand_a(rs1_data), .operand_b(alu_operand_b),
        .alu_control(alu_control), .alu_result(alu_result), .zero_flag(zero_flag)
    );

    assign pc_src        = branch & zero_flag;
    assign branch_target = pc_current + imm_value;
endmodule
