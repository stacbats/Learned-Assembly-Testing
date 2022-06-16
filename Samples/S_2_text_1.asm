// short examples from HACKING MAG  
// These are taken from text 2

BasicUpstart2(start)

start:




          lda #147         // clr/screen code
          jsr $ffd2        // print
          lda #'C'         // code for ascii "C"
          jsr $ffd2        // print
          lda #'R'    
          jsr $ffd2
          lda #'A'
          jsr $ffd2
          lda #'I'
          jsr $ffd2
          lda #'G'
          jsr $ffd2
          lda #32          // code for space 
          jsr $ffd2
          lda #'T'         // print my last name....
          jsr $ffd2

          rts