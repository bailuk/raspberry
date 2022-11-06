/* 
	https://sourceware.org/binutils/docs/as/ARM-Directives.html 
	https://wolchok.org/posts/how-to-read-arm64-assembly-language/
*/

.LC1: /* local constant */
	.string	"sleep %ld\n"
	.text                      /* switch to text segment */
	.align 2
sleep:
.LFB0: /* local function beginning */
	stp	x29, x30, [sp, -32]!   /* storing a pair, sp = stack pointer */
	mov	x29, sp
	str	x0, [sp, 24]
	ldr	x1, [sp, 24]
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1           
	bl	printf
	ldp	x29, x30, [sp], 32     /* loading a pair */
	ret

.LC2: /* local constant */
	.string	"on"              /* string constant at .LC2 */
	.text
	.align	2
	.global	on
	.type	on, %function
on:
.LFB1:
	stp	x29, x30, [sp, -16]!
	mov	x29, sp
	adrp	x0, .LC2          /* load string address into register 0 */
	add	x0, x0, :lo12:.LC2
	bl	puts                  /* call put string (TODO: replace with LED I/O) */
	ldp	x29, x30, [sp], 16
	ret

.LC3: 
	.string	"off"
	.text
	.align	2
off:
.LFB2:
	stp	x29, x30, [sp, -16]!
	mov	x29, sp
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	puts
	ldp	x29, x30, [sp], 16
	ret

space:
.LFB3:
	stp	x29, x30, [sp, -32]!   /* save register into stack */
	mov	x29, sp                /* set pc */
	str	w0, [sp, 28]           /* push first argument (int count) into stack ... */
	ldrsw	x1, [sp, 28]       /* ... and load it into register 1 */
	mov	x0, 500                /* move 500 (timeout unit) into register 0 */
	mul	x0, x1, x0             /* r0 = r1 * r0 => argument for sleep()*/
	bl	sleep                  /* call sleep() */
	ldp	x29, x30, [sp], 32     /* restore context ... */
	ret                        /* ... and return */

light:
.LFB4:
	stp	x29, x30, [sp, -32]!    /* save register into stack */
	mov	x29, sp                 /* set pc */
	str	w0, [sp, 28]            /* push first argument (int count) into stack */
	str	x1, [sp, 16]            /* push second argument (long timeout) into stack */
	b	.L6                     /* start loop */
.L7: /* continue loop */
	ldr	w0, [sp, 28]            /* get first argument from stack */
	sub	w0, w0, #1              /* subtract 1 and store into register 0 */
	str	w0, [sp, 28]            /* push register 0 into stack */
	bl	on                      /* call on() */
	ldr	x0, [sp, 16]            /* get second argument (timeout argument for sleep) from stack */
	bl	sleep                   /* call sleep(x0) */
	bl	off                     /* call off() */
	mov	x0, 500                 /* set timout argument to 500... */
	bl	sleep                   /* ... and call sleep(x0) */
.L6:  /* start loop */
	ldr	w0, [sp, 28]            /* get first argument (count) into register 0 */
	cmp	w0, 0                   /* is it 0 ? */
	bgt	.L7                     /* branch if greater than 0 */
	ldp	x29, x30, [sp], 32      /* if 0 restore context... */
	ret                         /* ...and return by calling old pc */

s:
.LFB5:
	stp	x29, x30, [sp, -32]!    /* save register into stack */
	mov	x29, sp                 /* set pc */
	str	w0, [sp, 28]            /* push count argument into stack */
	mov	x0, 500                 /* set timeout argument to 500 */
	mov	x1, x0                  /* and move it to register 1 (why?) */
	ldr	w0, [sp, 28]            /* load count argument from stack into register 0 */
	bl	light                   /* call light */
	ldp	x29, x30, [sp], 32      /* restore context.. */
	ret                         /* and call old next pc */

l:
.LFB6: /* see s() */
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	str	w0, [sp, 28]
	mov	x0, 500
	lsl	x0, x0, 1
	mov	x1, x0
	ldr	w0, [sp, 28]
	bl	light
	ldp	x29, x30, [sp], 32
	ret

