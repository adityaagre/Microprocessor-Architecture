section .data
    
    msg1 db "Enter BCD",10
    msg1_l equ $-msg1
    
    msg2 db "Hex number",10
    msg2_l equ $-msg2
    
section .bss
    
    buf resb 6 

    
    char_ans resb 4
    
    
%macro Print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2 
    syscall
%endmacro

%macro Read 2
    mov rax, 0 
    mov rdi, 0 
    mov rsi, %1
    mov rdx, %2 
    syscall
%endmacro

%macro exit 0 
    mov rax, 60
    mov rdi, 0 
    syscall
%endmacro


section .text

    global _start
    _start:
    
    Print msg1, msg1_l
    call hex_bcd
   
    
    
    exit
    
    
    
    
hex_bcd:
    
    Read buf, 6
    
    mov rsi, buf
    xor rax,rax
    
    mov rbp, 5
    mov rbx, 10
    
    next:
    xor cx,cx
    mul rbx
    mov cl, [rsi]
    sub cl, 30h
    add ax,cx
    
    inc rsi
    dec rbp
    jnz next
    
    call Display






Display:
    mov rbx, 16
    mov rcx, 4
    mov rsi, char_ans+3
    
    cnt:mov rdx, 0 
    
    div rbx
    
    cmp dl, 09h
    jbe add30
    add dl, 07h
    
    add30:
    add dl, 30h
    
    mov [rsi], dl
    dec rsi
    
    dec rcx
    jnz cnt
    
    
    
    Print char_ans, 4
    
    ret