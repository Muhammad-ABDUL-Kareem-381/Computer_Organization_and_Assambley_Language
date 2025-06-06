                                                       Title Palindrome checker
                              ; This program checks whether the input ASCII character is a palindrome in binary form or not.

.model small

.stack 100h

.data

    Prompt db "Enter a Character: " , '$'                 ; Prompt to ask for input character
    output db "ASCII BINARY: " , '$'                      ; Message shown before binary output
    Result_1 db "Result: Palindrome." , '$'               ; Message for palindrome result
    Result_2 db "Result: Not Palindrome." , '$'           ; Message for non-palindrome result
    Binstr db 8 DUP('0'), '$'                              ; String to hold binary representation (8 bits)

.code

Main proc

    mov ax,@data                                          ; Initialize data segment
    mov ds,ax

    lea dx,Prompt                                         ; Display prompt message
    mov ah,09h
    int 21h

    mov ah,01h                                            ; Read character input from user
    int 21h

    mov bl,al                                             ; Store character in BL
    mov cx,8                                              ; Set loop counter for 8 bits
    mov si,offset Binstr                                  ; SI points to start of binary string

Binary_Converter:                                         ; Convert ASCII character to binary

    rol bl,1                                              ; Rotate BL left; MSB moves to carry flag
    jc Input_1                                            ; If carry set, bit is 1
    mov byte ptr [si], '0'                                ; Store '0' if carry not set
    jmp Calculation                                       ; Continue to next bit

Input_1:

    mov byte ptr[si], '1'                                 ; Store '1' if carry was set

calculation:

    inc si                                                ; Move to next byte in Binstr
    dec cx                                                ; Decrease bit counter
    jnz Binary_Converter                                  ; Repeat until 8 bits are processed

    ; Print new line sequence

    mov ah, 02h                                           ; DOS function to print character
    mov dl, 0Dh                                           ; Carriage Return
    int 21h
    mov dl, 0Ah                                           ; Line Feed
    int 21h

    lea dx,Output                                         ; Display ASCII BINARY label
    mov ah,09h
    int 21h  

    lea dx,Binstr                                         ; Display binary string
    mov ah,09h
    int 21h

    ; Print new line sequence

    mov ah, 02h                                           ; DOS function to print character
    mov dl, 0Dh                                           ; Carriage Return
    int 21h
    mov dl, 0Ah                                           ; Line Feed
    int 21h

    mov cx,4                                              ; Set loop to compare 4 pairs (8 bits)
    mov si,offset Binstr                                  ; SI points to first character
    mov di,offset Binstr + 7                              ; DI points to last character

Check_Palindrome:                                         ; Compare characters from both ends

    mov al,[si]                                           ; Load character from start
    cmp al,[di]                                           ; Compare with character from end
    jne Not_Palindrome                                    ; If not equal, it's not a palindrome  
    
    inc si                                                ; Move forward from start
    dec di                                                ; Move backward from end
    dec cx                                                ; Decrease loop counter   
    
    jnz Check_Palindrome                                  ; Repeat for remaining pairs

Palindrome:

    lea dx,Result_1                                       ; Display "Palindrome" message
    mov ah,09h
    int 21h
    jmp Exit                                              ; Exit program

Not_Palindrome:

    lea dx,Result_2                                       ; Display "Not Palindrome" message
    mov ah,09h
    int 21h       

Exit:

    mov ah,04ch                                           ; Terminate program
    int 21h

Main endp
end Main
