section	.text
   global _start
_start:
   mov rcx,26
   mov rax, 'A'
l1:
   mov [num], rax
   mov rax, 4
   mov rbx, 1
   push rcx
   mov rcx, num
   mov rdx, 1
   int 0x80
   mov rax, [num]
   sub rax, '0'
   inc rax
   add rax, '0'
   pop rcx
   loop l1
   mov eax,1
   int 0x80
section	.bss
num resb 1