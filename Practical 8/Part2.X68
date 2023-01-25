*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    LEA Health, A2
    ADD.B #5, (A2)
    SUB.B #5, (A2)
    MOVE.B (A2), D0
    MULU #2, D0
    DIVU #2,D0

    

    SIMHALT             ; halt simulator

* Put variables and constants here
Health DC.B $10
    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
