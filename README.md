# **CalcX**

## **Overview**

**CalcX** is a computation module built on the **RAH (Real-time Application Handler)** protocol, developed by [Vicharak](https://vicharak.in). It enables seamless communication between a CPU and an FPGA, providing a wide range of mathematical operations such as:

- **Trigonometric Functions:** `sin`, `cos`, `sinh`, `cosh`, `tanh`, `arcsin`, `arccos`, `arctan` , `sqrt`
- **Exponential and Logarithmic Functions:** `exp`, `ln`
- **Arithmetic Operations:** `add`, `sub`, `mult`, `div`
- **Bitwise Shifting:** `left shift`, `right shift`
- **Special Operations:** `integer square root`, `float-to-fixed`, and `fixed-to-float` conversions

These operations are executed on the FPGA, with data communication managed via the RAH protocol.


## **RAH Protocol**

The **RAH (Real-time Application Handler)** protocol is engineered to support real-time data exchange between a CPU and an FPGA. It works by encapsulating data into structured frames, each associated with a unique `app_id`. These frames are sent to the FPGA and routed to the corresponding `APP_WR_FIFO`.

For outgoing data (from FPGA to CPU), the FPGA writes results to `APP_RD_FIFO`. These results are then encapsulated and sent back to the CPU for decoding.

This design provides a modular and scalable framework for implementing high-performance computational modules on FPGA.

> 🔗 **For more information:** [RAH Protocol Documentation](https://github.com/vicharak-in/rah-bit)

## **CORDIC**

The **CORDIC** engine implements a suite of transcendental functions using 32-bit input. It supports the following operations:

- `sin`, `cos`
- `sinh`, `cosh`, `tanh`
- `arcsin`, `arccos`, `arctan`
- `exp`, `ln`
- `sqrt`

### **Specifications**
```txt
sin input 
Input  : sin(90)
Output : 1
```

> 🔗 **Learn more:** [CORDIC Documentation](https://github.com/vicharak-in/cordic)

## **Divider Core**

This module performs signed division on two 32-bit inputs, producing both the quotient and the remainder.

### **Specifications**
```txt
Input  : Dividend = 4 , Divisor = 2
Output : Quotient = 2 , Remainder = 0
```

> 🔗 **Learn more:** [Divider Core Documentation](https://github.com/vicharak-in/divider_core)

## **Float-to-Fixed / Fixed-to-Float Conversion (F_TO_F)**

The **F_TO_F** module handles conversion between fixed-point and floating-point number formats.

### **Specifications**
```txt
Input  : 28.6528
Output : 0x403ca790000000000000
```

> 🔗 **Learn more:** [F_TO_F Documentation](https://github.com/vicharak-in/f_to_f)

## **Integer Square Root (ISR)**

The **ISR** module computes the integer square root of a 256-bit number, returning a 128-bit result along with a 129-bit remainder.

### **Specifications**
```txt
Input  : 3
Output : Square Root = 3 , Remainder = 1
```

> 🔗 **Learn more:** [ISR Documentation](https://github.com/vicharak-in/square_root)


## RAH Protocol User Guide - Resources

For further details on how to use the RAH protocol, you can refer to the following guides:

1. **[CPU Usage Guide](docs/cpu-usage-guide.md)**: 
   This guide will provide detailed instructions on how to set up and use the RAH protocol on the CPU side, including configuration, data encapsulation, and integration with CPU applications.

2. **[FPGA Implementation Guide](docs/fpga-implementation.md)**: 
   This guide covers the FPGA side of the RAH protocol, explaining how to implement the RAH design, decode data frames, and manage the FIFO buffers for both write and read cycles.

3. **[RAH Example Integration](docs/rah-example-integration.md)**: 
   This document provides a step-by-step example of integrating the RAH protocol between the CPU and FPGA, demonstrating the complete flow from data generation on the CPU to processing on the FPGA and back.
