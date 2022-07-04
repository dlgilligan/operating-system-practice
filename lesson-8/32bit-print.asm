; 32-bit protected mode: 32-bit mode allows us to use 32 bit registers and memory addressing, protected memory, 
; virtual memory and other advantages, but we will lose BIOS interrupts
;
; VGA : an analog interface between computer and monitor
; Video Memory : any type of random access memory (RAM) specifically used to store image data for a computer display

[bits 32] ; using 32-bit protected mode

; this is how constants are defined
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f ; the color byte for each character

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx] ; [ebx] is the address of our character
    mov ah, WHITE_ON_BLACK

    cmp al, 0 ; check if end of string
    je print_string_pm_done

    mov [edx], ax ; store character + attribute in video memory
    add ebx, 1 ; next char
    add edx, 2 ; next video memory position

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret