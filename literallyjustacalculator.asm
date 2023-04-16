; nasm -f elf32 literallyjustacalculator.asm
; ld -m elf_i386 -o literallyjustacalculator literallyjustacalculator.o
; ./literallyjustacalculator

; x86

section .data
    prompt1 db 'Enter first number: '
    prompt1_len equ $ - prompt1
    prompt2 db 'Enter second number: '
    prompt2_len equ $ - prompt2
    prompt3 db 'Enter operation (+, -, *, /): '
    prompt3_len equ $ - prompt3

section .bss
    num1 resb 4
    num2 resb 4
    op resb 1

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    lea ecx, [prompt1]
    mov edx, prompt1_len
    int 0x80

    mov eax, 3
    mov ebx, 0
    lea ecx, [num1]
    mov edx, 4
    int 0x80

    mov eax, 4
    mov ebx, 1
    lea ecx, [prompt2]
    mov edx, prompt2_len
    int 0x80

    mov eax, 3
    mov ebx, 0
    lea ecx, [num2]
    mov edx, 4
    int 0x80

    mov eax, 4
    mov ebx, 1
    lea ecx, [prompt3]
    mov edx, prompt3_len
    int 0x80

    mov eax, 3
    mov ebx, 0
    lea ecx, [op]
    mov edx, 1
    int 0x80

    mov eax, [num1]
    mov ebx, [num2]
    cmp byte [op], '+'
    je add
    cmp byte [op], '-'
    je sub
    cmp byte [op], '*'
    je mul
    cmp byte [op], '/'
    je div

add:
    add eax, ebx
    jmp print_result
sub:
    sub eax, ebx
    jmp print_result
mul:
    imul eax, ebx
    jmp print_result
div:
    cdq
    idiv ebx

print_result:

    mov ecx, eax
    mov edx, 1
    int 0x80


    mov eax, 1
    xor ebx, ebx
    int 0x80
