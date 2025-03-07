# Systolic Array-Based Matrix Multiplication in Verilog

## Overview
This repository contains a Verilog implementation of matrix multiplication using a systolic array architecture. The design is optimized for FPGA implementation and efficiently handles parallel computation for high-performance matrix operations.

## Features
- **Systolic Array Architecture:** Efficient parallel processing for matrix multiplication.
- **FPGA Implementation:** Designed to be synthesized on FPGAs for real-time applications.
- **Parameterized Design:** Supports different matrix sizes with parameterized configurations.
- **Pipeline Optimization:** Implements pipeline stages to improve computation throughput.
- **Testbench Included:** Provides simulation support for functional verification.

## File Structure
```
├── src/
│   ├── systolic_array.v        # Core Systolic Array module
│   ├── processing_element.v    # Processing element for the array
│   ├── matrix_controller.v     # Controls data flow in the array
│   └── tb_systolic_array.v     # Testbench for verification
├── docs/
│   ├── architecture_diagram.png  # Block diagram of the architecture
│   └── report.pdf                 # Detailed report on implementation
├── scripts/
│   ├── compile.tcl             # TCL script for FPGA synthesis
│   ├── run_simulation.do       # Script for ModelSim simulation
│   └── program_fpga.tcl        # Script for FPGA programming
├── README.md                   # Project documentation
└── LICENSE                      # License information
```

## Getting Started
### Prerequisites
- **Hardware:** FPGA board (e.g., Xilinx Zynq, Intel Cyclone, etc.)
- **Software Tools:**
  - Vivado / Quartus Prime (for synthesis & implementation)
  - ModelSim / QuestaSim (for simulation)
  - Verilog/SystemVerilog support

### Simulation
To run a simulation of the systolic array:
```bash
vsim -do scripts/run_simulation.do
```

### FPGA Synthesis & Implementation
For FPGA synthesis using Vivado:
```bash
vivado -mode batch -source scripts/compile.tcl
```
To program the FPGA:
```bash
vivado -mode batch -source scripts/program_fpga.tcl
```

## Configuration
Modify the `systolic_array.v` file to change matrix size:
```verilog
parameter MATRIX_SIZE = 4;  // Change this to modify the systolic array size
```

## Results
- Functional verification results can be viewed in the waveform outputs after simulation.
- FPGA resource utilization, timing reports, and power analysis are provided in `docs/report.pdf`.

## Future Enhancements
- Implement dynamic matrix size adaptation.
- Optimize dataflow for reduced latency.
- Extend support for floating-point computation.

## License
This project is licensed under the MIT License. See `LICENSE` for details.

## Contact
For any questions or contributions, feel free to reach out via GitHub Issues.

