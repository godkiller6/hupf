.section .data
nums:
	.int 12, 4, 6, 7, 80, 34, 54, 46, 3, 23
sum:
	.int 0
divisor:
	.int 10
min:
	.int 0
output:
	.ascii"The average is %d.%d\nThe min is %d.\n"

.section .text
.globl _start
_start:
	movl $0, %edi

loop1: #compute the sum
	movl nums(, %edi, 4), %eax
	addl %eax, sum
	inc %edi
	cmpl $10, %edi
	jne loop1
	
	movl $1, %edi
	movl nums, %ecx
	movl %ecx, min
loop2: #compute the min
	movl nums(, %edi, 4), %ebx
	inc %edi
	cmpl min, %ebx
	jl exchange
	cmpl $10, %edi
	jne loop2
	jmp ok

exchange:
	movl %ebx, min 
	cmpl $10, %edi
	jne loop2

ok:	
	movl min, %ebx
	movl sum, %eax
	movl $0, %edx
	divl divisor
	pushl %ebx
	pushl %edx
	pushl %eax
	pushl $output
	call printf
	pushl $0
	call exit
