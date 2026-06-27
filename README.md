# SPI-Communication-Link-Verilog
A simple Verilog implementation of an 8-bit parallel-to-serial transmitter and receiver link
# Serial Peripheral Communication Link Design & Verification

## 📌 Project Overview
This project implements a hardware serialization link consisting of an 8-bit parallel-to-serial transmitter (Tx) and a serial-to-parallel reconstruction receiver (Rx) written in Verilog RTL. The design emulates core principles of standard serial protocols like SPI.

## 🛠️ Tools Used
* **HDL:** Verilog / SystemVerilog
* **Simulator:** Icarus Verilog 12.0 via EDA Playground
* **Waveform Viewer:** EPWave

## 🏗️ System Architecture
1. **Transmitter (`design.sv`):** Takes an 8-bit parallel data frame (`parallel_in`), buffers it upon a `load_data` signal, and systematically shifts the bits out one-by-one via `serial_out`.
2. **Receiver (`design.sv`):** Samples the incoming serial line (`serial_in`) on every positive clock edge, reconstructs the bitstream into an internal shift register, and outputs the fully restored 8-bit byte.

## 🧪 Simulation Results
The design was validated using a structured testbench (`testbench.sv`). During simulation, the hex value `0xA5` (Binary: `10100101`) was loaded into the transmitter. Waveform analysis confirmed that the receiver successfully reconstructed the byte back to `0xA5` within 8 clock cycles with 100% accuracy.
