; Program to accept a number between 0 and 9 and print all even numbers between 0 and that number
; Program by SIMSARUL HAQ VENGASSERI , B130461CS

;section .data is used to declare and initialize variables in the program

section .data
	message1 : db "Enter a number between 0 and 9 : ", 0Ah
	length1 : equ $-message1
        message2 : db 0Ah
	length2 : equ $-message2
        message3 : db "output: ", 0Ah
        length3 : equ $-message3

;section .bss is the part of the program used to declare variables without initialization

section .bss
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

	;read number from user
	mov eax , 3
	mov ebx , 0
	mov ecx , number
	mov edx , 2
	int 80h

        mov eax , 4
	mov ebx , 0
	mov ecx , message3
	mov edx , length3
	int 80h
  
	;storing the number in register eax

	movzx eax , byte[number]
	
	;loop to find even numbers

	even_number:
       
        jmp print

	;print

	print:
        
        mov al , byte[number]
        cmp al , 30h
        jb exit     
     
	mov bl , 2
	div bl
	cmp ah , 0
        jne label

	;printing even number
 
	mov eax , 4
	mov ebx , 1
	mov ecx , number
	mov edx , 1
	int 80h
   
        mov eax , 4
	mov ebx , 1
	mov ecx , message2
	mov edx , length2
        int 80h

        label:
        
        ;decrementing value of number

      	movzx eax , byte[number]
        dec byte[number]
        jmp even_number



	;system exit

	exit:	
	mov eax , 1
	mov ebx , 0
	int 80h
	
