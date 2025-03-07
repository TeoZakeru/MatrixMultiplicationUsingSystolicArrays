# Systolic Array-Based Matrix Multiplication in Verilog

## Overview
This repository contains a Verilog implementation of matrix multiplication using a systolic array architecture. The design is optimized for FPGA implementation and efficiently handles parallel computation for high-performance matrix operations.

## Features
- **Systolic Array Architecture:** Efficient parallel processing for matrix multiplication.
- **FPGA Implementation:** Designed to be synthesized on FPGAs for real-time applications.
- **Parameterized Design:** Supports different matrix sizes with parameterized configurations.
- **Testbench Included:** Provides simulation support for functional verification.

## File Structure
```
├── src/
│   ├── sys.v        # Core Systolic Array module
│   ├── pe.v    # Processing element for the array
├── tb/
│   └── tb.v     # Testbench for verification
├── README.md                   # Project documentation
```
