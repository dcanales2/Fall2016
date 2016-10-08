@Daniel

.global main
.func

main:

	@OUTPUT STRING
	LDR R1, address_return
	STR LR, [R1]
	LDR R0, address_string
	BL printf

	@GET 1st INPUT
	LDR R0, address_getNum
	LDR R1, address_read
	BL scanf

	@Output user number
	LDR R0, address_output
	LDR R1, address_read
	LDR R1, [R1]
	MOV R7, R1		@MOV first value into R7 to add later
	BL printf

	@Ask for second
	LDR R0, address_string2
	BL printf

	@Get second
	LDR R0, address_getNum
	LDR R1, address_read
	BL scanf	

	@Output 2nd number
	LDR R0, address_output
	LDR R1, address_read
	LDR R1, [R1]
	MOV R8, R1		@MOV R1->R8
	BL printf

	LDR R0, address_total
	LDR R1, address_read
	LDR R1, [R1]
	ADD R1, R1, R7
	BL printf

	@EXIT
	LDR LR, address_return
	LDR LR, [LR]
	BX LR

@Addresses
address_string: .word string
address_string2:.word string2
address_getNum: .word getNumber
address_output: .word output
address_return: .word return
address_read:   .word read
address_value:  .word value
address_total:  .word total

.data
string:    .asciz "Please enter your first number: \n "
string2:   .asciz "Please enter your second number: \n"
return:    .word 0
read:      .word 0
getNumber: .asciz "%d"
output:    .asciz "Your number was %d \n"
value:     .asciz "Your number is %d \n"
total:     .asciz "Total is : %d \n"

