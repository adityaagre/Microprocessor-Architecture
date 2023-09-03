section .data 
msg1 db 10,13, "Enter the five 64 bit numbers: "
len1 equ $-msg1
msg2 db 10,13, "Entered five 64 bit numbers: "
len2 equ $-msg2

section .bss
array resd 200
counter resb 1

%macro print 2
mov rax,1
mov rdi,1
mov rsi, %1
mov rdx, %2
syscall
%endmacro

section .text
    global _start
    _start:
    
    print msg1,len1
    
    ;accepting
    mov byte[counter], 05
    mov rbx,0
    loop1:
    mov rax,0
    mov rdi,0
    mov rsi,array
    add rsi,rbx
    mov rdx,17
    syscall
    add rbx,17
    dec byte[counter]
    jnz loop1
    
    print msg2,len2
    
    ;accepting
    mov byte[counter], 05
    mov rbx,0
    loop2:
    mov rax,1
    mov rdi,1
    mov rsi,array
    add rsi,rbx
    mov rdx,17
    syscall
    add rbx,17
    dec byte[counter]
    jnz loop2