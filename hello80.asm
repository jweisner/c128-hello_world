; hello80.asm - print "Hello World" on the C128 80-column (VDC) screen
; Build: 64tass -a -I ~/Devel/c128-lib --cbm-prg -o hello80.prg hello80.asm
;        (-a converts the ASCII text below to PETSCII, so mixed case works)

.include "macros.asm"       ; shared macros (found via -I search path)

#BasicUpstart128            ; "10 SYS xxxx" stub at $1C01, code follows

; --- make sure the screen editor is driving the 80-column display ---

        lda $d7             ; MODE flag: bit 7 set = 80-column screen active
        bmi +               ; already on 80 columns? skip the switch
        jsr $ff5f           ; SWAPPER: toggle the editor between 40 and 80 col
+

; --- print the message, same loop as hello.asm ---

        ldx #0              ; X = index into message
loop:   lda message,x       ; A = next byte (Z flag set if it's 0)
        beq done            ; zero byte = end of string
        jsr $ffd2           ; CHROUT: print A on the active screen (now 80 col)
        inx                 ; next byte
        bne loop            ; loop (exits only if X wraps past 255)
done:   rts                 ; back to BASIC (which stays on the 80-col screen)

; --- data ---

message: .byte $93          ; PETSCII: clear screen
         .byte $0e          ; PETSCII: switch to lower/upper case character set
         .text "Hello World"
         .byte 13           ; carriage return, so READY. starts on a new line
         .byte 0            ; terminator
