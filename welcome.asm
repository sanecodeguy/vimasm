 org 100h

section .data
    line1 db 0Dh, 0Ah, '__     ___              _                  $'
    line2 db 0Dh, 0Ah, '\ \   / (_)_ __ ___    / \   ___ _ __ ___  $'
    line3 db 0Dh, 0Ah, ' \ \ / /| | ,_ ` _ \  / _ \ / __| ,_ ` _ \ $'
    line4 db 0Dh, 0Ah, '  \ V / | | | | | | |/ ___ \\__ \ | | | | |$'
    line5 db 0Dh, 0Ah, '   \_/  |_|_| |_| |_/_/   \_\___/_| |_| |_|$'
    line6 db 0Dh, 0Ah, '$'
    
    contact db 'Contact: rizvihuihuihui@icloud.com$'
    github  db 'www.github.com/sanecodeguy/vimasm$'
    cmds    db 0Dh, 0Ah, 'Run inside Neovim:', 0Dh, 0Ah, ':Nc   (Compile + Run)', 0Dh, 0Ah, ':Nd   (Compile + Debug)$'

section .text
mov ax, 0x0003  ; Set 80x25 text mode (clears screen)
    int 10h
    mov ah, 09h
    
    ; Print VimAsm ASCII art
    mov dx, line1
    int 21h
    mov dx, line2
    int 21h
    mov dx, line3
    int 21h
    mov dx, line4
    int 21h
    mov dx, line5
    int 21h
    mov dx, line6
    int 21h
    
    ; Print contact info
    mov dx, contact
    int 21h
    
    ; Print github link
    mov dx, github
    int 21h
    
    ; Print commands
    mov dx, cmds
    int 21h
    
    ; Wait for key press
    mov ah, 00h
    int 16h
    
    ; Exit to DOS
    mov ax, 4C00h
    int 21h
