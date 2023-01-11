*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    LEA text, A1    ;moves the text into A1
    MOVE #4,D0      ;moves number 4 into address D0
    TRAP #15        ;tells the code to execute instrucion 15 which exectues the command in D0
    MOVE #14,D0     ;moves the number 14 into address D0
    TRAP #15        ;
    MOVE #3,D0      ;moves number 3 into address D0
    TRAP #15        ;

 SIMHALT
text dc.b 'Data Register: ',0

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
