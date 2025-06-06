                           title Lowercase to Uppercase (convert.asm)

                  ; This program converts a lowercase letter to uppercase.

.model small

.stack 100h

.data

    msg1 db "Enter Lowercase letter: ",'$'
    msg2 db "Uppercase letter is: ",'$'

.code

main proc
    
    mov ax, @data
    mov ds, ax

    ; Display input prompt
    
    mov dl, offset msg1
    mov ah, 09h
    int 21h

    ; Take lowercase letter input from the user
    
    mov ah, 01h
    int 21h

    ; Convert to uppercase
     
    sub al, 20h

    ; Save output
    
    mov bl, al
    
    ; Function for new line
    
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h
    
    
    ; Print output prompt
    
    mov dx, offset msg2
    mov ah, 09h
    int 21h

    ; Display uppercase letter
    
    mov dl, bl
    mov ah, 02h
    int 21h

    mov ah, 4Ch
    int 21h

main endp
end main
