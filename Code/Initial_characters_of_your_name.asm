                           title Initial characters of ful namae

                  ; This program show the initial characters of your full name.

.model small

.stack 100h

.data

    msg1 db "Enter the initial characters of your full name: ",'$'
    msg2 db "Initial characters of your name are given below.",'$'

.code

main proc
    
    mov ax, @data
    mov ds, ax
    
    
    
    ;Display input prompt
    
    mov dl, offset msg1
    mov ah, 09h
    int 21h

    ;Take initial character of ser first name from the user
    
    mov ah, 01h
    int 21h

    ;Save initial character of the user first name
    
    mov bl, al
    
    ;Take initial character of user last name from the user
    
    mov ah, 01h
    int 21h
    
    ;Save initial character of the user last name
    
    mov cl, al
    
    ;Function for new line
    
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h
    
    ;Print output prompt
    
    mov dx, offset msg2
    mov ah, 09h
    int 21h
    
    ;Function for new line
    
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h
    
    ;Display initial character of the user first name
    
    mov dl, bl
    mov ah, 02h
    int 21h
    
    ;Function for new line
    
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h
    
    ;initial character of the user last name
    
    mov dl, cl
    mov ah, 02h
    int 21h
    
    
    
    mov ah, 4Ch
    int 21h

main endp
end main
