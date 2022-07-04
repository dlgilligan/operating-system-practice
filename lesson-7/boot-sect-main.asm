; hard disk: non volatile data storage device
; cylinder: a cylindrical intersection through the stack of platters in a disk, centered around the disk's spindle
; head: a device on the arm of a hard drive used to read and write data on the disk platter
; sector: a subdivision of a track on a magnetic disk
; carry bit: an extra bit present on each register which stores when an operation has overflowed its current capacity:



[org 0x7c00]
    mov bp, 0x8000 ; set the stack safely away from us
    mov sp, bp ;stack is empty so top of stack points to bottom

    mov bx, 0x9000 ; es:bx = 0x0000:0x9000 = 0x09000
    mov dh, 2 ; read 2 sectors
    ; the bios sets 'dl' for our boot disk number
    ; if you have trouble, use the '-fda' flag: 'qemu -fda file.bin'
    call disk_load

    mov dx, [0x9000] ; retrieve the first loaded word, 0xdada
    call print_hex

    call print_nl

    mov dx, [0x9000 + 512] ; first word from second loaded sector, 0xface
    call print_hex

    jmp $

%include "../lesson-5/boot-sect-print.asm"
%include "../lesson-5/boot-sect-print-hex.asm"
%include "boot-sect-disk.asm"

; Magic number
times 510 - ($-$$) db 0
dw 0xaa55

; boot sector = sector 1 of cyl 0 of head 0 of hdd 0
; from now on = sector 2 ...
times 256 dw 0xdada ; sector 2 = 512 bytes
times 256 dw 0xface ; sector 3 = 512 bytes