@ ARM Assembly - lab 2
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
	
	@	Sum = 0;
	@	for (i=0;i<10;i++){
	@			for(j=5;j<15;j++){
	@				if(i+j<10) sum+=i*2
	@				else sum+=(i&j);	
	@			}	
	@	} 
	@ Put final sum to r5
	
	@ ---------------------

	MOV r5,#0; @making the sum(r5) = 0
	MOV r4,#0; @making the i(r4) = 0
	
OuterLoop: @Entering the Outer Loop
	CMP r4,#10 @comparing r4(i) and 10 
	BGE Exit ; @get out of the outerloop if r4(i)>=10
	
	MOV r6,#5; @making j(r6) = 5
	
InnerLoop: @Entering the InnerLoop
	CMP r6,#15 @comparing j and 15
	BGE ExitI; @Get out of the innerloop if j>=15
		
	ADD r7,r4,r6; @making a tempory register for comparing i+j
		
	CMP r7,#10 @Compare i+j with 10
	BGE Else; @get out of the if statement when i+j>=10 and goto Else branch
		
	ADD r5,r5,r4,LSL #1; @if the condition is true sum+=i*2
	B Out; @skip the else branch by going to Out branch
		
Else: @if i+j>=10 connect this branch
	AND r8,r4,r6; @making a tempory register r8 for ANDing i and j
	ADD r5,r5,r8; @adding r8 to sum
		
Out: @this branch helps with skipping Else when i+j<10
	ADD r6,r6,#1; @increment j by 1
	B InnerLoop; @Goto the start of the InnerLoop again
	
ExitI:	@Getting out of the innerloop
	ADD r4,r4,#1; @increment i by 1
	B OuterLoop; @Goto the start of the OuterLoop again
	
Exit:
	
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
format: .asciz "The Answer is %d (Expect 300 if correct)\n"

