module instruction_memory (
    input  wire [31:0] addr,
    output wire [31:0] instruction
);
    reg [31:0] imem [0:255];

    initial begin
        $readmemh("program.hex", imem);
    end

    assign instruction = imem[addr[9:2]];
endmodule
