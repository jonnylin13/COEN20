	.syntax   unified
  .cpu      cortex-m4
  .text     
  .thumb_func
  .align    2

	.global		Ten32
Ten32:
	// Use ldr to place the constant 10 in R0
	ldr		R0,=10
	bx		LR

	.global		Ten64
Ten64:
	ldr		R0,=10
	// Load empty bits into the next register for 64
	ldr		R1,=0 
	bx		LR

	.global		Incr
Incr:
	add		R0,R0,1
	bx		LR

	.global		Nested1
Nested1:
	// Call rand, add 1, return
	push		{LR}
	bl			rand
	add			R0,R0,1
	pop			{PC}

	.global		Nested2
Nested2:
	// Call rand
	push		{R4,LR}
	bl			rand
	// Store first rand in R4
	mov			R4,R0
	bl			rand
	// Add and return
	add			R0,R0,R4
	pop			{R4,PC}

	.global   PrintTwo
PrintTwo:
	// R0 holds the str
	// R1 holds the number
	push	{R2,R3,LR}


	// Store the input in R2 and R3
	mov		R2,R0
	mov		R3,R1

	// Call printf on R0, R1
	bl		printf

	// Move the str pointer back to R0
	mov		R0,R2
	// Add 1 to the number in R3 and store it in R1
	add		R1,R3,1

	bl		printf
	pop		{R2,R3,PC}






 