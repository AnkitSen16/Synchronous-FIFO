# Synchronous-FIFO

# Synchronous FIFO 8‑bit

This project contains the Verilog implementation of an 8‑bit Synchronous FIFO (First‑In‑First‑Out) memory module. The design includes a testbench to simulate and verify the functionality of the FIFO.

## Features

- 8‑bit data width  
- Synchronous read and write operations  
- Full and empty flags  
- Simulation using Xilinx Vivado  

## Files

- **sync_fifo.v**: Verilog module for the 8‑bit Synchronous FIFO.  
- **tb.v**: Testbench for the FIFO module.  
- **tb.tcl**: TCL script for running the simulation.  
- **xsnapshot.png**: Snapshot of the XSIM simulation.  

## Usage

1. Open Vivado and create a new project.  
2. Add `sync_fifo.v` and `tb.v` to the project.  
3. Create a simulation set and include `tb.tcl`.  
4. Run the simulation and view `xsnapshot.png` for reference.
