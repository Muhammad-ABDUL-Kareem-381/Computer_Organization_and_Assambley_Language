                                              Title Convert Hex Digit to Decimal.
               ; This program convert the HexaDecimal value into Decimal Value and continue untill the user want to continue it

.model small   ; Memory size is small.

.stack 100h    ; Stack size is 100H.

.data          ; Data segment begains here.

    msg1 DB "Enter a Hex digit: " , '$'                         ;Message for hexa decimal input.
    msg2 DB "Illegal character-- Enter 0...9 OR A...F: " , '$'  ;Message for illegal input.
    msg3 DB "In decimal it is: " , '$'                          ;message for output.
    msg4 DB "Do you want to do it again? " , '$'                ;Message for again start the code.
    

.code          ; Code segment begains here.

main proc      ; Main procedure starts.

    mov ax , @data   ; Load address of data segment into ax.
    mov ds, ax       ; Initialize DS with AX.

; Repeating input part of the code.
    
Repeat:
    
    ; Display input promt to the user.
    
    mov dl, offset msg1      ; Load offset address of msg1 into DL.
    MOV ah, 09H              ; DOS function to display string.
    INT 21H                  ; Call interrupt to display string.

    ; Read input character.
                             ; DOS function to read character from standard input.
    MOV AH, 01H
    INT 21H                  ; Read input character.
    
    ; Store the inputed character.
    
    MOV bl, al               ; Store character in BL for processing.

; Repeating part of the code which is used to check the input value.

check:

    ; Validate and convert
    
    cmp bl, 30h                ; Check if character < '0'.
    jl invalid                 ; If less, it's invalid.
    
    cmp bl, 39h                ; Check if character <= '9'.
    jle digit                  ; If true, it's a digit.
    
    cmp bl, 41h                ; Check if character < 'A'.
    jl invalid                 ; If less, it's invalid.
    
    cmp bl, 46h                ; Check if character <= 'F'.
    jle alphabet               ; If true, it's a valid hex letter.
    
    cmp bl, 46h                ; Check if character > 'F'.
    jg invalid                 ; If true, it's invalid.

; Call whan the input is an alphabet.

alphabet:
    
    ; Function for new line.
    
    mov ah, 02h
    mov dl, 0Dh                ; Carriage Return.
    int 21h
    mov dl, 0Ah                ; Line Feed.
    int 21h
    
    ; Display output message.
    
    mov dl, offset msg3
    mov ah, 09h
    int 21h
    
    ; Convert hexadecimal letter to decimal value.
    
    sub bl, 11h                ; Convert 'A'-'F' to corresponding decimal ('A' = 65 - 17 = 48 = '0')

    mov dl, 31h                ; Display '1' to indicate decimal is 1X.
    mov ah, 02h
    int 21h
    mov dl, bl                 ; Display second digit (0-5).
    mov ah,02h
    int 21h

    jmp again                  ; Ask if the user wants to continue.

; Called whan the input is an digit.
    
digit:
    
    ; Print a new line.
    
    mov ah, 02h
    mov dl, 0Dh                ; Carriage Return.
    int 21h
    mov dl, 0Ah                ; Line Feed.
    int 21h
    
    ; Display output message.
    
    mov dl, offset msg3
    mov ah, 09h
    int 21h
    
    mov dl, bl                 ; Display the digit (0-9).
    mov ah, 02h
    int 21h
    
    jmp again                  ; Ask if the user wants to continue.

; Call whan the input is invalid.

invalid:

    ; Print a new line.
    
    mov ah, 02h
    mov dl, 0Dh                ; Carriage Return.
    int 21h
    mov dl, 0Ah                ; Line Feed.
    int 21h       
    
    ; Display invalid input message.
    
    mov dl, offset msg2
    mov ah, 09h
    int 21h
   
    ; Get new input character.
    
    mov ah, 01h
    int 21h
    mov bl, al
    jmp check                  ; Recheck the new character.
    

; Called whan there is a need for a newline whan again calling the code.
    
new_line_for_repeat:
    
    ; Print a new line.
    
    mov ah, 02h
    mov dl, 0Dh                ; Carriage Return.
    int 21h
    mov dl, 0Ah                ; Line Feed.
    int 21h
    
    jmp repeat                 ; Repeat the program.
    

; Part ogf the code to again call the code.
        
again:   

    ; Print a new line.
    
    mov ah, 02h
    mov dl, 0Dh                ; Carriage Return.
    int 21h
    mov dl, 0Ah                ; Line Feed.
    int 21h
    
    ; Ask user if they want to repeat.
    
    mov dl , offset msg4       ; Load prompt message.
    mov ah, 09h
    int 21h
    mov ah, 01h
    int 21h
           
    cmp al, 'Y'                ; Check if input is 'Y'.
    je new_line_for_repeat
    cmp al, 'y'                ; Check if input is 'y'.
    je new_line_for_repeat

    ; Exit the program.
    
    mov ah, 4Ch
    int 21h
                               
main endp                      ; End the main procesure
end main                       ; End the main part