# Nios II Custom Avalon Peripheral

A custom memory-mapped Avalon-MM peripheral developed in VHDL and integrated into a Nios II-based embedded system using Intel Quartus Prime and Platform Designer (Qsys).

## Overview

This project focuses on the design and integration of a custom hardware peripheral into a Nios II system through the **Avalon Memory-Mapped (Avalon-MM) interface**.

The peripheral implements a hardware-based arithmetic operation. It provides four 32-bit input registers accessible through the Avalon interface. The stored values are added in hardware, and the resulting value can be retrieved by the Nios II processor through a memory-mapped read transaction.

The project demonstrates the interaction between custom digital hardware and a soft-core processor using a standard FPGA interconnect.

## Features

- Custom Avalon-MM slave peripheral implemented in VHDL.
- Four 32-bit memory-mapped input registers.
- Synchronous register write operations.
- Hardware-based arithmetic computation.
- Memory-mapped read access to the computed result.
- Integration into a Nios II system using Platform Designer (Qsys).
- Top-level FPGA system integration using VHDL.

## Architecture

The peripheral exposes the following Avalon-MM signals:

| Signal | Description |
|---|---|
| `Clock` | Peripheral clock |
| `reset` | Reset signal |
| `chipselect` | Peripheral selection |
| `address[1:0]` | Register address |
| `write` | Write control |
| `read` | Read control |
| `writeData[31:0]` | Input data |
| `readData[31:0]` | Output data |

### Register Map

| Address | Register | Access |
|---|---|---|
| `0x0` | Input Register 0 | Write |
| `0x1` | Input Register 1 | Write |
| `0x2` | Input Register 2 | Write |
| `0x3` | Input Register 3 | Write |

### Data Processing

The peripheral stores four input values:

D_0, D_1, D_2, D_3

The arithmetic operation is performed directly in hardware:

S = D_0 + D_1 + D_2 + D_3

The result is then made available through the read interface at address `0x0`, with the output formatted according to the VHDL implementation.


## Hardware and Software Tools

- **HDL:** VHDL
- **FPGA Design:** Intel Quartus Prime
- **System Integration:** Platform Designer (Qsys)
- **Processor:** Nios II
- **Interface:** Avalon Memory-Mapped (Avalon-MM)
---
