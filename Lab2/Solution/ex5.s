@ ARM Assembly - exercise 5
@ Group Number : 21

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@ load values
	mov r0, #10
	mov r1, #5
	mov r2, #7
	mov r3, #-8

	
	@ Write YOUR CODE HERE
	
	@ j=0;
	@ for (i=0;i<10;i++)
	@ 		j+=i;	
	
	@ Put final j to r5

	@ ---------------------
	
	MOV r5,#0; @r5(j)=0
	MOV r4,#0; @r4(i)=0
	
Loop:
	CMP r4,#10 @compare r4(i) with 10
	BGE Exit; @if i>=10 then go to Exit branch
	
	ADD r5,r5,r4; @incrementing j by i
	ADD r4,r4,#1; @incrementing i by 1
	B Loop; @goto the Loop
	
Exit: @exiting the loop
	
	@ ---------------------
	
	
	@ load aguments and print
	ldr r0, =format
	mov r1, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "The Answer is %d (Expect 45 if correct)\n"

