section .bss
    num1 resb 4
    num2 resb 4
    result resb 8

section .data
    prompt1 db 'Enter first number: ', 0
    prompt2 db 'Enter second number: ', 0
    res_msg db 'Result: ', 0

section .text
    global _start

_start:
    ; Print prompt1
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt1
    mov edx, 19
    int 0x80

    ; Read first number
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 4
    int 0x80

    ; Convert first number from string to integer
    mov eax, [num1]
    sub eax, '0'
    mov [num1], eax

    ; Print prompt2
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, 20
    int 0x80

    ; Read second number
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 4
    int 0x80

    ; Convert second number from string to integer
    mov eax, [num2]
    sub eax, '0'
    mov [num2], eax

    ; Add numbers
    mov eax, [num1]
    add eax, [num2]
    add eax, '0'
    mov [result], eax

    ; Print result message
    mov eax, 4
    mov ebx, 1
    mov ecx, res_msg
    mov edx, 8
    int 0x80

    ; Print result
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 4
    int 0x80

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80
