CFILES = $(wildcard *.c)
GCCFLAGS = -wALL -O2 -ffreestanding -nostdinc -nostdlib -nostdfiles

all: kernel8.img

main.o: main.S
	aarch64-linux-gnu-gcc $(CLANGFLAGS) -c main.S -o main.o

kernel8.img: main.o
	aarch64-linux-gnu-ld -m aarch64elf -nostdlib main.o -T link.ld -o kernel8.elf
	aarch64-linux-gnu-objcopy -O binary kernel8.elf kernel8.img

clean:
	-rm *.o 
	-rm *.img
	-rm *.elf
