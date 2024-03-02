        ; ----------------------------------------------------------------------------------------
        ; This is a Win64 console program that writes "Hello World" on one line and then exits.
        ; It uses puts from the C library. To assemble and run:

        ; $ nasm -f win64 test.asm -o test.obj && gcc test.obj -o test.exe && ./test.exe
        ; ----------------------------------------------------------------------------------------

        global  main
        extern  puts

        segment .bss                           ; Contains uninitialized global vars
RES:
        resd    0




        ; Data
        segment .data                          ; Contains initialized global vars
A:
        dd      3
B:
        dd      5

        section .text                          ; Contains instructions
main:
        mov     rbp, rsp                       ; For correct debugging
        sub     rsp, 28h                       ; Reserve the shadow space and align stack

        mov     rcx, hello                     ; First argument of puts() is address of hello
        call    puts                           ; puts(hello)

        mov     rcx, nfs
        call    puts



        mov     eax, [A]                       ; eax = A
        add     eax, [B]                       ; eax = eax + B
        mov     [RES], eax                     ; RES = eax
        mov     ebx, [RES]                     ; ebx = RES



        add     rsp, 28h                       ; Remove shadow space
        ret    


;; Strings
hello:
        db      "Hello World", 0               ; C strings need a zero byte at the end


nfs:
        db      "Need for Speed", 0
