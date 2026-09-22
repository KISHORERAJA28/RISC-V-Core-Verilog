module control_unit (
    input  wire [6:0] opcode,
    input  wire [2:0] funct3,
    input  wire [6:0] funct7,
    output reg  [3:0] alu_control,
    output reg        alu_src,      
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
                    3'b000: alu_control = (funct7 == 7'b0100000) ? 4'b0001 : 4'b0000;
                    3'b111: alu_control = 4'b0010; 
                    3'b110: alu_control = 4'b0011; 
                    3'b100: alu_control = 4'b0100; 
                    3'b001: alu_control = 4'b0101; 
                    3'b101: alu_control = 4'b0110; 
                    3'b010: alu_control = 4'b0111; 
                    default: alu_control = 4'b0000;
                endcase
            end
            OP_I_TYPE: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;
                case (funct3)
                    3'b000: alu_control = 4'b0000; 
                    3'b111: alu_control = 4'b0010;
                    3'b110: alu_control = 4'b0011;
                    3'b100: alu_control = 4'b0100; 
                    default: alu_control = 4'b0000;
                endcase
            end
            OP_BRANCH: begin
                alu_control = 4'b0001; 
                branch      = 1'b1;
            end
            default: ;
        endcase
    end
endmodule
