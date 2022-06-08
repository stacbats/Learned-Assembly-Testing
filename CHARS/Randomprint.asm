/**********************************************
    ML version of the following
    10 print chr$(205.5+rnd(1));:goto 10
***********************************************/


    #import "../constants.asm"

*=$C000
BasicUpstart2(main)

main:
	
LOOP:

		jsr RND_Basic
		lda $8c    //$8b - $8f
		and #%00000001
		tax
		lda ASCII,x
		jsr CHROUT
		jmp LOOP

ASCII: .byte $cd,$ce        // Ascii 205 & 206
