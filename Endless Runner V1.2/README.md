# README #

Using Easy68K build a test based game based on Plumbers Vs Rabbits.

### What is this repository for? ###

* StarterKit for Computer Architecture for Games Devices and Computer Architecture
* Gameloop

### How do I get set up? ###

* Setup Easy68K on your PC
* Download StarterKit
* Edit and add features for your game

### Example Code

* Starter Code Code is loaded from Memory location $1000 (To view click View and Memory in Easy68k)
```
* MEMORY START POSITION OF ASM PROG $1000
    ORG    $1000
START:
* CODE GOES HERE
    SIMHALT
* DATA HERE
    END    START
```
* Hello World, the code below displays Hello World when executed using Easy68
```
    ORG    $1000
START:
    LEA MESSAGE, A1
    MOVE.B #14, D0
    TRAP #15

    SIMHALT

MESSAGE 'Hello World', 0

    END    START
```
* Memory Operations
```
    ORG    $1000
START:

    MOVE    #5, D0 #Moves 5 into a Data Register which a special part of memory
    MOVE    D0, $3000 #Moves contents of Data Register to memory location $3000
    MOVE    D0, 3000 #Moves contents of Data Register to memory location 3000 (Note it will be converted to HEX Value)
    
    MOVE.B  #3, 100 # This will move value 3 into memory location 100 (Note it will be converted to HEX Value) into D1
    MOVE.B  100, D1 # This will move memory location 100 (Note it will be converted to HEX Value) into D1
    
    MOVE.B  #100, D1 # Initialise Health at 100 in D1
    
    MOVE.B  D1, $4050 # Move Health value into HEX memory location 4050

    SIMHALT

    END    START        ; last line of source
```
* Branching Code. The code below will loop between FAST_DAY and HAVE_LUNCH. 
    * `BRA` is Branch Always
    * `CMP` Compares a Value with whatever is stored in Data Register
    * `BNE` will brach when not equals by lookin at the `Z` bit of the Status Register `SR`. 
    * `SUB` is Substract.
```
    ORG    $1000
START:

    MOVE.B #3, D0
NEXT:    
    MOVE.B  #3, D2
    CMP #3, D2
    BNE EXIT
    MOVE.B #4, D3
    SUB #1, D0
    BNE NEXT
    
    BRA FAST_DAY

HAVE_LUNCH:
    MOVE.W  #2000, D1
    BRA START

FAST_DAY:
    MOVE.W  #10, D1
    BRA HAVE_LUNCH
    
EXIT:

    SIMHALT 
    END    START  
```

* Simple Game Loop
```
    ORG    $1000
START:
    MOVE.B      #1, $2000
    MOVE.B      $2000, D1
    CMP         #1, D1
    BNE         END_GAME
    BSR         GAME_LOOP
    
GAME_LOOP:
    BSR INPUT
    BSR UPDATE
    BSR DRAW  
    BRA GAME_LOOP

INPUT:
    MOVE        #4, D0
    TRAP        #15
    MOVE.B      D1, $2000
    RTS
UPDATE:
    MOVE.B      $2000, D1
    CMP         #1, D1
    BNE END_GAME
    RTS
DRAW:
    RTS
    
END_GAME:
    LEA         MESSAGE, A1
    MOVE.B      #14, D0
    TRAP        #15

    SIMHALT

MESSAGE DC.B    'THANKS FOR PLAYING', 0

    END    START
```
* More elaborate Game Loop with basic internal economy
```
    ORG    $1000
START: 
    LEA MESSAGE, A1 #MESSAGE TO PRINT OUT
    
    MOVE.W #500, $2000 #STORE THE OVERALL CARBON LEVELS IN THE AIR

    MOVE.B  #3, D0 # THE NUMBER OF TIMES WE WILL LOOP
    
NEXT:
    SUB #1, D0 # TAKING ONE AWAY FROM THE THE LOOP COUNTER
    ADD.B #1, D1 #ADDING UNITS TO OUR INVENTORY
    
    MOVE.B D0, D2 #SWAPPING OUT D0 TO D2 TEMPARALY
    
    CMP #2, D1 #COMPARING THE NUMBER OF UNITS WITH 2, IF GREATER THAN 2 CARBON IS REDUCING
    BSR CARBON_REDUCTION #WE NEED GO TO THE THE CARBON REDUCTION SUB ROUTINE
    
    MOVE.B #14, D0 #NEXT STEP AFTER SUB ROUTINE, DISPLAY LOOPY TEXT
    TRAP    #15 # INTERUPT TO DISPLAY TEXT
    
    MOVE.B D2, D0 #RESTORE THE VALUE OF THE LOOP COUNTER
    
    CMP #0, D0 #COMPARE LOOP COUNTER WITH 0, STOP AT 0
    BNE NEXT # GO BACK TO THE THE TOP OF THE LOOP

CARBON_REDUCTION:
    SUB.W #10, $2000 # THE SUB ROUTINE BEGINS TO REDUCE CARBON IN THE AIR
    RTS #RETURN TO WHERE SUB ROUTINE WAS CALLED FROM

    SIMHALT  

MESSAGE DC.B    'Loopy', 0


    END    START
```

* Sample Random Number Generator
```
    ORG    $1000
START:    
    BSR RANDOM_NUMBER  
    
    MOVE.B #3, D0 #Display Number
    TRAP #15
    BRA END_PROG


RANDOM_NUMBER:     
    MOVE.B #8, D0 #Loads D1 with Time in 100's of Seconds since midnight (6 Bits)
    
    TRAP #15  #Place time in D1

    AND.L #$5FFFFF, D1 # AND 6 Bits to prevent any overflow
    
    DIVU #100, D1 #Divide by 100, 1000, 10000 depending on Number range required
    
    SWAP D1 #SWAP Higher Order Word and Lower Order Word in D1
    
    ADDQ.W #1, D1 #Add 1 to D1.W so number is at least 1
    
    MOVE.W D1, D2 #Extract the number from D1.W
    
    CLR.L D1 # Clear contents of D1

    MOVE.W D2, D1 #Move the generated number to D1
    RTS

END_PROG:
    
    SIMHALT            
    END    START
```
* Sample reading a String of input
```
    ORG    $1000
START:  
    MOVE.B  #2,D0 # Take user input
string
    LEA $3000, A1 # Null terminated string is stored at A1 Address, set to $3000 or any other available address
    TRAP #15 # Ask user for input, D1 will store length number of bytes
    
    MOVE.L D1, D2 #Move the lenght of string to D2

    LEA $3000, A1
    MOVE.B #14, D0 # Display test that was input
    TRAP #15
    
    MOVE.L  D2, D1
    MOVE.B   #3, D0 # Display length of string
    TRAP #15
    
        
    SIMHALT 

CRLF DC.B $0D, $0A
    END    START       
```

* Memory Operations traversing memory

```
    ORG    $1000
START:

    MOVE.B #1, $3000
    MOVE.B #2, $3001
    MOVE.B #3, $3002
    
    LEA $3000, A2
    
    MOVE.B (A2)+, D2
    MOVE.B (A2)+, D2
    MOVE.B (A2)+, D2
    
    SIMHALT         
    END    START 
```
### Who do I talk to? ###

* philip.bourke@itcarlow.ie
