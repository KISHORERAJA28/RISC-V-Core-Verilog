// ====================================================================
// Module: control_unit.v
// Description: Simplified RISC-V Instruction Decoder to ALU Control Mapping
// ====================================================================

module control_unit (
    input  wire [6:0] opcode,      // RISC-V 7-bit Opcode fields
    input  wire [2:0] funct3,      // 3-bit instruction qualifier
    output reg  [3:0] alu_control  // Output to drive alu_32bit.v
);

    always @(*) begin
        case (opcode)
            7'b0110011: begin // R-Type instructions (e.g., ADD, SUB, AND)
                if (funct3 == 3'b000) alu_control = 4'b0000; // ADD
                else if (funct3 == 3'b111) alu_control = 4'b0010; // AND
                else alu_control = 4'b0000;
            end
            7'b0010011: begin // I-Type instructions (e.g., ADDI)
                alu_control = 4'b0000; // Force ADD logic for immediate offsets
            end
            default: alu_control = 4'b0000;
        endcase
    end
endmodule
