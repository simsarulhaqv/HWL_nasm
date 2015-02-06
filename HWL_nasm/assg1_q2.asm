; Program to accept a number and print whether it is even or odd
; Program by SIMSARUL HAQ VENGASSERI , B130461CS

;section .data is used to declare and initialize variables in the program

section .data
	message1 : db "Enter a number: ", 0Ah
	length1 : equ $-message1
	message2 : db "Even number",0Ah
	length2 : equ $-message2
	message3 : db "Odd number",0Ah
	length3 : equ $-message3

;section .bss is the part of the program used to declare variables without initialization

section .bss
        temp : resb 1
	number : resb 1

;section .text contain executable code of the program

section .text
	global _start:

	_start:
	mov eax , 4
	mov ebx , 1
	mov ecx , message1
	mov edx , length1
	int 80h

        read_number:

	;read number from user
	mov eax , 3
	mov ebx , 0
	mov ecx , temp
	mov edx , 1
	int 80h 

	;checking if enter key is pressed

	cmp byte[temp] , 10
	
	;loop exit condition
	
	je end_read

	;storing temp in number

	mov al , byte[temp]
	mov byte[number] , al

	;loop to read number again
	
	jmp read_number

	end_read:
     
	;checking divisibility with 2

	movzx ax , byte[number]

	mov bl , 2
	div bl
	cmp ah , 0
	jne odd

	mov eax , 4
	mov ebx , 1
	mov ecx , message2
	mov edx , length2
	int 80h
	
	mov eax , 1
	mov ebx , 0
	int 80h

	odd:
 
	mov eax , 4
	mov ebx , 1
	mov ecx , message3
	mov edx , length3
	int 80h

	mov eax , 1
	mov ebx , 0
	int 80h

