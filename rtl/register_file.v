// ====================================================================
// Module: register_file.v
// Description: RV32I 32x32-bit General Purpose Register File
// Features: 2 asynchronous read ports, 1 synchronous write port,
//           x0 hardwired to zero (per RV32I spec)
// ====================================================================
module register_file (
    input  wire        clk,
    input  wire        we,
    input  wire [4:0]  rs1_addr,
    input  wire [4:0]  rs2_addr,
    input  wire [4:0]  rd_addr,
    input  wire [31:0] rd_data,
    output wire [31:0] rs1_data,
    output wire [31:0] rs2_data
);
    reg [31:0] registers [0:31];
    integer i;

    always @(posedge clk) begin
        if (we && rd_addr != 5'd0) begin
            registers[rd_addr] <= rd_data;
        end
    end

    assign rs1_data = (rs1_addr == 5'd0) ? 32'd0 : registers[rs1_addr];
    assign rs2_data = (rs2_addr == 5'd0) ? 32'd0 : registers[rs2_addr];

    initial begin
        for (i = 0; i < 32; i = i + 1) registers[i] = 32'd0;
    end
endmodule
