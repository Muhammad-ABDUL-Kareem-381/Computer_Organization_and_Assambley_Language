
.model small
.stack 100h

.data
    char db 80h


.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 02h
    
    
    print:  
    mov dl, char
    int 21h
    add char, 01h
    cmp char, 0ffh
    JBE print
    
    mov ah, 4ch
    int 21h
    
main endp
end main
        