    #import "../constants.asm"
 

BasicUpstart2(enter)

    *= $1000 "Code Start"       //sys 8192

enter:

	// main program
	*=$1000
	
 
	// clear screen
	lda #$93	// CHR$(147)
	jsr CHROUT
	
	// black out
	lda #$00
	sta $d020
	sta $d021
	
	// lower case mode
	lda #23
	sta $d018
	
	lda #$00 // all sprites high-res
	sta $d01c
	
	lda #$FF // sprites all stretched
	sta $d01d
	sta $d017
	
	lda #$80 // ptr to sprite 1
	sta $07f8
	lda #$81 // ptr to sprite 2
	sta $07f9
	lda #$82 // ptr to sprite 3
	sta $07fa
	
	lda #$01 // colors
	sta $d027
	sta $d028
	sta $d029
	
	lda #$07 // enable sprite 1 + 2 + 3
	sta $d015
	
	lda #$60 // sprite 1 position       //$80
	sta $d000

	lda #$15 		// all sprite y position	#$50
	sta $d001
	sta $d003
	sta $d005
	
	lda #$b0 // sprite 2 x
	sta $d002
	
	lda #$e0			//	224 -#$e0 200
	sta $d004

	// start with scroll register filled
	ldx #$7
	stx $d016
	
	// Green Text
	ldx #$00
	lda #$05
colloop:	sta $d9e0, x
	inx
	cpx #39
	bne colloop
	
//	now fade it at the edges
	lda #$0d  
	sta $d9e0
	sta $da04

	lda #$0d
	sta $d9e1
	sta $da05

	lda #$0d  
	sta $d9e2
	sta $da06

outer:	ldy #$00

	jsr SOFTSCROLL

inner:
	ldx #00
shift:	// lets go left 
	lda $05E1, x
	sta $05E0, x
	inx
	cpx #$38
	bne shift
	
	ldx #39
	// load next char
	lda textdata, y
	beq outer //  start loop again once nil
	cmp #$80
	bcc lowercase
	sbc #$80
	jmp uppercase
lowercase:
	and #$3f
uppercase:

	// store the new character on the screen
	sta $05E0, x
	iny // increment pointer in string
	
	jsr SOFTSCROLL
	jmp inner

// soft scroll routine
// start with VIC scroll register at 7, decrement approximately
// every 15 frames, then reset it before returning.

// this one has sprite bounce in the delay too!
SOFTSCROLL:
	ldx #$7
scrlloop:	
	stx $d016
pause:	lda $d012 // wait for screen frame
	bne pause
	
	// check direction
	lda direction
	bne up
	
	// down
	lda $d001
	cmp #$70	// 60
	bcc moredown
	lda #$01
	sta direction
	
	jmp bncdone
	
moredown:	inc $d001
	inc $d003
	inc $d005
	
	jmp bncdone
	
up:	lda $d001
	cmp #$40		// 50
	bcs moreup
	lda #$00
	sta direction
	
	jmp bncdone
	
moreup:	dec $d001
	dec $d003
	dec $d005

bncdone:	lda #$04		// #$09
	sta delay

bncdelay:	lda $d012 // wait for screen frame
	bne bncdelay
	dec delay
	bne bncdelay
	
	dex
	bne scrlloop
	
	ldx #$7
	stx $d016
 
	rts
	
textdata:
	.text "The HULK is a fictional superhero created by "
	.text "Marvel Comics back in may 1962 by Stan Lee and "
	.text "Jack Kirby. This is a little demo on the humble 64 "
	.text "of the angry green man. Its not much but its a start "
	.text "on my C64 coding path.                   "

//	.repeat 38," " // 38 blank spaces to clear screen at end
	.byte $00 // null byte to terminate string
	
delay:	    .byte $09
direction:	.byte $00
	
	*=$2000
sprite_image_0:
//sprite_image_0:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$FC,$CC,$F0,$30,$CC
.byte $C0,$30,$CC,$F0,$30,$FC,$F0,$30,$CC,$C0,$30,$CC,$F0,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01

//sprite_image_1:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$C7,$0C,$E3,$C7
.byte $0C,$E3,$C7,$0C,$E3,$C7,$0C,$E3,$C7,$0C,$E3,$FF,$0C,$E3,$FF,$0C
.byte $E3,$FF,$0C,$E3,$C7,$0C,$E3,$C7,$0C,$E3,$C7,$0F,$E3,$C7,$0F,$E3
.byte $C7,$0F,$E3,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01

//sprite_image_2:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$81,$C1,$BF,$81
.byte $C3,$BF,$81,$C7,$3F,$81,$CE,$1E,$81,$DC,$1E,$81,$F8,$1E,$81,$F0
.byte $1E,$81,$F8,$0C,$81,$FC,$0C,$81,$CE,$00,$F9,$C7,$0C,$F9,$C3,$9E
.byte $F9,$C1,$8C,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01