global add

section .text

add:
    push  ebp
    mov   ebp, esp
    mov   eax, [ebp+8]      ; argument 1 offset by 4 bytes (size of interger), first 4 bytes current instruction
    add   eax, [ebp+12]      ; argument 2 offset by 4 bytes (size of interger)
    add   eax, [ebp+16]     ; third argument
    pop ebp
    ret
