*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    MOVE.B #9,D1  ;moves the numebr 9 into the data register D1
    LEA text, A1  ;moves the word text into
    MOVE #14,D0   ;moves the numebr 14 into the data register D1
    TRAP #15      ;
    MOVE #3,D0    ;moves the value 3 into tne data register D0
    TRAP #15      ; 

 SIMHALT
text dc.b 'Data Register: ',0

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