blink:
.LFB7: 
	stp	x29, x30, [sp, -32]!  /* https://stackoverflow.com/questions/64638627/explain-arm64-instruction-stp
	                             1. suptract 32 from address stored at sp (stack pointer) and store new value into RAM at address sp
								 2. store x29 and x30 into memory at address stored at sp
							  */ 
	mov	x29, sp               /* store stack pointer into register 29 */
	strb	w0, [sp, 31]      /* store argument (char) into stack at 31 */
	ldrb	w0, [sp, 31]      /* .. load back into register w0 (why?) */
	cmp	w0, 97                /* is it 97 ('a') ? */
	bne	.L11                  /* else try next at .L11 */

	  /* 'a' */
	mov	w0, 1                 /* call s and l functions */
	bl	s
	mov	w0, 1
	bl	l
	b	.L12                  /* then go to .L12 */
.L11: /* 'b' */
	ldrb	w0, [sp, 31]
	cmp	w0, 98
	bne	.L13
	mov	w0, 1
	bl	l
	mov	w0, 3
	bl	s
	b	.L12
.L13: /* 'c' */
	ldrb	w0, [sp, 31]
	cmp	w0, 99
	bne	.L14
	mov	w0, 1
	bl	l
	mov	w0, 1
	bl	s
	mov	w0, 1
	bl	l
	mov	w0, 1
	bl	s
	b	.L12
.L14: /* 'd' */
	ldrb	w0, [sp, 31]
	cmp	w0, 100
	bne	.L15
	mov	w0, 1
	bl	l
	mov	w0, 2
	bl	s
	b	.L12
.L15: /* 'e' */
	ldrb	w0, [sp, 31]
	cmp	w0, 101
	bne	.L16
	mov	w0, 1
	bl	s
	b	.L12
.L16: /* 'f' */
	ldrb	w0, [sp, 31]
	cmp	w0, 102
	bne	.L17
	mov	w0, 2
	bl	s
	mov	w0, 1
	bl	l
	mov	w0, 1
	bl	s
	b	.L12
.L17: /* 'g' */
	ldrb	w0, [sp, 31]
	cmp	w0, 103
	bne	.L18
	mov	w0, 2
	bl	l
	mov	w0, 1
	bl	s
	b	.L12
.L18: /* 'h' */
	ldrb	w0, [sp, 31]
	cmp	w0, 104
	bne	.L19
	mov	w0, 4
	bl	s
	b	.L12
.L19: /* 'i' */
	ldrb	w0, [sp, 31]
	cmp	w0, 105
	bne	.L20
	mov	w0, 2
	bl	s
	b	.L12
.L20: /* 'j' */
	ldrb	w0, [sp, 31]
	cmp	w0, 106
	bne	.L21
	mov	w0, 1
	bl	s
	mov	w0, 3
	bl	l
	b	.L12
.L21: /* 'k' */
	ldrb	w0, [sp, 31]
	cmp	w0, 107
	bne	.L22
	mov	w0, 1
	bl	s
	mov	w0, 1
	bl	l
	mov	w0, 2
	bl	s
	b	.L12
.L22: /* 'l' */
	ldrb	w0, [sp, 31]
	cmp	w0, 108
	bne	.L23
	mov	w0, 1
	bl	s
	mov	w0, 1
	bl	l
	mov	w0, 2
	bl	s
	b	.L12
.L23: /* 'm' */
	ldrb	w0, [sp, 31]
	cmp	w0, 109
	bne	.L24
	mov	w0, 2
	bl	l
	b	.L12
.L24: /* 'n' */
	ldrb	w0, [sp, 31]
	cmp	w0, 110
	bne	.L25
	mov	w0, 1
	bl	l
	mov	w0, 1
	bl	s
	b	.L12
.L25: /* 'o' */
	ldrb	w0, [sp, 31]
	cmp	w0, 111
	bne	.L26
	mov	w0, 3
	bl	l
	b	.L12
.L26: /* 'p' */
	ldrb	w0, [sp, 31]
	cmp	w0, 112
	bne	.L27
	mov	w0, 1
	bl	s
	mov	w0, 2
	bl	l
	mov	w0, 1
	bl	s
	b	.L12
.L27: /* 'q' */
	ldrb	w0, [sp, 31]
	cmp	w0, 113
	bne	.L28
	mov	w0, 2
	bl	l
	mov	w0, 1
	bl	s
	mov	w0, 1
	bl	l
	b	.L12
.L28: /* 'r' */
	ldrb	w0, [sp, 31]
	cmp	w0, 114
	bne	.L29
	mov	w0, 1
	bl	s
	mov	w0, 1
	bl	l
	mov	w0, 1
	bl	s
	b	.L12
