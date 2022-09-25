@ ARM Assembly - exercise 7 
@ Group Number : 21

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	
@Corresponding C CODE
@int fib(int n) {
	@if (n < 2) return n;
	@else return fib(n-1) + fib(n-2);}
@ ---------------------	
Fibonacci:
	sub sp,sp,#12;		@making room for 3 items
	str lr,[sp,#8];		@store lr on the stack
	str r4,[sp,#4];		@store r4 on the stack
	str r0,[sp,#0];		@store r0(n) on the stack
	
	cmp r0,#2;			@compare r0(n) with 2
	bgt else;			@if n>2 goto else
	
	mov r0,#1;			@otherwise make r0=1
	add sp,sp,#12;		@pop 3 items from the stack
	mov pc,lr;			@move the control flow to lr

else:
	sub r0,r0,#1;		@subsitute 1 form n(r0)
	bl Fibonacci;		@call the Fibonacci function

	mov r4,r0;			@make r4 to r0
	
	ldr r0,[sp,#0];		@load the original n to r0 from the stack
	sub r0,r0,#2;		@subsitute 2 form n(r0)
	bl Fibonacci;		@call the Fibonacci function
	
	add r0,r0,r4;		@add fib(n-1)+fib(n-2)
	
	ldr r4,[sp,#4];		@load r4 from the stack
	ldr lr,[sp,#8];		@load lr from the stack
	add sp,sp,#12;		@pop 3 items from the stack
	mov pc,lr;			@return to caller

@ ---------------------
	
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value n

	@ calling the Fibonacci function
	mov r0, r4 	@the arg1 load
	bl Fibonacci
	mov r5,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "F_%d is %d\n"

