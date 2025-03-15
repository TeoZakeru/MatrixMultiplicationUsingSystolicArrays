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
│   ├── SystolicArray
│     └── sys.v        # Core Systolic Array module
│     └── pe.v    # Processing element for the array
│   ├──BoothMultiplier
|     └── Radix-8-Booth-Multiplier.v # Booth Multipler Module
├── tb/
|   ├──Systolic Array
│      └── tb.v     # Testbench for systolic array matmul verification
|   ├──BoothMultiplier
|     └── tb.v # Testbench for Booth Multiplier verification
|     └── verifyBoothMultiplier.py # Python script that tests the booth multiplier for exhaustive inputs
├── README.md                   # Project documentation
```
