# TODO: Muss angepasst werden!! Funktionierender code in c-asm-template/

.section .init
.globl _start
_start:

@ Initialisierung GPIO
ldr r0,=0xFE200000

@ GPIO24 ist im GPFSEL2 (= 0x3F200008)
@ an den Bits 14-12  (als Ouput = '001')
mov r1,#1
lsl r1,#12

@ GPIO24 Port auf Output stellen
str r1,[r0,#0x8]

/* LED zünden...   GPIO 24 auf HIGH stellen;
Anmerkung dazu: das ist Bit 24 im Register GPSET0 (= 0x3f20 001c).
Register GPSET0, welches für GPIO 24 zuständig ist, hat den Adressen-Offset "0x1c". Durch das Setzen des 24. Bits in GPSET0  wird das LED angezündet.*/

mov r1,#1
lsl r1,#24
str r1,[r0,#0x1c]
loop$:
b loop$
