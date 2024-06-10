section .bss
    num1 resb 5          ; espaço para o primeiro número (até 4 dígitos + terminador nulo)
    num2 resb 5          ; espaço para o segundo número (até 4 dígitos + terminador nulo)

section .data
    prompt1 db "Primeiro numero: ", 0
    prompt2 db "Segundo numero: ", 0
    result db "Os numero sao: ", 0
    newline db 10, 0     ; newline character

section .text
    global _start

_start:
    ; Primeiro número
    mov eax, 4          ; syscall número de escrita (sys_write)
    mov ebx, 1          ; file descriptor 1 é stdout
    mov ecx, prompt1    ; mensagem a ser escrita
    mov edx, 17         ; comprimento da mensagem
    int 0x80            ; chamada do kernel

    ; Ler primeiro número
    mov eax, 3          ; syscall número de leitura (sys_read)
    mov ebx, 0          ; file descriptor 0 é stdin
    mov ecx, num1       ; buffer onde o número será armazenado
    mov edx, 5          ; ler até 4 bytes
    int 0x80            ; chamada do kernel
    mov byte [num1+4], 0 ; garantir terminador nulo

    ; Segundo número
    mov eax, 4          ; syscall número de escrita (sys_write)
    mov ebx, 1          ; file descriptor 1 é stdout
    mov ecx, prompt2    ; mensagem a ser escrita
    mov edx, 16         ; comprimento da mensagem
    int 0x80            ; chamada do kernel

    ; Ler segundo número
    mov eax, 3          ; syscall número de leitura (sys_read)
    mov ebx, 0          ; file descriptor 0 é stdin
    mov ecx, num2       ; buffer onde o número será armazenado
    mov edx, 5          ; ler até 4 bytes
    int 0x80            ; chamada do kernel
    mov byte [num2+4], 0 ; garantir terminador nulo

    ; Exibir resultados
    mov eax, 4          ; syscall número de escrita (sys_write)
    mov ebx, 1          ; file descriptor 1 é stdout
    mov ecx, result     ; mensagem a ser escrita
    mov edx, 17         ; comprimento da mensagem
    int 0x80            ; chamada do kernel

    ; Escrever primeiro número
    mov eax, 4          ; syscall número de escrita (sys_write)
    mov ebx, 1          ; file descriptor 1 é stdout
    mov ecx, num1       ; primeiro número
    mov edx, 4          ; comprimento do número (até 4 dígitos)
    int 0x80            ; chamada do kernel

    ; Escrever newline
    mov eax, 4          ; syscall número de escrita (sys_write)
    mov ebx, 1          ; file descriptor 1 é stdout
    mov ecx, newline    ; newline character
    mov edx, 1          ; comprimento do newline
    int 0x80            ; chamada do kernel

    ; Escrever segundo número
    mov eax, 4          ; syscall número de escrita (sys_write)
    mov ebx, 1          ; file descriptor 1 é stdout
    mov ecx, num2       ; segundo número
    mov edx, 4          ; comprimento do número (até 4 dígitos)
    int 0x80            ; chamada do kernel

    ; Escrever newline
    mov eax, 4          ; syscall número de escrita (sys_write)
    mov ebx, 1          ; file descriptor 1 é stdout
    mov ecx, newline    ; newline character
    mov edx, 1          ; comprimento do newline
    int 0x80            ; chamada do kernel

    ; Sair do programa
    mov eax, 1          ; syscall número de saída (sys_exit)
    xor ebx, ebx        ; código de saída 0
    int 0x80            ; chamada do kernel
