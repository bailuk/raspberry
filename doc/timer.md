# Physical Timer

## Hardware

Broadcom BCM2711, Quad core Cortex-A72 (ARM v8) 64-bit SoC @
- [Specifications](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/specifications/)
- [Armv8-A Architecture Registers](https://developer.arm.com/documentation/ddi0595/2021-12/AArch64-Registers?lang=en)


## Registers

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


