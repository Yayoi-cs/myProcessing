section .text
    global _start
_start:
    mov eax,1
    add eax,2
    mov ecx,eax
    mov eax,4
    mov ebx,1
    mov edx,1
    int 0x80
    mov eax,1
    xor ebx,ebx
    int 0x80
