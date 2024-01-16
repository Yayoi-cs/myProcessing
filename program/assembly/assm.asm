section .text
   global _start
	
_start:
   mov rcx, 26
   mov rax, 'A'
	
l1:
   mov [num], al    ; ここでraxの下位8ビットをnumに移動

   ; write system call
   mov rax, 1
   mov rdi, 1
   mov rsi, num
   mov rdx, 1
   syscall

   ; increment al directly
   inc al

   ; loop
   loop l1

   ; exit system call
   mov eax, 60
   xor edi, edi
   syscall

section .bss
   num resb 1
