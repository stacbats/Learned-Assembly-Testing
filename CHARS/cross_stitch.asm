    #import "../constants.asm"
    
BasicUpstart2(enter)

    *= $c000 "Code Start"       //sys 49152

enter:
    jsr CLEAR 
    Border_Screen(1)
    Cursor_Color(6)

LOOP:

		jsr RND_Basic
		lda $8f    //$8b - $8f
		and #%00000111
        cmp #6 
        bcs LOOP

		tax
		lda ASCII,x
		jsr CHROUT
		jmp LOOP

ASCII: .byte $ab,$b3,$b1,$b2,$c0,$7d