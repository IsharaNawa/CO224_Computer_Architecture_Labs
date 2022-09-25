@ ARM Assembly - exercise 6 
@ Group Number : 21

	.text 	@ instruction memory
	
	
@ Write YOUR CODE HERE
@int fact(int n){
	@int answer=1;
	@int counter;
	
	@for(counter=1;counter<=n;counter++){
		@answer *= counter;}
		
    @return answer;}
@according to register convention r1-r3 can be used as scatch registers
@ ---------------------	
fact:
	mov r1,#1 			@counter=1
	mov r2,#1			@answer=1

for:
	cmp r1,r0 			@compare counter(r1) with r0(n)
	bgt exit 			@exit if r1(counter)>r0(n)
	
	mul r3,r2,r1		@otherwise r3=answer*counter
	mov r2,r3			@make r2=r3

	add r1,r1,#1		@increment counter by 1
	b for				@goto start of the loop
	
exit:
	mov r0,r2 			@return the answer to r0
	mov pc,lr			@move the control flow to caller
	
@ ---------------------	

.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value n

	@ calling the fact function
	mov r0, r4 	@the arg1 load
	bl fact
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
format: .asciz "Factorial of %d is %d\n"

