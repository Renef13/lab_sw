section .bss
    num1 resb 5          ; espaço para o primeiro número (até 4 dígitos + terminador nulo)
    num2 resb 5          ; espaço para o segundo número (até 4 dígitos + terminador nulo)
    result resb 10       ; espaço para o resultado (até 9 dígitos + terminador nulo)

section .data
    prompt1 db "Primeiro numero: ", 0
    prompt2 db "Segundo numero: ", 0
    result_msg db "O resultado e: ", 0
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

    ; Converter primeiro número para inteiro
    mov ecx, num1
    call atoi
    mov esi, eax        ; armazenar o valor convertido em esi

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

    ; Converter segundo número para inteiro
    mov ecx, num2
    call atoi
    add eax, esi        ; somar os dois números

    ; Converter resultado para string
    mov ecx, result
    call itoa

    ; Exibir resultado
    mov eax, 4          ; syscall número de escrita (sys_write)
    mov ebx, 1          ; file descriptor 1 é stdout
    mov ecx, result_msg ; mensagem a ser escrita
    mov edx, 16         ; comprimento da mensagem
    int 0x80            ; chamada do kernel

    ; Escrever resultado
    mov eax, 4          ; syscall número de escrita (sys_write)
    mov ebx, 1          ; file descriptor 1 é stdout
    mov ecx, result     ; resultado
    mov edx, 10         ; comprimento do resultado (até 9 dígitos)
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

atoi:
    ; Converte string em ecx para inteiro em eax
    xor eax, eax        ; limpar eax
    xor ebx, ebx        ; limpar ebx
atoi_loop:
    mov bl, byte [ecx]  ; obter o próximo byte
    cmp bl, 10          ; verificar se é newline
    je atoi_done        ; se for, sair do loop
    cmp bl, 0           ; verificar se é o terminador nulo
    je atoi_done        ; se for, sair do loop
    sub bl, '0'         ; converter de caractere ASCII para valor numérico
    imul eax, eax, 10   ; multiplicar eax por 10
    add eax, ebx        ; adicionar o dígito atual
    inc ecx             ; avançar para o próximo caractere
    jmp atoi_loop       ; repetir o loop
atoi_done:
    ret

itoa:
    ; Converte inteiro em eax para string em ecx
    mov ebx, 10         ; divisor para obter os dígitos
    mov edi, ecx        ; armazenar o endereço base do resultado
    add ecx, 9          ; definir um limite superior para a string
    mov byte [ecx], 0   ; adicionar terminador nulo
itoa_loop:
    dec ecx             ; mover o ponteiro da string para trás
    xor edx, edx        ; limpar edx
    div ebx             ; dividir eax por 10
    add dl, '0'         ; converter dígito para caractere ASCII
    mov [ecx], dl       ; armazenar o dígito na string
    test eax, eax       ; verificar se eax é 0
    jnz itoa_loop       ; se não for, repetir o loop
    mov eax, edi        ; armazenar o endereço base do resultado em eax
    ret

