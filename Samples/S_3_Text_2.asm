// short examples from HACKING MAG  
// These are taken from text 2

BasicUpstart2(start)

start:


    ldy #$00

loop:   

    lda string,y 
    jsr $ffd2
    iny 
    cpy #05 
    bne loop 
    rts
    
string: .byte $153,$54, $141, $143, $159

    rts
 