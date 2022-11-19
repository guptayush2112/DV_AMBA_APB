# DV_AMBA_APB

This Repository contains the RTL Design of AMBA-APB Interface Protocol implementing an incrementor logic and the verification for the same done using the Vyoma's UpTickPro Verification Tool.

# Table of Contents
 * [Introduction](#Introduction)
 * [Background](#Background)
 * [Block Diagram](#Block-Diagram)
 * [Tools Used](#Tools-Used)
 * [RTL Coding and Simulation](#RTL-Coding-and-Simulation)
 * [Synthesis](#Synthesis)
 * [Conclusion](#Conclusion)
 * [Author](#Author)
 * [References](#References)

# Introduction

The Advanced Microcontroller Bus Architecture (AMBA) is used as the on-chip bus in system-on-a-chip (SoC) designs. Since its inception, the scope of AMBA has gone far beyond microcontroller devices and is now widely used on a range of ASIC and SoC parts including applications processors used in modern portable mobile devices. AMBA protocol is an open standard, on-chip interconnect specification for the connection and management of functional blocks in a System-on-Chip (SoC). It facilitates right-first-time development of multi-processor designs with large numbers of controllers and peripherals. System on Chip utilizes Advanced RISC Machines (ARM) based Advanced Microcontroller Bus Architecture (AMBA) transport for all the interconnections of the bocks present on the chip.

# Background

AMBA was introduced by ARM Ltd in 1996. The first AMBA buses were Advanced System Bus (ASB) and Advanced Peripheral Bus (APB). In its 2nd version, AMBA 2, ARM added AMBA High-performance Bus (AHB) that is a single clock-edge protocol. In 2003, ARM introduced the 3rd generation, AMBA 3, including AXI to reach even higher performance inter-connects.

The Advanced Micro controller Bus Architecture (AMBA) bus protocols from ARM standardize on chip communication mechanisms between various functional blocks (or IP) for building high performance SOC designs. These designs typically have one or more micro controllers or microprocessors along with several other components — internal memory or external memory bridge, DSP, DMA, accelerators and various other peripherals like USB, UART, PCIE, I2C etc — all integrated on a single chip. The primary motivation of AMBA protocols is to have a standard and efficient way to interconnecting these blocks with re-use across multiple designs. APB is low bandwidth and low performance bus used to connect the peripherals like UART, keypad, timer and other peripheral devices to the bus architecture.

