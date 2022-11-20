CFLAGS	=	-Wall -Wextra
CFLAGS	+=	-nostdinc -nostdlib -fno-builtin -c
CFLAGS	+=	-Iinclude

kernel8.img: kernel.elf
	aarch64-linux-gnu-objcopy -O binary $< $@

kernel.elf: led-blink.o
	aarch64-linux-gnu-ld -o $@ $+ -Map System.map -s -T sys.ld -x

led-blink.o: led-blink.s

.s.o:
	aarch64-linux-gnu-gcc $(CFLAGS) -o $@ $<

clean:
	rm -f *~ *.o *.img *.elf *.map

.PHONY: clean
