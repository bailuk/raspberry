.global	_start

_start:
    mrs x1, mpidr_el1        /* move register system (MPIDR_EL1, Multiprocessor Affinity Register, EL1) to x1 */
    and x1, x1, #3           /* and operation: x1 = x1 and 3 (#3 = decimal 3) 0b11 */
    cbz x1, 2f               /* check x1 not zero -> jump to 2: (2f -> 2: forward)   cbz: call branch on zero? */

1:  /* We're _not_ on the main core, so hang in an infinite wait loop */
    wfe                      /* wait for event */
    b   1b                   /* jump to 1: (1b -> 1: backward)  b: branch (Lazy loop) */

2:  /* We're on the main core! */
	mov	sp, #0x80000         /* init stack pointer */

    mrs x3, CNTFRQ_EL0       /* Read frequency of system counter (read hz) */
    ldr x0,=0xFE200000       /* Basis adresse in r0 speichern */

    mov w1,#0x1000           /* Bit 12(13) setzen */
    str w1,[x0,#0x08]        /* FSEL2(SELECT) (funktion wählen) */

    mov w1,#0x1000000        /* Bit 24 (25) setzen */
    str w1,[x0,#0x1c]        /* SET (voltage setzen) */

3:  /* clear timer */
    msr CNTP_TVAL_EL0, x3    /* Holds the timer value for the EL1 physical timer (store timer frequency) */

    mov x1, #1
    msr CNTP_CTL_EL0, x1     /* Control register of EL1 physical timer. Enable timer */

4:  /* sleep clear timer */
    mrs x1, CNTP_CTL_EL0     /* Read control register of EL1 physical timer. */
    and x1, x1, 0b100        /* Store bit 3 in x1. Bit 3: Condition is met */
    cbz x1, 4b               /* If x1 is zero (condition is not met) go back to 3: (loop) */

    mov w1,#0x1000000        /* Bit 24 (25) setzen */
    str w1,[x0,#0x28]        /* Clear LED */

5:  /* on timer */
    msr CNTP_TVAL_EL0, x3    /* Holds the timer value for the EL1 physical timer (store timer frequency) */
    
    mov x1, #1
    msr CNTP_CTL_EL0, x1     /* Control register of EL1 physical timer. Enable timer */

6:  /* sleep on timer */
    mrs x1, CNTP_CTL_EL0     /* Read control register of EL1 physical timer. */
    and x1, x1, 0b100        /* Store bit 3 in x1. Bit 3: Condition is met */
    cbz x1, 6b               /* If x1 is zero (condition is not met) go back to 3: (loop) */

    mov w1,#0x1000000        /* Bit 24 (25) setzen */
    str w1,[x0,#0x1c]        /* SET (voltage setzen) */

    b   3b                   /* Enable clear timer */
