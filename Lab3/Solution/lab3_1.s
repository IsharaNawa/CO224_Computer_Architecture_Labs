@ ARM Assembly - lab 3.1
@ 
@ Roshan Ragel - roshanr@pdn.ac.lk
@ Hasindu Gamaarachchi - hasindu@ce.pdn.ac.lk

	.text 	@ instruction memory

@ Write YOUR CODE HERE	

@Corresponding C Code
@int mypow(int x, int n){
	@int counter;
	@int answer=1;

	@for(counter=1;counter<=n;counter++){
    @    answer *= x;}
    @return answer;}

@ ---------------------	
mypow:
	mov r2,#1 		@making r2(counter)=1
	mov r3,#1 		@making r3(answer)=1
	
for:
	cmp r2,r1		@comparing r2 with r1(n)
	bgt exit		@if r2>r1 loop should end.goto exit
	
	mul r12,r3,r0	@otherwise multiply r3(answer) by r0(x) & store it in r12
	mov r3,r12		@move make the r5(answer)=r12
	add r2,r2,#1	@increment counter by 1

	b for			@again goto start of the loop

exit:
	mov r0,r3		@return the answer to r0
	mov pc,lr		@return to the function call	
@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value x
	mov r5, #3 	@the value n
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl mypow
	mov r6,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	mov r3, r6
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "%d^%d is %d\n"

