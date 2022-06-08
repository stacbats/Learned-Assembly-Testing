    #import "../constants.asm"

// Place A to Z on screen

BasicUpstart2(enter)

    *= $c000 "Code Start"       //sys 49152

enter:
    jsr CLEAR 
    Border_Screen(2)
    Cursor_Color(0)

	ldx #$41                // Load X with A(asci 65) 
LOOP:                       // Create a Label to loop too
	txa                     // Transfer X into A reg 
	jsr CHROUT              // Kernal routine to print character 
	inx                     // Increment x 
	cpx #$5b                // Compare X reg with $5b(91- ascii z)
	bne LOOP                // Keep looping until Z
     
	rts                     