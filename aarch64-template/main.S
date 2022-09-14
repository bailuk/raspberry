# TODO: Muss angepasst werden!! Funktionierender code in c-asm-template/

# ARMv8 A64 Quick Reference
# https://courses.cs.washington.edu/courses/cse469/18wi/Materials/arm64.pdf

# AArch64 Register and Instruction Quick Start
# https://wiki.cdot.senecacollege.ca/wiki/AArch64_Register_and_Instruction_Quick_Start

# Register naming (r = x = w):
# r = "register"
# x = "register 64 bit"
# w = "register 32 bit (word)"


# Make sure the linker puts this at the start of the kernel image
.section ".text.boot"            

# Execution starts here
.global _start                   


# Check processor ID is zero (executing on main core), else hang
# mrs=move register system, x1=a general purpose register ->  mrs=move register system x1=a general purpose register
# https://andreasch.com/2019/01/29/introduction-aarch64/
# MPIDR_EL1, Multiprocessor Affinity Register, EL1 
# https://developer.arm.com/documentation/100403/0200/register-descriptions/aarch64-system-registers/mpidr-el1--multiprocessor-affinity-register--el1?lang=en
_start:
    mrs     x1, mpidr_el1     

    and     x1, x1, #3           /* and operation: x1 = x1 and 3 (#3 = decimal 3) */
    cbz     x1, 2f               /* check x1 not zero -> jump to 2: (2f -> 2: forward)   cbz: call branch on zero? */

# We're _not_ on the main core, so hang in an infinite wait loop
1:  wfe                          /* wait for event */
    b       1b                   /* jump to 1: (1b -> 1: backward)  b: branch (Lazy loop) */


# Left shift und GPIO 24 (FSEL 12 / SET 24)
2:                               /* We're on the main core! */

    ldr x0,=0xFE200000           /* Basis adresse in r0 speichern */

    mov x1,#0x1000               /* Bit 12(13) setzen */
    str x1,[x0,#0x08]            /* FSEL2(SELECT) (funktion wählen) */

    mov x1,#0x1000000            /* Bit 24 (25) setzen */
    str x1,[x0,#0x1c]            /* SET (voltage setzen) */

    b       1b                   /* go back (1b) to lazy loop (at 1:) */



# Bare Metal Raspberry Pi 3:Blinking LED 
# https://www.instructables.com/Bare-Metal-Raspberry-Pi-3Blinking-LED/


# Broadcom BCM2837 ARM Peripherals (Manual)
# https://github.com/raspberrypi/documentation/files/1888662/BCM2837-ARM-Peripherals.-.Revised.-.V2-1.pdf
#
# Base address für GPIO: 
# 0x3f200000
#
# Offsets für GPIO:
# FSEL2(SELECT) 0x08
# GPSET0(SET)   0x1c
# GPCLR0(CLEAR) 0x28

# GPIO Function Select  [bit 1: enable output]
# GPFSEL2 controls GPIO 20-29
# GPFSEL has 3 bits for everey GPIO
#    0-2   control GPIO 20   [001] will enable output
#    3-5   control GPIO 21   [001 000] will enable output
#    6-8   control GPIO 22
#    9-11  control GPIO 23
#    12-14 control GPIO 24

# GPSET Pin Output Set Registers [write 1: enable pin / voltage] (FSEL must be set to output first)
# GPSET0  controls GPIO 0-31
# GPSET has one bit for every GPIO
#    0  control GPIO 1
#    1  control GPIO 2
#    23 control GPIO 24

# GPIO Pin Output Clear Register [write 1: clear pin / no voltage]
# GPCLR0 controls GPIO 0-31
# GPCLR has one bit for every GPIO
#    0  control GPIO 1
#    1  control GPIO 2
#    23 control GPIO 24
