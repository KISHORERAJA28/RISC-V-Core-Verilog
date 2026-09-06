// ====================================================================
// Module: imm_generator.v
// Description: RV32I Immediate Generator — sign-extends and reorders
//              immediate fields for I-type and B-type instructions.
// ====================================================================
module imm_generator (
    input  wire [31:0] instruction,
    output reg  [31:0] imm_out
);
    wire [6:0] opcode = instruction[6:0];
    localparam OP_I_TYPE = 7'b0010011;
    localparam OP_BRANCH = 7'b1100011;

    always @(*) begin
        case (opcode)
            OP_I_TYPE:
                imm_out = {{20{instruction[31]}}, instruction[31:20]};
            OP_BRANCH:
                imm_out = {{19{instruction[31]}}, instruction[31], instruction[7],
                           instruction[30:25], instruction[11:8], 1'b0};
            default:
                imm_out = 32'd0;
        endcase
    end
endmodule
