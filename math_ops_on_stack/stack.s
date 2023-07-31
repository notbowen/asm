section .data
    digit db 0, 10  ; Allocate enough space to store 1 digit + newline

section .text
    global _start

_start:
    ; Showcases the LIFO behaviour of the stack
    push 5
    push 9
    push 6

    pop rax
    call _print_rax_digit

    pop rax
    call _print_rax_digit

    pop rax
    call _print_rax_digit

    ; sys_exit
    mov rax, 60
    xor rdi, rdi
    syscall

_print_rax_digit:
    add rax, "0"      ; Offset by ASCII position of "0", to get the ASCII value of the number
    mov [digit], al   ; Overwrite the first digit of digit

    ; sys_write
    mov rax, 1
    mov rdi, 1
    mov rsi, digit
    mov rdx, 2
    syscall

    ; return
    ret
