// Von hier:
// https://github.com/cupnes/bare_metal_aarch64

#define GPFSEL1	0xFE200008
#define GPSET0  0xFE20001C
#define GPCLR0  0xFE200028

int main(void)
{
	*(volatile unsigned int *)GPFSEL1 = 0x01 << 12;
    *(volatile unsigned int *)GPSET0  = 0x01 << 24;

	return 0;
}
