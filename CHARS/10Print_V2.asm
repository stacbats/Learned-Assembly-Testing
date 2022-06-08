   
    #import "../constants.asm"

BasicUpstart2(enter)

    *= $c000 "Code Start"       //sys 49152

enter:
    jsr CLEAR 
    Border_Screen(2)
    Cursor_Color(0)

LOOP:

		jsr RND_Basic
		lda $8c    //$8b - $8f
		and #%00000001
		tax
		lda ASCII,x
		jsr CHROUT
		jmp LOOP

ASCII: .byte $cd,$ce        // Ascii 205 & 206