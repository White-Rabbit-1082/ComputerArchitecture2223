global sub

section .text

sub:
    push ebp
    mov ebp, esp
    mov eax, [ebp+8] ;first argument
    sub eax, [ebp+12] ; second argument
    pop ebp
    ret
