// ====================================================================
// Module: alu_32bit.v
// Description: Synthesizable 32-bit ALU for RV32I RISC-V Core Architecture
// Features: Supports ADD, SUB, AND, OR, XOR, SLL, SRL, SLT operations
// ====================================================================
module alu_32bit (
    input  wire [31:0] operand_a,   // 32-bit Input A
    input  wire [31:0] operand_b,   // 32-bit Input B
    input  wire [3:0]  alu_control, // 4-bit Operation Selector
    output reg  [31:0] alu_result,  // 32-bit Output Result
    output wire        zero_flag    // Status flag for branching logic
);
    localparam ALU_ADD = 4'b0000;
    localparam ALU_SUB = 4'b0001;
    localparam ALU_AND = 4'b0010;
    localparam ALU_OR  = 4'b0011;
    localparam ALU_XOR = 4'b0100;
    localparam ALU_SLL = 4'b0101; // Shift Left Logical
    localparam ALU_SRL = 4'b0110; // Shift Right Logical
    localparam ALU_SLT = 4'b0111; // Set Less Than (signed)

    always @(*) begin
        case (alu_control)
            ALU_ADD: alu_result = operand_a + operand_b;
            ALU_SUB: alu_result = operand_a - operand_b;
            ALU_AND: alu_result = operand_a & operand_b;
            ALU_OR:  alu_result = operand_a | operand_b;
            ALU_XOR: alu_result = operand_a ^ operand_b;
            ALU_SLL: alu_result = operand_a << operand_b[4:0];
            ALU_SRL: alu_result = operand_a >> operand_b[4:0];
            ALU_SLT: alu_result = ($signed(operand_a) < $signed(operand_b)) ? 32'd1 : 32'd0;
            default: alu_result = 32'h00000000;
        endcase
    end

    assign zero_flag = (alu_result == 32'h00000000) ? 1'b1 : 1'b0;
endmodule
