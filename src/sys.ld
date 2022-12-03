/* https://www.math.utah.edu/docs/info/ld_3.html */

MEMORY
{
	/* 0x80000 to 0x90000 for code */
	ram : ORIGIN = 0x80000, LENGTH = 0x10000
}

SECTIONS
{
	/* bootloader starts programm at 0x800000
	   first segment is .text (code segment)  */ 
	.text	: {*(.text*)} > ram
	.bss	: {*(.bss*)} > ram
}
