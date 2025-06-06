                                 Title Binary Addition
            ; This program gives the sum of two 8-bit binary number strings entered as ASCII characters.

.model small

.stack 100h

.data

    prompt_1 db "Type the First Binary Number, up to 8 Digigts: " , '$' ; Prompt for first binary input
    prompt_2 db "Type the Second Binary Number, up to 8 Digigts: " , '$' ; Prompt for second binary input
    result db "The Binary Sum is: " ,'$' ; Message shown before displaying result
    invalid db "Invalid Input. Please Enter Again." ,'$' ; Error message for invalid characters
    bin_1 db 9 DUP('$')       ; First binary number string (max 8 digits + '$' terminator)
    bin_2 db 9 DUP('$')       ; Second binary number string
    sumstr db 9 DUP('0'), '$' ; Storage for binary sum (max 9 bits + '$')
    flag db 0                 ; Used as a general-purpose flag and for carry

.code

Main proc

    mov ax,@data              ; Initialize data segment
    mov ds,ax

again:

    lea dx,prompt_1           ; Display prompt for first binary number
    mov ah,09h
    int 21h

    mov cx,8                  ; Set loop counter to 8 digits
    mov si,offset bin_1       ; SI points to bin_1
    mov flag,0                ; Flag 0 means first input

first_input:

    mov ah,01h                ; Read a character from user
    int 21h

    mov bl,al                 ; Store input character in BL

    cmp bl,'0'                ; Validate if character is '0' or '1'
    jb invalid_input
    cmp bl,'1'
    ja invalid_input

    cmp bl,'0'                ; Store '0' or '1' in bin_1
    je input_0
    cmp bl,'1'
    je input_1

return_first:

    inc si                    ; Move to next character
    loop first_input          ; Repeat for 8 digits

    ; Print a new line
    
    mov ah,02h
    mov dl,0Dh                ; Carriage Return
    int 21h
    mov dl,0Ah                ; Line Feed
    int 21h

    lea dx,prompt_2           ; Prompt for second binary number
    mov ah,09h
    int 21h

    mov cx,8                  ; Set loop counter to 8 digits
    mov si,offset bin_2       ; SI points to bin_2
    mov flag,1                ; Flag 1 means second input

second_input:

    mov ah,01h                ; Read a character
    int 21h

    mov bl,al                 ; Store input in BL

    cmp bl,'0'                ; Validate '0' or '1'
    jb invalid_input
    cmp bl,'1'
    ja invalid_input

    cmp bl,'0'                ; Store character in bin_2
    je input_0
    cmp bl,'1'
    je input_1

return_second:

    inc si                    ; Move to next character
    loop second_input         ; Repeat for 8 digits

    jmp next                  ; Proceed to addition

invalid_input:

    lea dx,invalid            ; Display invalid input message
    mov ah,09h
    int 21h

    jmp again                 ; Restart input process

input_0:

    mov byte ptr[si],'0'      ; Store '0' at current position

    mov bl,flag               ; Check which input we're processing
    cmp bl,0
    je  return_first
    cmp bl,1
    je  return_second

input_1:

    mov byte ptr[si],'1'      ; Store '1' at current position

    mov bl,flag               ; Check input stage
    cmp bl,0
    je  return_first
    cmp bl,1
    je  return_second

next:

    ; Print a new line 
    
    mov ah,02h
    mov dl,0Dh
    int 21h
    mov dl,0Ah
    int 21h

    ; Perform Binary Additio
    
    mov si,offset bin_1 + 7   ; Point to last digit of bin_1
    mov di,offset bin_2 + 7   ; Point to last digit of bin_2
    mov bx,offset sumstr + 8  ; Point to end of sumstr
    mov flag,0                ; Clear carry flag
    mov cx,8                  ; Loop for 8 bits

sum_loop:

    mov al,[si]               ; Load bit from bin_1
    sub al,'0'                ; Convert ASCII to numeric

    mov ah,[di]               ; Load bit from bin_2
    sub ah,'0'                ; Convert ASCII to numeric

    add al,ah                 ; Add the bits
    add al,flag               ; Add carry from previous step

    cmp al,2
    jb no_carry               ; If sum < 2, no carry

    cmp al,2
    je set_carry_zero         ; If sum = 2, result 0 with carry 1

    cmp al,3
    je set_carry_one          ; If sum = 3, result 1 with carry 1

no_carry:

    mov flag, 0               ; No carry
    jmp store_bit

set_carry_zero:

    mov flag, 1               ; Set carry
    mov al, 0                 ; Resulting bit is 0
    jmp store_bit

set_carry_one:

    mov flag, 1               ; Set carry
    mov al, 1                 ; Resulting bit is 1

store_bit:

    add al, '0'               ; Convert back to ASCII
    mov [bx], al              ; Store bit in sumstr

    dec si                    ; Move to previous bit
    dec di
    dec bx

    loop sum_loop             ; Repeat for all 8 bits

    ; Store final carry if any
    
    cmp flag, 1
    jne skip_carry

    mov byte ptr [bx], '1'    ; Store carry at start of sumstr

    jmp display

skip_carry:

    inc bx                    ; Skip leading zero if no carry

display:

    lea dx, result            ; Display result label
    mov ah, 09h
    int 21h

    mov dx, bx                ; Display the binary sum
    mov ah, 09h
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h

Main endp
end main
