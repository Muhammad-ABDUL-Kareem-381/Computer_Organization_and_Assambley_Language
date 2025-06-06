                                             title Read and Display Capital letters in Alphabetical order.

                 ; This program displays a prompt to the user to input two capital letters and then displays them in alphabetical order on new lines.

.model small     ; Memory size is small.

.stack 100H      ; Allocating stack size is 100H.

.data            ; Data segment begins here.

    msg1 db "?" , '$'                                        ; Message containing '?' character.
    prompt1 db "Enter first capital letter: " , '$'          ; Message for first input.                
    prompt2 db "Enter second capital letter: " , '$'         ; Message for second input.
    msg2 db "Invalid input. Only capital letters allowed.$"  ; Message in case if invalid input.

                                                                         
.code               ; Code segment begins here.

main proc           ; Main procedure starts.

    mov ax , @data      ; Load address of data segment into AX.
    mov ds , ax         ; Initialize DS with AX.

    ; Display '?'.
    
    mov dl , offset msg1    ; Load address of msg1 into DL.
    mov ah , 09h            ; DOS function to display string.
    int 21h                 ; Call interrupt.

    ; Function for new line.
    
    mov ah, 02h
    mov dl, 0Dh             ; Carriage Return.
    int 21h
    mov dl, 0Ah             ; Line Feed.
    int 21h

    ; Display the prompt for asking the user for the first letter.
    
    mov dl , offset prompt1 ; Load address of prompt1 into DL.
    mov ah, 09h             ; DOS function to display string.
    int 21h                 ; Call interrupt.

    ; Read the character from the input of the user.
    
    mov ah, 01h             ; DOS function to read single character.
    int 21h                 ; Call interrupt.

    ; Store the inputed character of the user.
    
    mov bl, al              ; Store first character in BL.
    
    ; Check if first character is above 'A'.
    
    cmp bl, 'A'
    
    ; If inputs are invalid called invalid_input.
    
    jb invalid_input     ; If less than 'A', go to invalid
    
    ; Check if first character is below 'Z'.  
    
    cmp bl, 'Z'
    
    ; If inputs are invalid called invalid_input.
    
    ja invalid_input     ; If greater than 'Z', go to invalid


    ; Function for new line.
    
    mov ah, 02h
    mov dl, 0Dh             ; Carriage Return.
    int 21h
    mov dl, 0Ah             ; Line Feed.
    int 21h

    ; Display the prompt for asking the user for the second letter.
    
    mov dl , offset prompt2 ; Load address of prompt2 into DL.
    mov ah, 09h             ; DOS function to display string.
    int 21h                 ; Call interrupt.

    ; Read the character from the input of the user.
    
    mov ah, 01h             ; DOS function to read single character.
    int 21h                 ; Call interrupt.

    ; Store the inputed character of the user.
    
    mov cl, al              ; Store second character in CL.
    
    ; Check if second character is above 'A'.
    
    cmp cl, 'A'
    
    ; If inputs are invalid called invalid_input.
    
    jb invalid_input     ; If less than 'A', go to invalid
    
    ; Check if second character is below 'Z'.
    
    cmp cl, 'Z'
    
    ; If inputs are invalid called invalid_input.
    
    ja invalid_input     ; If greater than 'Z', go to invalid

    ; Temporary store the input of the user.
    
    mov al, bl              ; Store value of BL in AL temporarily.

    ; Compare the inputs of the user.
    
    cmp bl, cl              ; Compare first and second characters.

    ; If inputs are in alphabetical order skip swapping and call skip_swap.
    
    jbe skip_swap           ; Jump if BL <= CL. 

    ; If inputs are not in alphabetical order swap them.
    
    mov bl, cl              ; Move second character to BL.
    mov cl, al              ; Move original first character to CL.

; Called when the inputs are in alphabetical order.
    
skip_swap:

    ; Function for new line.
    
    mov ah, 02h
    mov dl, 0Dh             ; Carriage Return.
    int 21h
    mov dl, 0Ah             ; Line Feed.
    int 21h

    ; Display characters.
    
    mov dl, bl              ; Load first  character into DL.
    mov ah, 02h             ; DOS function to print character.
    int 21h                 ; Call interrupt.
    mov dl, cl              ; Load second character into DL.
    int 21h                 ; Call interrupt. 
    
    jmp end_procesure       ; Jump to end the process.

; Called if the input is invalid.
    
invalid_input:

    ; New line before error message.
    
    mov ah, 02h
    mov dl, 0Dh             ; Carriage Return.
    int 21h
    mov dl, 0Ah             ; Line Feed.
    int 21h

    ; Display invalid input message.
    
    mov dx, offset msg2    ; Load address of msg2 into DL
    mov ah, 09h                  ; DOS function to display string.
    int 21h                      ; Call interrupt.
    
; Call if the input is valid.
 
end_procesure:    

    ; Exit program.
                     
    mov ah , 4ch            ; Terminate program
    int 21h                 ; Call interrupt.

main endp                   ; End of main procedure
end main                    ; End of program
