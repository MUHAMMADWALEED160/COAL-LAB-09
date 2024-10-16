.model small
.stack 100h

.data
    inputString db "Hello, World$", 0  ; Input string with null terminator
    msgOriginal db "The original string: $"
    msgReversed db 0Dh, 0Ah, "The reversed string: $"
    newline db 0Dh, 0Ah, '$'           ; Newline character for formatting

.code
main proc
    mov ax, @data         ; Setup data segment
    mov ds, ax

    ; Call procedure to print the original string
    lea dx, msgOriginal
    call PrintString
    lea dx, inputString
    call PrintString
    lea dx, newline
    call PrintString

    ; Call procedure to reverse the string
    lea si, inputString   ; SI points to the start of the string
    call ReverseString

    ; Call procedure to print the reversed string
    lea dx, msgReversed
    call PrintString
    lea dx, inputString
    call PrintString
    lea dx, newline
    call PrintString

    ; Exit the program
    mov ax, 4C00h         ; Prepare for program termination
    int 21h               ; Interrupt to exit
main endp

; Procedure to print a string using INT 21h
PrintString proc
    mov ah, 09h           ; DOS service to display string
    int 21h               ; Call DOS interrupt
    ret                   ; Return from procedure
PrintString endp

; Procedure to reverse a string
ReverseString proc
    ; Find the length of the string
    call FindStringLength
    dec si                ; Adjust SI to point to the last character (skip null terminator)

    ; Set DI to the beginning of the string
    lea di, inputString

swap_loop:
    cmp si, di            ; Compare start and end pointers (SI and DI)
    jle ReverseStringEnd  ; If SI <= DI, stop swapping
    ; Swap characters
    mov al, [di]          ; Load character from the start into AL
    mov bl, [si]          ; Load character from the end into BL
    mov [di], bl          ; Place end character at the start
    mov [si], al          ; Place start character at the end
    inc di                ; Move DI forward
    dec si                ; Move SI backward
    jmp swap_loop         ; Repeat the swap process

ReverseStringEnd:
    ret                   ; Return from procedure
ReverseString endp

; Procedure to find the length of a string
FindStringLength proc
    ; SI should already point to the start of the string
    mov cx, 0             ; Initialize counter for length
find_length:
    mov al, [si]          ; Load character from the string
    cmp al, '$'           ; Check for string terminator
    je length_found       ; If terminator is found, stop
    inc si                ; Move SI to the next character
    inc cx                ; Increase the count
    jmp find_length       ; Continue until terminator is found
length_found:
    ret                   ; Return from procedure
FindStringLength endp

end main
