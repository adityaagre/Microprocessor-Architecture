section .data
    
    msg1 db "Number of positive numbers", 10
    msg1_len equ $-msg1
    
    msg2 db "Number of negative numbers", 10
    msg2_len equ $-msg2
    
    arr64 dq 07H, 12H, 13H, -01H, -06H
    arr64_len equ 5
    
    
    
section .bss

    p_count resq 1 
    n_count resq 1 
    
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
    
    mov rsi, arr64 
    
    mov rcx, arr64_len
    
    mov rbx, 0 ; neg
    mov rdx, 0 ; pos
    
    label1:
    mov rax, [rsi]
    
    shl rax, 1 
    jc negative
    
    positive:
    inc rdx
    jmp next_num
    
    negative:
    inc rbx

    
    
    
    next_num:
    add rsi, 8
    dec rcx
    jnz label1
    
    mov [n_count], rbx
    mov [p_count], rdx
    
    Print msg1, msg1_len
    mov rax, [p_count]
    call display
    
    Print msg2, msg2_len
    mov rax, [n_count]
    call display
    
    
        
    
    
    
    











display:
    mov rbx, 16
    mov rcx, 2 
    mov rsi, char_ans+1 
    
    cnt: mov rdx, 0 
    div rbx
    
    cmp dl, 09H
    jbe add30
    add dl, 07H 
    
    add30: add dl, 30H
    
    mov [rsi], dl
    dec rsi
    
    dec rcx
    jnz cnt
    
    Print char_ans, 2 
    ret
    
    
    
    
    
    
    

    
    
    
    
    
    