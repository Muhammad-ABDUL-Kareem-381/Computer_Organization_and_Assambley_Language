                                    Title Display extended ASCII characters
           ; This program is responsible to display 10 characters per line, each character separated by a blank.  
           
.model small

.stack 100h

.data

    msg1 db "The extended ASCII code characters are as follows." , '$' ; Message to display
    char db 80h         ; Start from ASCII 80h (128 decimal)
    count db 0          ; To count characters per line (0–9)
    
    
.code

main proc
    
    mov ax, @data           ; Load address of data segment
    mov ds, ax              ; Initialize DS with data segment

    ; Display message.
    
    mov dl, offset msg1     ; Load offset of message into DL.
    mov ah, 09h             ; DOS function to display string
    int 21h                 ; Call DOS interrupt

    ; Function for new line.
    
    mov ah, 02h             ; DOS function to display character
    mov dl, 0Dh             ; Carriage Return.
    int 21h
    mov dl, 0Ah             ; Line Feed.
    int 21h          
    
    ; Move to next line after message

    mov cx, 128             ; Number of characters to display (from 80h to FFh)

Looping:
    mov dl, char            ; Load current character into DL
    mov ah, 02h             ; DOS function to display character
    int 21h                 ; Call DOS interrupt

    ; Print space
    
    mov dl, ' '             ; Load space character into DL
    mov ah, 02h             ; DOS function to display character
    int 21h                 ; Call DOS interrupt

    inc count               ; Increase character count
    cmp count, 10           ; Check if 10 characters printed
    
    jne skip_newline        ; If not 10, skip new line

    ; Function for new line.
    
    mov ah, 02h             ; DOS function to display character
    mov dl, 0Dh             ; Carriage Return.
    int 21h
    mov dl, 0Ah             ; Line Feed.
    int 21h                 ; Print a new line
    
    mov count, 0            ; Reset line character counter

skip_newline:

    inc char                ; Go to next ASCII character
    loop Looping            ; Repeat loop CX times

    ; Exit program
    
    mov ah, 4Ch             ; DOS function to terminate program
    int 21h                 ; Call DOS interrupt

main endp 
end main
