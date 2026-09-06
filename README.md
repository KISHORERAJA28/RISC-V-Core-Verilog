# Design and Simulation of a Synthesizable RISC-V (RV32I) ALU

This repository contains the synthesizable Verilog HDL implementation of a 32-bit Arithmetic Logic Unit (ALU) designed inline with the base RISC-V (RV32I) ISA specification. The module has been functionally verified using testbenches on ModelSim/Icarus Verilog.

## Microarchitectural Features
* **Data Width:** Full 32-bit execution paths for operands and outputs.
* **Supported Opcodes:** ADD, SUB, AND, OR, XOR, SLL (Shift Left Logical), SRL (Shift Right Logical).
* **Control Unit Interface:** Driven by a 4-bit ALU control matrix.
* **Conditional Branch Support:** Hardware-asserted Zero Flag for immediate branch evaluation (`BEQ`, `BNE`).

## Microarchitectural Roadmap & Scalability
While this repository currently holds the validated functional core execution unit (ALU), the architecture is framed to scale into a complete processor pipeline with the following planned blocks:
1. **Instruction Fetch (IF) Stage:** Integration of a 32-bit Program Counter (PC) paired with an independent Instruction Memory interface.
2. **5-Stage Pipelining:** Migration from single-cycle execution to an interleaved execution model (*Fetch, Decode, Execute, Memory, Writeback*).
3. **Hazard Detection Logic:** Implementation of forwarding paths and pipeline stall units to resolve structural, data, and control hazards dynamically.
