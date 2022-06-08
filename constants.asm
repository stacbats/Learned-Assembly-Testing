// LABELS for the program
    .const CLEAR            = $e544
    .const SCREENPOSITION   = $0400
    .const COLUR_RAM        = $d800 
    .const CHROUT           = $ffd2
    .const RND_Basic        = $e097
    .const INKS             = $0286 
    .const BORDER           = $d020
    .const SCREEN           = $d021    

    .const SPENA            = $d015  
    .const SP0X             = $d000
    .const SP0Y             = $d001
    .const SPMCM            = $d01c

// MACROS 

    .macro Border_Screen(COL1) {
        lda #COL1 
        sta BORDER
        sta SCREEN
    }

    .macro Cursor_Color(ink) {
    lda #ink
    sta $0286
    }

/**************************************************************

        I will Keep adding to this source as i go

**************************************************************/