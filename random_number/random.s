section .data
    random_size equ 8

section .bss
    random_number resq 1

section .text
    global _start

_start:
    call random_number_generator

    mov rdi, random_number
    call print_uint64

    mov eax, 60
    xor edi, edi
    syscall

random_number_generator:
    rdseed rax
    mov [random_number], rax
    ret

print_uint64:
    push rax
    mov rax, 1
    mov rsi, rdi
    mov rdx, random_size
    mov rdi, 1
    syscall

    pop rax
    ret

