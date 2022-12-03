# Raspberry PI 4

- [Specifications](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/specifications/)


# GPIO

- [Bare Metal Raspberry Pi 3:Blinking LED](https://www.instructables.com/Bare-Metal-Raspberry-Pi-3Blinking-LED/)
- [Broadcom BCM2837 ARM Peripherals (Manual)](https://github.com/raspberrypi/documentation/files/1888662/BCM2837-ARM-Peripherals.-.Revised.-.V2-1.pdf)


## Base address


Old: `0x3f200000`
Rapberry Pi 4: `0xfe200000`


## Register offsets

- FSEL1(SELECT) 0x04
- FSEL2(SELECT) 0x08
- GPSET0(SET)   0x1c
- GPCLR0(CLEAR) 0x28


## FSEL2: Function Select  [bit 1: enable output]

FSEL2 controls GPIO 20-29  
FSEL2 has 3 bits for everey GPIO  
- 0-2   control GPIO 20   [001] will enable output
- 3-5   control GPIO 21   [001 000] will enable output
- 6-8   control GPIO 22
- 9-11  control GPIO 23
- 12-14 control GPIO 24


## GPSET0: Pin Output Set Registers [write 1: enable pin / voltage]

Enable output on FSEL first  
GPSET0  controls GPIO 0-31  
GPSET has one bit for every GPIO: 
- 0  control GPIO 1
- 1  control GPIO 2
- ...
- 23 control GPIO 24


## GPCLR Pin Output Clear Register [write 1: clear pin / no voltage]

GPCLR0 controls GPIO 0-31  
GPCLR has one bit for every GPIO  
- 0  control GPIO 1
- 1  control GPIO 2
- ...
- 23 control GPIO 24


# ARM Cortex-A72 Core

- [Wikipedia](https://en.wikipedia.org/wiki/ARM_Cortex-A72)
- Microarchitecture: ARMv8-A
- [64-bit architecture named "AArch64"](https://en.wikipedia.org/wiki/ARM_architecture_family#64/32-bit_architecture)

- [ARM Cortex-A Series Programmer's Guide for ARMv8-A](https://developer.arm.com/documentation/den0024/a/The-A64-instruction-set/Data-processing-instructions/Multiply-and-divide-instructions)
- [Armv8-A Architecture Registers](https://developer.arm.com/documentation/ddi0595/2021-12/AArch64-Registers?lang=en)
- [MPIDR, Multiprocessor Affinity Register](https://developer.arm.com/documentation/ddi0595/2021-12/AArch64-Registers/MPIDR-EL1--Multiprocessor-Affinity-Register?lang=en)

## Register

[AArch64 special registers](https://developer.arm.com/documentation/den0024/a/ARMv8-Registers/AArch64-special-registers)
- 29 register are general purpose
    - R0 bis R28
    - X0 -> 64 bit access (bit 0 to 63)
    - W0 -> 32 bit access (bit 0 to 31)
- Special register:
    - R29: Frame pointer
    - R30: Procedure link register
    - SP:  Stack pointer
    - XZR and WZR: Zero register
    - PC: Program counter


# ARM Cortex-A72 Physical Timer

- Broadcom BCM2711, Quad core Cortex-A72 (ARM v8) 64-bit SoC @
- [AArch64 Generic Timer register summary](https://developer.arm.com/documentation/100095/0002/way1382454514990)


## Register

- CNTFRQ_EL0, Counter-timer Frequency register
    - 64bit
    - Frequency in Hz

- CNTP_TVAL_EL0, Counter-timer Physical Timer TimerValue register
    - 64 bit
    - Timer vaule in cycles (how many cycles until condition is met)

- CNTP_CTL_EL0 Counter-timer Physical Timer Control register
    - 64bit
    - ISTATUS, bit [2] 0: Timer condition is not met, 1: Timer condition is met
    - IMASK,   bit [1] 0: Timer interrupt is not masked by the IMASK bit 1: Timer interrupt is masked by the IMASK bit.
    - ENABLE,  bit [0] 0: Timer disabled. 1: Timer enabled.

```assembly
mrs x1, CNTFRQ_EL0       /* Read frequency of system counter (read hz) */
msr CNTP_TVAL_EL0, x1    /* Holds the timer value for the EL1 physical timer (store timer frequency) */

mov x1, #1
msr CNTP_CTL_EL0, x1     /* Control register for the EL1 physical timer. (activate) */

loop:
    mrs x1, CNTP_CTL_EL0 /* Read control register */
    and x1, x1, 0b100    /* Store bit 3 in x1 */
    cbz x1, loop         /* zero: contition not met -> continue loop */

timeout:
    /* handle timeout */
```

