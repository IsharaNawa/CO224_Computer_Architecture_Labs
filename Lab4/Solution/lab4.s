@ ARM Assembly Lab 4
@ Group No:21
@string reverse arm code
	.text	@ instruction memory
	.global main

main:
	@ push  lr to the stack
	sub	sp, sp, #4;
	str	lr, [sp, #0];
	
	sub	sp, sp, #4;		@allocating stack for storing the number of strings
	ldr	r0, =format1;	@printing for getting the number of strings 
	bl	printf			@calling printf function
	
	ldr	r0, =format2;	@scannig for getting the number of strings
	mov	r1, sp;			@moving stack to the r1 to call scanf
	bl	scanf;			@calling scanf("%s",sp)
	
    ldr	r4, [sp,#0];	@storing number of strings in r4
	add	sp, sp, #4;		@releasing stack

    cmp r4 , #0; 		@Compare r4(number of strings) with 0
    beq exit; 			@exit if equal
    blt invalid; 		@print invalid message if negative
	
	mov r6 , #1; 		@storing string number in r6
	
loop1:
		
	sub	sp, sp, #200	@allocate stack for string
	ldr	r0, =format3	@loading printf message to r0
	mov r1 , r6			@moving string number to r1 
	bl	printf			@calling printf function
	
	ldr	r0, =format4	@loading formatting string to r0
	mov	r1, sp			@moving stack to r1
	bl	scanf			@calling scanf("%s",sp)

	mov r0 , sp			@moving stack to r0					
	bl	strlen			@calling strlen function 
		
	sub r5 , r1 , #1  	@r5 = r1 - 1

loop2: 
		
	add r2 , r5 , sp 	@r2 = r5 + sp
	ldrb	r1, [r2, #0] @r1 contains the character which is in address in r2
		
	ldr	r0, =format5 	@ printf for character
	bl	printf			@ calling printf function

	sub r5 , r5 , #1 	@ r5 decrement by 1
	cmp r5 , #0 		@ Compare r5 with 0
	bge loop2 			@ if r5 >= 0 then goto loop2

	ldr	r0, =format6	@ printf for new line
	bl	printf			@ calling printf function
		
	add	sp, sp, #200	@releasing the stack (input)

	add r6 , r6 , #1	@incrementing number of strings by 1
	cmp r6 , r4  		@compare it with r4(contains number of strings from the user)
	ble loop1 			@if r3 less or equal to r4 then go to loop1

    b exit				@otherwise goto exit

strlen:
	
	sub	sp, sp, #4		@ Allocate stack for lr
	str	lr, [sp, #0]	@storing link register in the stack
	mov	r1, #0			@ length counter

loop:

	ldrb r2, [r0, #0]	@loading r0 to r2
	cmp	r2, #0			@if r2=='\0'
	beq	exit			@exit the loop

	add	r1, r1,#1		@otherwise increase length by 1
	add	r0, r0, #1		@move to the next char in the string
	b	loop			@goto loop

invalid:
    ldr	r0, =format7	@loading the invalid number message to r0
	bl	printf			@calling printf function

exit:
    
    ldr	lr, [sp, #0]	@pop lr to the stack
	add	sp, sp, #4		@release stack
	mov	pc, lr			@return to the fuction call

	.data	@ data memory
format1: .asciz "Enter the number of strings :\n"
format2: .asciz "%d"
format3: .asciz "Enter input string %d:\n"
format4: .asciz " %[^\n]s"
format5: .asciz "%c"
format6: .asciz "\n"
format7: .asciz "Invalid Number\n"




