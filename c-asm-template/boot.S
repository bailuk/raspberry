	.globl	_start
_start:
	mov	sp, #0x80000

	# Aufruffen von main in main.c:
	# bl	main

	# Assembler variante von main.c: 
    mov	x0, 8
	movk	x0, 0xfe20, lsl 16   /* 0xFE200008 nach x0 */
	mov	w1, 4096                 /* 0x1000  0x01 << 12  nach w1 */
	str	w1, [x0]                 /* w1 nach adresse von x0 */
	mov	x0, 28
	movk	x0, 0xfe20, lsl 16  /*  0xFE20001C nach x0  */
	mov	w1, 16777216            /*  0x1000000 nach w1 */
	str	w1, [x0]                /*  w1 nach adresse von x0 */ 

	b	.                       /* branch nach dieser adresse ( while(1); ) */
