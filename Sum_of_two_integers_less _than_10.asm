                           title Sum of two numbers less than 10

                  ; This program show the initial characters of your full name.

.model small

.stack 100h

.data

    msg1 db "Enter first number: ",'$'
    msg2 db "Enter second number: ",'$'
    msg3 db "The Sum is: ",'$'
    ;eMsg db "Error: Sum must be less than 10!",'$'

.code

main proc
    
    mov ax, @data
    mov ds, ax
    
    
    
    ;Prompt for first number
   
    mov dl, offset msg1
    mov ah, 09h
    int 21h

    ;Input first number from user
    
    mov ah, 01h
    int 21h
    sub al, '0'  
    mov bl, al
    
    ;Function for new line
    
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h   

    ;Prompt for second number
   
    mov dl, offset msg2
    mov ah, 09h
    int 21h
    
    ;Input second number from the user 
    
    mov ah, 01h
    int 21h
    sub al, '0'  ; Convert ASCII to integer
    mov cl, al   ; Store second number in BH   
    
    ; Calculate sum
    
    add bl, cl
    
    ;Check if sum is less than 10
    
    ;cmp bl, 10
     
    
    ;Function for new line
    
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h
    
    ;Print for total sum
    
    mov dx, offset msg3
    mov ah, 09h
    int 21h
    
    ;Convert integral sum to ASCII
    
    add bl, '0'
    
    ;Print sum of input integers
    
    mov dl, bl
    mov ah, 02h
    int 21h
    
    
    
    mov ah, 4Ch
    int 21h

main endp
end main
