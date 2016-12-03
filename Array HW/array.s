// non updating indexing mode with: [Rsource1, +Rsource2, LSL #immediate]
// this is indexing by Rsource1+(Rsource2 << #immediate)


.text
.balign 4
.global main
.func
main:
	push {LR}
	
	@let's populate our array a of 100 bytes (25 words - 4 bytes to a word)
	LDR  R9, =a 	@Points to begining of array -> a[0]
	MOV  R2, #0	@NUMBER R1[R3] = R2
	MOV  R3, #0
	MOV  R8, #0	@Total Rainfall
a_loop: 
	
	CMP  R3, #12 		@ R3 = 10?
	BEQ  a_done 		@ If yes goto done else continue

	
/*
input:
	LDR R0, =getNum
	BL printf

	LDR R0, =scan
	LDR R1, =value_read
	BL scanf

	@Output
	LDR R0, =outNum
	LDR R1, =value_read
	LDR R1, [R1]
	MOV R2, R1
	BL printf

	BAL aloop_cont
	
*/
aloop_cont:
	STRB R2, [R9, +R3]	@ a[#] = R2  # ----------store content of R2 at [r1+r2]	
	ADD  R2, #3		@R2 will be user number	
	ADD  R3, #1		@ R3 + 1

	BAL  a_loop		@ jump back up to start of loop

a_done:
	@ let's output all of the elements of the array with a function named
	@ output_array(int a[], int size)
	@ R0 = pointer to start of array, R1=size or # of elements in the array
	
	LDR R0, =a		@ R0 contains base address of array
	MOV R1, #12		@ R1 contains number of elements in the array
	
	BL output_array
	POP {pc}

output_array:

	PUSH {R4,R5,LR}
	MOV  R4, #0		@ R4 contains starting index for output

oa_loop:
	
	CMP R4, R1		@ Is R4 equal to the number of elements to output?
	BEQ  division		
	PUSH {r0-R3}		@ Save our current state of registers R0-R3 since printf won't

	LDRB R2, [R0,+R4]	@ R1 contains a[R0+R4]
	MOV R1, R4		@ output our index as well
	ADD R8, R8, R2	

	LDR R0, =output_str 	@ R0 contains pointer to our output string
	BL printf
	
	POP {r0-r3}		@ Restore state of registers R0-R3 after printf call
	ADD R4, #1		@ increment our index by 1
	BAL oa_loop		@ jump back up to oa_loop for next element

oa_done:
	MOV R1, R8
	LDR R0, =output_avg
	BL printf

	POP {r4,r5,pc}


division:
	@R8 is total Numerator
	@R1 is 12    Deno
	MOV R11, #0  @increment counter
	MOV R0, R8

compare:
	CMP R8, R1
	BLT output

	ADD R11, R11, #1
	SUB R8, R8, R1
	BAL compare
output:
	MOV R1, R11
	LDR R0, =output_avg
	BL printf

	POP {R4,R5,PC}



@Address
address_getNum: .word getNum
address_scan:   .word scan


.data
.balign 4

a: .skip 100 // array of 100 bytes (this just reserves us 100 bytes of space, no initialization done
b: .word -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1

// data label for output_array function
output_str: .asciz "Rainfall Month[%d]=%d\n"
output_avg: .asciz "Average rainfall was %d \n"
getNum:     .asciz "Please enter the rainfall \n"
scan:	    .asciz "%d"
value_read: .word 0
outNum:     .asciz "Number entered was %d\n"

@Globals
.global printf
.global scanf




