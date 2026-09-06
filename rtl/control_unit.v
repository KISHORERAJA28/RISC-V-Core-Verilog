// ====================================================================
// Module: control_unit.v
// Description: RV32I Instruction Decoder — maps opcode/funct3/funct7
//              fields to ALU control signals and datapath control
//              signals (register write, ALU-source select, branch).
// Supported instruction classes: R-type, I-type (ADDI-family), BEQ.
// ====================================================================
module control_unit (
    input  wire [6:0] opcode,
    input  wire [2:0] funct3,
    input  wire [6:0] funct7,
    output reg  [3:0] alu_control,
    output reg        alu_src,      // 0 = rs2_data, 1 = immediate
    output reg        reg_write,
    output reg        branch
);
    localparam OP_R_TYPE = 7'b0110011;
    localparam OP_I_TYPE = 7'b0010011;
    localparam OP_BRANCH = 7'b1100011;

    always @(*) begin
        alu_control = 4'b0000;
        alu_src     = 1'b0;
        reg_write   = 1'b0;
        branch      = 1'b0;

        case (opcode)
            OP_R_TYPE: begin
                reg_write = 1'b1;
                case (funct3)
                    3'b000: alu_control = (funct7 == 7'b0100000) ? 4'b0001 : 4'b0000; // SUB : ADD
                    3'b111: alu_control = 4'b0010; // AND
                    3'b110: alu_control = 4'b0011; // OR
                    3'b100: alu_control = 4'b0100; // XOR
                    3'b001: alu_control = 4'b0101; // SLL
                    3'b101: alu_control = 4'b0110; // SRL
                    3'b010: alu_control = 4'b0111; // SLT
                    default: alu_control = 4'b0000;
                endcase
            end
            OP_I_TYPE: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;
                case (funct3)
                    3'b000: alu_control = 4'b0000; // ADDI
                    3'b111: alu_control = 4'b0010; // ANDI
                    3'b110: alu_control = 4'b0011; // ORI
                    3'b100: alu_control = 4'b0100; // XORI
                    default: alu_control = 4'b0000;
                endcase
            end
            OP_BRANCH: begin
                alu_control = 4'b0001; // SUB, zero_flag => equality
                branch      = 1'b1;
            end
            default: ;
        endcase
    end
endmodule
