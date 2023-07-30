section .bss
    input_buffer resb 128

section .data
    output_msg db "Hello, what is your name? "
    output_len equ $ - output_msg

    greeting_msg db "Hello, "
    greeting_len equ $ - greeting_msg

    newline db 0x0A

section .text
    global _start

_start:
    %define SYS_READ 0
    %define SYS_WRITE 1
    %define SYS_EXIT 60

    %define STDOUT 1
    %define STDIN 0

    ; Write hello message to screen
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, output_msg
    mov rdx, output_len
    syscall

    ; Get user input
    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, input_buffer
    mov rdx, 128
    syscall

    ; Clear rcx to use as counter
    xor rcx, rcx

.loop:
    cmp byte[rsi + rcx], 0
    je .found_null_terminator
    inc rcx
    cmp rcx, 128
    jge .found_null_terminator
    jmp .loop

.found_null_terminator:
    mov r8, rcx

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, greeting_msg
    mov rdx, greeting_len
    syscall

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, input_buffer
    mov rdx, r8
    syscall

    ; Print newline
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, newline
    mov rdx, 1
    syscall

    xor rdi, rdi  ; Set rdi to 0 (for exit code 0)
    mov rax, SYS_EXIT
    syscall


