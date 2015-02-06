; Program to construct multiplication table
; Program by SIMSARUL HAQ VENGASSERI , B130461CS

;section .data is used to give initializations and declarations

section .data
	message1: db "Enter a number: ", 0Ah
	length1: equ $-message1
	message2: db "The multiplication table is: ", 0Ah
	length2: equ $-message2
	message3: db " * "
	length3: equ $-message3
	message4: db " = "
	length4: equ $-message4
	message5: db 0Ah
	length5: equ $-message5

;section .bss is used for declaring without initialization

section .bss
	number: resb 1
	temp: resb 1
	result: resw 1
	digit1: resb 1
	digit2: resb 1
	digit3: resb 1
	digit4: resb 1

;section .text contain executable proogram

section .text
	global _start
	
	_start:
	;printing the first message
	mov eax , 4
	mov ebx , 1
	mov ecx , message1
	mov edx , length1
	int 80h

	;reading the number
	mov eax , 3
	mov ebx , 0
	mov ecx , number
	mov edx , 2
	int 80h
	
	sub byte[number] , 30h

	;printing the message 2

	mov eax , 4
	mov ebx , 1
	mov ecx , message2
	mov edx , length2
	int 80h

 	;temp stores 1	

	mov byte[temp] , 1
	mov cl , byte[temp]

	multiplication_table:

		;multiplying number with temp

		movzx ax , byte[number]
		mov cl , byte[temp]
		mul cl
		mov word[result] , ax

		;printing the number

		add byte[number] , 30h
		mov eax , 4
		mov ebx , 1
		mov ecx , number
		mov edx , 1
		int 80h
		sub byte[number] , 30h

		;printing * character

		mov eax , 4
		mov ebx , 1
		mov ecx , message3
		mov edx , length3
		int 80h

		;comparing 10 with temp

		cmp byte[temp] , 10
		je print

		;print decimal value of temp

		add byte[temp] , 30h
		mov eax , 4
		mov ebx , 1
		mov ecx , temp
		mov edx , 1
		int 80h

		sub byte[temp] , 30h
		jmp rest

	print:
		mov byte[digit3] , 30h
		mov byte[digit4] , 31h

                ;print 1

		mov eax , 4
		mov ebx , 1
		mov ecx , digit4
		mov edx , 1
		int 80h

		;print 0

		mov eax , 4
		mov ebx , 1
		mov ecx , digit3
		mov edx , 1
		int 80h

	rest:

		;print = symbol

		mov eax , 4
		mov ebx , 1
		mov ecx , message4
		mov edx , length4
		int 80h
		
		;print the result

		;divide result so that remainder goes to ah and qoutient goes to al

		mov ax , word[result]
		mov cl , 10
		div cl
		mov byte[digit1] , al
		mov byte[digit2] , ah
		add byte[digit1] , 30h
		add byte[digit2] , 30h

		;print digit1 qoutient

		mov eax , 4
		mov ebx , 1
		mov ecx , digit1
		mov edx , 1
		int 80h

		;print digit2 remainder 
		
		mov eax , 4
		mov ebx , 1
		mov ecx , digit2
		mov edx , 1
		int 80h

		;incrementing temp	

		add byte[temp] , 1
		mov cl , byte[temp]
		cmp cl , 10  ;determine length of table

                mov eax , 4
		mov ebx , 1
		mov ecx , message5
		mov edx , length5
		int 80h               
 
		jg exit

		;looping

		jmp multiplication_table

	;system exit

	exit:
		mov eax , 1
		mov ebx , 0
		int 80h

	
