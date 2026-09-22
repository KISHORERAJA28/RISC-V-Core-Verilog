module program_counter (
    input  wire        clk,
    input  wire        rst,
    input  wire        pc_src,        
    input  wire [31:0] branch_target,
    output reg  [31:0] pc_out
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            pc_out <= 32'h00000000;
        else if (pc_src)
            pc_out <= branch_target;
        else
            pc_out <= pc_out + 32'd4;
    end
endmodule
