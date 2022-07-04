; assembler: converts low-level language to machine code
; BIOS: the program a computer's microprocessor uses to start the computer system after it is powered on 

; Infinite Loop (e9 fd ff)

loop:
    jmp loop

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55