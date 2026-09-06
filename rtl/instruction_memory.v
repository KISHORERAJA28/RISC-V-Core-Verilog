
// ====================================================================
// Module: instruction_memory.v
// Description: Simple synthesizable ROM-style instruction memory.
//              Word-addressed via PC[9:2] (256 x 32-bit instructions).
//              Preloaded from an external hex file for simulation.
// ====================================================================
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
