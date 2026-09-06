# Design and Simulation of a Single-Cycle RV32I RISC-V Core
This repository contains a synthesizable Verilog HDL implementation of a single-cycle 
32-bit RISC-V (RV32I) processor core, covering the Program Counter, Instruction Memory, 
Register File, Immediate Generator, Control Unit, and ALU. Functionally verified with 
Icarus Verilog and synthesized (gate-level) with Yosys.

## Microarchitecture
* **Datapath:** Single-cycle, 32-bit RV32I subset (R-type, I-type, BEQ branch).
* **Register File:** 32 x 32-bit, x0 hardwired to zero, synchronous write / async read.
* **ALU:** ADD, SUB, AND, OR, XOR, SLL, SRL, SLT with zero-flag branch support.
* **Control Unit:** Opcode/funct3/funct7 decode driving ALU control, reg-write, and branch signals.
* **Verified via:** Directed testbench checking register file contents and branch-taken 
  behavior; waveform dump (`riscv_core.vcd`) for GTKWave inspection.
* **Synthesis:** Gate-level synthesis via Yosys — see cell count breakdown in repo notes.

## Roadmap
1. 5-stage pipelining (Fetch/Decode/Execute/Memory/Writeback) with hazard detection.
2. Load/Store instruction support (memory-mapped data memory).
3. JAL/JALR jump instructions.
4. Timing closure against a real standard-cell PDK (e.g., Skywater 130nm via OpenLane).
