.syntax unified
.cpu cortex-m4
.thumb

.global bootload
.section .rodata
	image: .incbin "kernel.bin"
end_of_image:
	str_boot_start: .asciz "starting bootloader ..."
	str_boot_end: .asciz "bootloader completed..."
	str_boot_indicate: .asciz "#"
	
.section .text
bootload:
	ldr r0, =str_boot_start
	bl dbgput_line
	ldr r0, =end_of_image
	ldr r1, =image
	ldr r2, =_ram_start
	

loop:
	ldrh r3, [r1, r4]
	strh r3, [r2, r4]
	add r4, #2
	add r5, r1, r4
	cmp r0, r5
	bhi loop

    bl newline
    ldr r0, =str_boot_end
    bl dbgput_line

    ldr lr, =bootload_end
    add lr, #1
    ldr r2, =_ram_start

    add r2, #4 //reset_kernel
    ldr r0, [r2]
    bx r0

bootload_end:
    b bootload_end
