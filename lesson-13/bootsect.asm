[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ; The same one we used when linking the kernel

    mov [BOOT_DRIVE], d1 ; Remember that the BIOS sets us the boot drive in 'dl' on boot
    mov bp, 0x9000
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print
    call print_nl

    call load_kernel ; read the kernel from the disk
    call switch_to_pm ; disable interrupts, load GDT, etc. Finally jumps to 'BEGIN_PM;
    jmp $ ; Never executed

%include "../lesson-5/boot-sect-print.asm"
%include "../lesson-5/boot-sect-print-hex.asm"
%include "../lesson-7/boot-sect-disk.asm"
%include "../lesson-9/32bit-gdt.asm"
%include "../lesson-8/32bit-print.asm"
%include "../lesson-9/32bit-switch.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print
    call print_nl

    mov bx, KERNEL_OFFSET ; Read from the disk and store in 0x1000
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret


[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    call KERNEL_OFFSET ; Give control to the kernnel
    jmp $ ; Stay here whenn the kernel returns control to us (if ever)

BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0

; padding
times 510 - ($-$$) db 0
dw 0xaa55


