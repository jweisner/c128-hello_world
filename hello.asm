; hello.asm - print "HELLO, WORLD!" on the Commodore 128
; Build: 64tass -I ~/Devel/c128-lib --cbm-prg -o hello.prg hello.asm

.include "macros.asm"       ; shared macros (found via -I search path)

#BasicUpstart128            ; emit "10 SYS xxxx" BASIC stub at $1C01
                            ; so the program runs automatically after loading

; --- main program: starts right after the BASIC stub ---

        ldx #0              ; X = index into message, start at first char
loop:   lda message,x       ; A = next character (sets Z flag if it's 0)
        beq done            ; zero byte = end of string, stop
        jsr $ffd2           ; CHROUT: print the character in A
        inx                 ; advance to next character
        bne loop            ; keep going (exits only if X wraps past 255)
done:   rts                 ; return to BASIC

; --- data ---

message: .text "HELLO, WORLD!"  ; PETSCII text
         .byte 0                ; null terminator marks end of string
