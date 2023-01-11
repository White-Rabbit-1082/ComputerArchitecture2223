*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------

START:                 
    
    MOVE.B #9,D1        ;moves the number 9 into D1
    MOVE.B D1,D2        ;moves contents of D1 into D2
    MOVE.B D1,1100      ;moves the contents of D1 into the memory location 1100
    MOVE.B 1100,D2      ;mvoes the contents of the memory location 1100 to D2
    MOVE.B 1100,100     



    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
