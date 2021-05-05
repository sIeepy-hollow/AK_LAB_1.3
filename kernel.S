.syntax unified
.cpu cortex-m4
.thumb
#define A #3
#define B #2
#define C #1

.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
	.word __stack_start
	.word __kernel_reset__+1
	.size vtable_kernel, .-vtable_kernel

.section .rodata
	start_data: .asciz "kernel started"
	finish_data: .asciz "Result in register #3:"

.section .text
__kernel_reset__:
    mov r0, #3
    ldr r0, =start_data
    bl dbgput_line
    
	mov r0, A
	mov r1, B
	mov r2, C
	mul r3, r0, r1
	cmp r3, #10
	ITE GE
	orrGE r3, r0, r1
	andLT r3, r0, r1
	mul r3, r2
	mov r1, #0
	mov r2, #0

	ldr r0, = finish_data
	bl dbgput_line
	mov r0, r3
	bl dbgput_num
	
	end:
	b end
