/* https://www.math.utah.edu/docs/info/ld_3.html */

MEMORY
{
	ram : ORIGIN = 0x80000, LENGTH = 0x10000
}

SECTIONS
{
	.text	: {*(.text*)} > ram
	.bss	: {*(.bss*)} > ram
}
