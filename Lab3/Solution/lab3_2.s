@ ARM Assembly - lab 3.2 
@ Group Number : 21

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	
@ ---------------------	
@Corresponding C Code
@int gcd(int a(r0), int b(r1)){
	@if(b==0){return a;}
    @else{
		@int c=remainder(a,b);
        @a=b;
        @b=c;
        @return gcd(a,b);}}
		
gcd:
	sub		sp,sp,#4 		@making the stack for one item
	str		lr,[sp,#0]		@storing lr on the stack
	cmp		r1,#0 			@comparing b(r1) with 0
	bne		else			@goto else if b!=0
	
	add		sp,sp,#4		@pop 1 items to the stack
	mov		pc,lr			@return to the previous call
	
else:
	bl		remainder; 		@call the remainder function
	mov		r3,r0; 			@copy the r0(a%b) to r3
	mov		r0,r1			@make a=b
	mov		r1,r3			@make b=a%b
	bl		gcd				@call the funtion bcd for new values
	ldr		lr,[sp,#0]		@load lr from the stack
	add		sp,sp,#4		@pop 1 item to the stack
	mov		pc,lr			@return to the function call

@Corresponding C code
@int remainder(int a,int b){
	@int answer=0;
    @while(a>=answer){
		@answer += b;}
	@answer-= b;
    @return a-answer;}
	
remainder:		
	mov		r12,#0; 		@making r4(output)=0
	
while:
	cmp		r0,r12; 		@comparing r0(a) with r4(answer)
	blt		exit; 			@if(a<answer) goto exit of the loop		
	add		r12,r12,r1; 	@if not answer += b
	b		while			@goto the start of the while loop
	
exit:
	sub		r12,r12,r1; 	@making answer -= b
	sub		r0,r0,r12; 		@return the output to r0
	mov		pc,lr			@return to the previous function call

@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #64 	@the value a
	mov r5, #24 	@the value b
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl gcd
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
format: .asciz "gcd(%d,%d) = %d\n"

