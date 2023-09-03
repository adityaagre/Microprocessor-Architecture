section .data
    
    msg1 db "Enter String",10
    msg1_l equ $-msg1
    
    msg2 db "String Length",10
    msg2_l equ $-msg2
    
section .bss
    
    string resb 50
    string_l equ $-string
    
    count resb 1
    
    char_ans resb 2
    
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
    Read string, string_l
    
    mov [count], rax
    
    Print msg2, msg2_l
    mov rax, [count]
    
    call Display 
    
    exit
    
Display:
    mov rbx, 16
    mov rcx, 2 
    mov rsi, char_ans+1 
    
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
    
    
    
    Print char_ans, 2 
    
    ret