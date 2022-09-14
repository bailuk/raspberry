bin = kernel.img
elf = kernel.elf
obj = kernel.o
code = main.s
		

$(bin) : $(elf)
	arm-none-eabi-objcopy $(elf) -O binary $(bin)

$(elf) : $(obj)
	arm-none-eabi-ld $(obj) -o $(elf) 


$(obj) : $(code)
	arm-none-eabi-as -g -o $(obj) $(code)



clean:						#@clean tool
	- rm *.o
	- rm *.img
	- rm *.list
	- rm *.map
	- rm *.elf