.L29: /* 's' */
	ldrb	w0, [sp, 31]
	cmp	w0, 115
	bne	.L30
	mov	w0, 3
	bl	s
	b	.L12
.L30: /* 't' */
	ldrb	w0, [sp, 31]
	cmp	w0, 116
	bne	.L31
	mov	w0, 1
	bl	l
	b	.L12
.L31: /* 'u' */
	ldrb	w0, [sp, 31]
	cmp	w0, 117
	bne	.L32
	mov	w0, 2
	bl	s
	mov	w0, 1
	bl	l
	b	.L12
.L32: /* 'v' */
	ldrb	w0, [sp, 31]
	cmp	w0, 118
	bne	.L33
	mov	w0, 3
	bl	s
	mov	w0, 1
	bl	l
	b	.L12
.L33: /* 'w' */
	ldrb	w0, [sp, 31]
	cmp	w0, 119
	bne	.L34
	mov	w0, 1
	bl	s
	mov	w0, 2
	bl	l
	b	.L12
.L34: /* 'x' */
	ldrb	w0, [sp, 31]
	cmp	w0, 120
	bne	.L35
	mov	w0, 1
	bl	s
	mov	w0, 2
	bl	l
	mov	w0, 1
	bl	s
	b	.L12
.L35: /* 'y' */
	ldrb	w0, [sp, 31]
	cmp	w0, 121
	bne	.L36
	mov	w0, 1
	bl	l
	mov	w0, 1
	bl	s
	mov	w0, 2
	bl	l
	b	.L12
.L36: /* 'z' */
	ldrb	w0, [sp, 31]
	cmp	w0, 122
	bne	.L37
	mov	w0, 2
	bl	l
	mov	w0, 2
	bl	s
	b	.L12
.L37: /* else: unknown character: asume space */
	mov	w0, 4
	bl	space
.L12: /* end of function (everithing meets here) */
	mov	w0, 2
	bl	space
	ldp	x29, x30, [sp], 32      /* free stack and restore registers... */
	ret                         /* ... and return to old pc */

.LC8: /* local constant */
	.string	"hallo welt "
	.text                             /* switch to text segment */
	.align 2
char_loop:
.LFB8: /* local function block */
	stp	x29, x30, [sp, -32]!   /* store x29 and x30 into stack at sp (stack pointer => address in RAM) -32 bit */
	mov	x29, sp                /* move stack pointer to x29 */
	adrp	x0, .LC8           /* store address of text in x0 */
	add	x0, x0, :lo12:.LC8     /* add low 12 bit offset https://sourceware.org/binutils/docs/as/AArch64_002dRelocations.html#AArch64_002dRelocations */
	str	x0, [sp, 24]           /* store x0 int stack pointer + 24 bit */
	b	.L42                   /* branch l42 (start loop) */
.L43: /* continue loop */                       
	ldr	x0, [sp, 24]           /* load back sp + 24bit into x0 (text pointer)*/
	ldrb	w0, [x0]           /* get char from x0 address (w0 will be argument for blink(char c) */
	bl	blink                  /* call blink */
	ldr	x0, [sp, 24]           /* and again load back text address pointer */
	add	x0, x0, 1              /* increment text address pointer by one */
	str	x0, [sp, 24]           /* and store new text adress ointer to stack (offset 24) */
.L42: /* start loop */
	ldr	x0, [sp, 24]           /* load back sp + 24bit into x0 */
	ldrb	w0, [x0]           /* load content at address in x0 into w0 */
	cmp	w0, 0                  /* is it (character) 0 ? */
	bne	.L43                   /* branch not equal (continue loop) */
	ldp	x29, x30, [sp], 32     /* yes it is 0 => restore stack pointer */
	ret                        /* return */

.LFE8:                         /* local function export main (obsolete) */                            
	.size	char_loop, .-char_loop
	.align	2
	.global	main
	.type	main, %function

main:
.LFB9:
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	str	w0, [sp, 28]
	str	x1, [sp, 16]
	bl	char_loop
	mov	w0, 0
	ldp	x29, x30, [sp], 32
	ret

.LFE9:  /* local function export entrypoint (obsolete) */
	.size	main, .-main
	.ident	"GCC: (Debian 12.2.0-2) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
