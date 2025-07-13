# Synchronous-FIFO

## Overview

This project contains the Verilog implementation of an 16‑bit Synchronous FIFO (First‑In‑First‑Out) memory module. The design includes a testbench to simulate and verify the functionality of the FIFO.
The design is parameterized for:
- FIFO Depth
- Data Width
## :hammer_and_wrench: Design Description

The **Synchronous FIFO** refers to a FIFO Design where data values are written sequentially into a memory array using a clock signal, and the data values are sequentially read out from the memory array using the same clock signal. It uses a circular buffer structure having two pointers (`rd_ptr` and `wr_ptr`).
- `rd_ptr` is incremented when a valid read operation is performed
- `wr_ptr` is incremented when a valid write operation is performed
It also consists of a **counter** that keeps track of the number of data entries stored in the FIFO.
- It increments when data is written into FIFO.
- It decrements when data is read from FIFO.
- It holds its value when both read and write operations are performed simultaneouly or when neither of the operations are performed.
This logic ensures the FIFO never underflows or overflows while still allowing reads and writes to occur concurrently whenever it is'nt full or empty.
## Waveform
The simulation waveform for the Synchronous FIFO is shown below. The following scenarios are demonstrated:
- Continous write operations were performed until the FIFO became full.
- Performed valid read operations once data has been written.
- Verified that `fifo_full` and `fifo_empty` flags updates correctly.
 ![Image Alt](image_url)




