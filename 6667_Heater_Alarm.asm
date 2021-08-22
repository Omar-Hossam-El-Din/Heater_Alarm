;***************WELCOME TO HEATER ALARM***************
include emu8086.inc       ;Library of common functions

          ORG  100H

.CODE 

          PRINT '***************WELCOME TO HEATER ALARM***************'  
          PRINTN          ;Prints a new line
START:    PRINT 'Please Enter the Boiler Temperature in Degree Celsius: ' 
          CALL SCAN_NUM   ;Gets the multi-digit SIGNED number from the keyboard,  stores the result in CX
          PRINTN
          CMP  CX, 200
          JLE  LOW
          CMP  CX, 500
          JGE  HIGH 
        
MEDIUM:   PRINT 'YELLOW LED IS TURNED ON' ;Prints an indication message
          JMP  DONE 
        
LOW:      PRINT 'GREEN LED IS TURNED ON'  ;Prints an indication message
          JMP  DONE 
        
HIGH:     PRINT 'RED LED IS TURNED ON'    ;Prints an indication message

DONE:     PRINTN 
          PRINT '-------------------------'
          PRINTN
          CALL DELAYPROC
          JMP  START

          RET             ;Returns to the main caller (Operating System)  
        
DEFINE_SCAN_NUM    

          DELAYPROC PROC  ;Procedure for the 3 minutes delay 
              
          MOV  AL, 3      ;Loop Counter
                          ;The resolution of the wait period is in microseconds (60 million microseconds --> 1 minute) equivalent to 03938700H
REPEAT:   MOV  CX, 0393H  ;Upper two bytes (0393H)
          MOV  DX, 8700H  ;Lower two bytes (8700H)
          MOV  AH, 86H    ;Auxulary Register with 86H for INT 15H
          INT  15H        ;BIOS wait function, Inputs are CX:DX, waits for a specific number of microseconds before returning control to caller
          DEC  AL
          JNZ  REPEAT     ;Loop 3 times to generate 3 minutes delay  
        
          RET             ;Returns to the caller (Start)
        
DELAYPROC ENDP 
END                       ;Stop the Program
