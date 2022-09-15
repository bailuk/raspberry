# GPIO

## Resources
[Bare Metal Raspberry Pi 3:Blinking LED](https://www.instructables.com/Bare-Metal-Raspberry-Pi-3Blinking-LED/)

[Broadcom BCM2837 ARM Peripherals (Manual)](https://github.com/raspberrypi/documentation/files/1888662/BCM2837-ARM-Peripherals.-.Revised.-.V2-1.pdf)


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
