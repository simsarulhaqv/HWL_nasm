;Program to read a key stroke and report whether it is a alphanumeric,alpahabetic, or a special key
;Program by SIMSARUL HAQ VENGASSERI, B130461CS.


;section.data used to declare and initialize the variables in a program

section .data
	message1 : db "Enter a key stroke",0Ah
        length1 : equ $-message1
	message2 :db "Alphanumeric",0Ah
        length2 : equ $-message2
	message3 : db "Alphabetic",0Ah
	length3 : equ $-message3
	message4 : db "Special Key",0Ah
	length4 : equ $-message4

;section.bss is the part of a program used to declare variables without initialization

section .bss
	key_stroke : resb 1

;section.text is the part of the program which contains the executable code

section .text
	global _start:
	_start:

	;print the message to enter a key stroke

	mov eax , 4
	mov ebx , 1
	mov ecx , message1
	mov edx , length1
	int 80h

	;reading a key stroke

	mov eax , 3
	mov ebx , 0
	mov ecx , key_stroke
	mov edx , 2
	int 80h

	;MOVZX is used to copy and exxtend variable from a lower spaced memory / register location to a higher one
        
	movzx eax , byte[key_stroke] ;mov key_stroke to eax

	;checking whether it is number

	cmp eax , '0'   
	setnc bl        ; eax>=0?1:0
	cmp eax , '9'+1
	setc bh         ; eax<=9?1:0
	and bl , bh

	cmp bl , 1
	je Alphanumeric
	jmp uppercase_alphabet

	movzx eax , byte[key_stroke]
	uppercase_alphabet: ;to check if it is a uppercase alphabet

	cmp eax , 'A'
	setnc bl
	cmp eax , 'Z' + 1
	setc bh
	and bl , bh

	;bl contains 1 if eax contains an uppercase letter, and bl contains 0 if eax contain anything else

	cmp bl , 1
	je Alphabetic

	;to check whether the key stroke is a lowercase alphabet

	movzx eax , byte[key_stroke]
	cmp eax , 'a'
	setnc bl
	cmp eax , 'z'+1
	setc bh
	and bl , bh

	;bl contains 1 if eax contains a lowercase letter, and bl contains 0 if eax contain anything else

	cmp bl , 1
	je Alphabetic
	jmp specialkey

        ;sub program Alphabetic

	Alphabetic:
	mov eax , 4
	mov ebx , 1
	mov ecx , message3
	mov edx , length3
	int 80h

	;sub program Alphanumeric

	jmp Alphanumeric

	Alphanumeric:
	mov eax , 4
	mov ebx , 1
	mov ecx , message2
	mov edx , length2
	int 80h
	jmp exit

	;sub program special key

	specialkey:
	mov eax , 4
	mov ebx , 1
	mov ecx , message4
	mov edx , length4
	int 80h

	;sub program exit

	exit:
	mov eax , 1
	mov ebx , 0
	int 80h


