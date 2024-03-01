# nasmfmt

Automatically format your assembly sources with a simple command.

Inspired by gofmt.

## What it does?

__In one example.__ This source:

```asm
global _start


section .text

   ;Starting point
_start:
mov rax,1 ;write(fd, buf, len)
mov rdi,1  ; fd
mov rsi, msg   ; buf
mov rdx,  msglen; len
  syscall

mov rax,60 ;exit(status)
mov rdi, 0
  syscall

section .data
msg    db "Hello world!",10
msglen equ $-msg
```

Would be formatted into:

```asm
        global _start

        section .text

; Starting point
_start:
        mov rax, 1                     ; write(fd, buf, len)
        mov rdi, 1                     ; fd
        mov rsi, msg                   ; buf
        mov rdx, msglen                ; len
        syscall

        mov rax, 60                    ; exit(status)
        mov rdi, 0
        syscall

        section .data
msg:
        db "Hello world!", 10
        msglen equ $-msg

```

## Features

* __Labels and instructions indentation.__
```asm
label:
add rax, rbx
```
Becomes:
```asm
label:
        add rax, rbx
```

* __Operands indentation.__
```asm
label:
add rax, rbx
```
Becomes:
```asm
label:
        add     rax, rbx
```

* __Comments indentation.__
```asm
   ; Start of the cycle
cycle:
        inc rcx ; Make it bigger
        jmp cycle ; Because why not?
                  ; Here's no cycle
```
Becomes:
```asm
; Start of the cycle
cycle:
        inc rcx                        ; Make it bigger
        jmp cycle                      ; Because why not?
; Here's no cycle
```

* __Consistent labels style.__
```asm
one_style: test rax, rbx
another_style:
        test rax, rbx

one_style:
        db "Message"
another_style db "Message"
```
Becomes:
```asm
one_style:
        test rax, rbx
another_style:
        test rax, rbx

one_style:
        db "Message"
another_style:
        db "Message"

```

* __Consistent commas style.__
```asm
        add rax,rbx
        add rax, rbx
        add rax,  rbx

```
Becomes:
```asm
        add rax, rbx
        add rax, rbx
        add rax, rbx
```

## Issues

There might be some issues since I have not tested it on all nasm functionality. 
Please, [report](https://github.com/yamnikov-oleg/nasmfmt/issues/new), if you found some.

_Would it work with other assemblers?_ May be, since most assembly syntaxes are similar.

## Usage

```
Usage: nasmfmt [params] [file1 [file2 ...]]
Parameters:
  -ci int
        Indentation for comments in spaces (default 40)
  -ii int
        Indentation for instructions in spaces (default 8)
  -oi int
        Indentation for operands in spaces (default 8)
```

Examples:
* `nasmfmt main.asm funcs1.asm funcs2.asm`
* `nasmfmt -ii 4 -oi 12 main.asm`
* `nasmfmt -ii 4 -ci 36 main.asm`

## Installing

Visit Releases to download a binary for your platform.

## Building

Building requires latest version of golang from [golang.org](https://golang.org/).

If you installed one, run `go build -o nasmfmt.exe main.go`.
