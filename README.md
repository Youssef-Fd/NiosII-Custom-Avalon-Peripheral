# Nios II Custom Avalon Peripheral

A custom memory-mapped Avalon-MM hardware peripheral (`Tp_periph`) developed in VHDL and integrated into a Nios II embedded system using Intel Quartus Prime and Platform Designer (Qsys). It computes the arithmetic average (mean) of four 32-bit input values in hardware.

## Overview

This project implements a custom Avalon Memory-Mapped (Avalon-MM) slave peripheral that takes four 32-bit inputs (`D_0`, `D_1`, `D_2`, `D_3`), sums them in hardware, and returns their average (via a sign-extended 2-bit arithmetic right shift, i.e., division by 4) when read at offset `0x0`.

Offloading the sum and division-by-four to hardware demonstrates how custom digital logic can accelerate simple numeric operations and communicate with a Nios II soft-core processor over a standard memory-mapped interconnect.

## Features

- Custom Avalon-MM slave peripheral (`Tp_periph`) implemented in VHDL.
- Four 32-bit memory-mapped input registers (`0x0`–`0x3`).
- Synchronous register writes on rising clock edge when `chipselect = '1'` and `write = '1'`.
- Hardware summation of all four 32-bit inputs (`S = D_0 + D_1 + D_2 + D_3`).
- Hardware arithmetic average calculation (sign-extended right shift by 2 bits, `S / 4`) returned on read at address `0x0`.
- Integration into a Nios II system using Platform Designer (Qsys) and top-level VHDL.

## Architecture

The peripheral exposes the following Avalon-MM signals:

| Signal | Direction | Description |
|---|---|---|
| `Clock` | Input | System/peripheral clock |
| `reset` | Input | Asynchronous active-high reset |
| `chipselect` | Input | Peripheral select signal from Avalon interconnect |
| `address[1:0]` | Input | 2-bit word register address (`"00"` to `"11"`) |
| `write` | Input | Write strobe |
| `read` | Input | Read strobe |
| `writeData[31:0]` | Input | 32-bit data written to the selected input register |
| `readData[31:0]` | Output | 32-bit registered output data (returns average at address `0x0`, `0` otherwise) |

### Register Map

| Word Offset | Register / Output | Access | Behavior |
|---|---|---|---|
| `0x0` (`"00"`) | `data_in0` / Average Output | Write / Read | Write stores `D_0`; Read returns sign-extended `(S >> 2)` |
| `0x1` (`"01"`) | `data_in1` | Write | Stores `D_1` |
| `0x2` (`"10"`) | `data_in2` | Write | Stores `D_2` |
| `0x3` (`"11"`) | `data_in3` | Write | Stores `D_3` |

### Data Processing

The peripheral stores four 32-bit values:

$$D_0,\; D_1,\; D_2,\; D_3$$

It computes their sum in hardware:

$$S = D_0 + D_1 + D_2 + D_3$$

When the Nios II processor performs a read at offset `0x0`, the peripheral outputs a sign-extended arithmetic shift right by 2 bits (equivalent to signed integer division by 4):

$$\text{Average} = \lfloor S / 4 \rfloor$$

*(In VHDL: `(31 downto 30 => resultat(31)) & resultat(31 downto 2)` when `address = "00"`, and `(others => '0')` for other read addresses.)*

## Software Example & Output

The following Nios II C program writes `0`, `0`, `30`, and `30` to the four registers using `TP_PERIPH_0_BASE` from `system.h`, then reads back the hardware-computed average from offset `0`:

```c
#include <io.h>
#include "system.h"
#include <stdio.h>

int main()
{
    volatile int *moy_ptr = (int *)TP_PERIPH_0_BASE;
    printf("hello from nios II \n");
    int resultat = 0;

    *moy_ptr = 00;
    *(moy_ptr + 1) = 00;
    *(moy_ptr + 2) = 30;
    *(moy_ptr + 3) = 30;
    resultat = *moy_ptr;

    printf("%d \n", resultat);

    return 0;
}
```[cite: 2]

### Expected Nios II Console Output

With inputs `0`, `0`, `30`, and `30`, the sum is `60` and the hardware average (`60 / 4`) is `15`:

```text
hello from nios II
15
```[cite: 2]

## Hardware and Software Tools

- **HDL:** VHDL
- **FPGA Design:** Intel Quartus Prime
- **System Integration:** Platform Designer (Qsys)
- **Processor:** Nios II (Eclipse SBT for Nios II)
- **Interface:** Avalon Memory-Mapped (Avalon-MM)
