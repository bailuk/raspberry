	.arch armv8-a
	.file	"char-loop.c"
	.text
	.global	text
	.section	.rodata
	.align	3
.LC0:
	.string	"hallo welt "
	.section	.data.rel.local,"aw"
	.align	3
	.type	text, %object
	.size	text, 8
text:
	.xword	.LC0
	.global	time_unit
	.section	.rodata
	.align	3
	.type	time_unit, %object
	.size	time_unit, 8
time_unit:
	.xword	500
	.align	3
.LC1:
	.string	"sleep %ld\n"
	.text
	.align	2
	.global	sleep
	.type	sleep, %function
sleep:
.LFB0:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	str	x0, [sp, 24]
	ldr	x1, [sp, 24]
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	printf
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE0:
	.size	sleep, .-sleep
	.section	.rodata
	.align	3
.LC2:
	.string	"on"
	.text
	.align	2
	.global	on
	.type	on, %function
on:
.LFB1:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	puts
	nop
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE1:
	.size	on, .-on
	.section	.rodata
	.align	3
.LC3:
	.string	"off"
	.text
	.align	2
	.global	off
	.type	off, %function
off:
.LFB2:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	puts
	nop
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE2:
	.size	off, .-off
	.align	2
	.global	space
	.type	space, %function
space:
.LFB3:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	str	w0, [sp, 28]
	ldrsw	x1, [sp, 28]
	mov	x0, 500
	mul	x0, x1, x0
	bl	sleep
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE3:
	.size	space, .-space
	.align	2
	.global	light
	.type	light, %function
light:
.LFB4:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	str	w0, [sp, 28]
	str	x1, [sp, 16]
	b	.L6
.L7:
	ldr	w0, [sp, 28]
	sub	w0, w0, #1
	str	w0, [sp, 28]
	bl	on
	ldr	x0, [sp, 16]
	bl	sleep
	bl	off
	mov	x0, 500
	bl	sleep
.L6:
	ldr	w0, [sp, 28]
	cmp	w0, 0
	bgt	.L7
	nop
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE4:
	.size	light, .-light
	.align	2
	.global	s
	.type	s, %function
s:
.LFB5:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	str	w0, [sp, 28]
	mov	x0, 500
	mov	x1, x0
	ldr	w0, [sp, 28]
	bl	light
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE5:
	.size	s, .-s
	.align	2
	.global	l
	.type	l, %function
l:
.LFB6:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	str	w0, [sp, 28]
	mov	x0, 500
	lsl	x0, x0, 1
	mov	x1, x0
	ldr	w0, [sp, 28]
	bl	light
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc



.LFE6:
	.size	l, .-l
	.align	2
	.global	blink
	.type	blink, %function
blink:
.LFB7:
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	strb	w0, [sp, 31]
	ldrb	w0, [sp, 31]
	cmp	w0, 97
	bne	.L11
	mov	w0, 1
	bl	s
	mov	w0, 1
	bl	l
	b	.L12
.L11:
	ldrb	w0, [sp, 31]
	cmp	w0, 98
	bne	.L13
	mov	w0, 1
	bl	l
	mov	w0, 3
	bl	s
	b	.L12
.L13:
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
.L14:
	ldrb	w0, [sp, 31]
	cmp	w0, 100
	bne	.L15
	mov	w0, 1
	bl	l
	mov	w0, 2
	bl	s
	b	.L12
.L15:
	ldrb	w0, [sp, 31]
	cmp	w0, 101
	bne	.L16
	mov	w0, 1
	bl	s
	b	.L12
.L16:
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
.L17:
	ldrb	w0, [sp, 31]
	cmp	w0, 103
	bne	.L18
	mov	w0, 2
	bl	l
	mov	w0, 1
	bl	s
	b	.L12
.L18:
	ldrb	w0, [sp, 31]
	cmp	w0, 104
	bne	.L19
	mov	w0, 4
	bl	s
	b	.L12
.L19:
	ldrb	w0, [sp, 31]
	cmp	w0, 105
	bne	.L20
	mov	w0, 2
	bl	s
	b	.L12
.L20:
	ldrb	w0, [sp, 31]
	cmp	w0, 106
	bne	.L21
	mov	w0, 1
	bl	s
	mov	w0, 3
	bl	l
	b	.L12
.L21:
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
.L22:
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
.L23:
	ldrb	w0, [sp, 31]
	cmp	w0, 109
	bne	.L24
	mov	w0, 2
	bl	l
	b	.L12
.L24:
	ldrb	w0, [sp, 31]
	cmp	w0, 110
	bne	.L25
	mov	w0, 1
	bl	l
	mov	w0, 1
	bl	s
	b	.L12
.L25:
	ldrb	w0, [sp, 31]
	cmp	w0, 111
	bne	.L26
	mov	w0, 3
	bl	l
	b	.L12
.L26:
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
.L27:
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
.L28:
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
.L29:
	ldrb	w0, [sp, 31]
	cmp	w0, 115
	bne	.L30
	mov	w0, 3
	bl	s
	b	.L12
.L30:
	ldrb	w0, [sp, 31]
	cmp	w0, 116
	bne	.L31
	mov	w0, 1
	bl	l
	b	.L12
.L31:
	ldrb	w0, [sp, 31]
	cmp	w0, 117
	bne	.L32
	mov	w0, 2
	bl	s
	mov	w0, 1
	bl	l
	b	.L12
.L32:
	ldrb	w0, [sp, 31]
	cmp	w0, 118
	bne	.L33
	mov	w0, 3
	bl	s
	mov	w0, 1
	bl	l
	b	.L12
.L33:
	ldrb	w0, [sp, 31]
	cmp	w0, 119
	bne	.L34
	mov	w0, 1
	bl	s
	mov	w0, 2
	bl	l
	b	.L12
.L34:
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
.L35:
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
.L36:
	ldrb	w0, [sp, 31]
	cmp	w0, 122
	bne	.L37
	mov	w0, 2
	bl	l
	mov	w0, 2
	bl	s
	b	.L12
.L37:
	mov	w0, 4
	bl	space
.L12:
	mov	w0, 2
	bl	space
	nop
	ldp	x29, x30, [sp], 32
	ret



.LFE7:
	.size	blink, .-blink
	.align	2
	.global	char_loop
	.type	char_loop, %function
char_loop:
.LFB8:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	adrp	x0, text
	add	x0, x0, :lo12:text
	ldr	x0, [x0]
	str	x0, [sp, 24]
	b	.L39
.L40:
	ldr	x0, [sp, 24]
	ldrb	w0, [x0]
	bl	blink
	ldr	x0, [sp, 24]
	add	x0, x0, 1
	str	x0, [sp, 24]
.L39:
	ldr	x0, [sp, 24]
	ldrb	w0, [x0]
	cmp	w0, 0
	bne	.L40
	nop
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE8:
	.size	char_loop, .-char_loop
	.align	2
	.global	main
	.type	main, %function
main:
.LFB9:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	str	w0, [sp, 28]
	str	x1, [sp, 16]
	bl	char_loop
	mov	w0, 0
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE9:
	.size	main, .-main
	.ident	"GCC: (Debian 12.2.0-2) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
