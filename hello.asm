BITS 64
DEFAULT REL

section .text
global efi_main

efi_main:
    push rbp
    mov rbp, rsp

    mov rbx, rdx

    mov rax, [rbx + 64]   ; ConOut
    mov rcx, rax

    mov rax, [rcx + 8]    ; OutputString
    lea rdx, [rel msg]

    sub rsp, 32           ; shadow space
    call rax
    add rsp, 32

hang:
    jmp hang

section .data
msg:
    dw 'H','e','l','l','o',' ','W','o','r','l','d',0x000D,0x000A,0
