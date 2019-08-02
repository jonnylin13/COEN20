        .syntax unified
        .cpu    cortex-m4
        .text
        .thumb_func
        .align

        .global PutNibble
PutNibble:          
        // Load nibble index shifted left into R3
        LSR     R3,R1,1     
        // Add index to R0
        ADD     R0,R0,R3   
        // Preserve R4 
        PUSH    {R4}         
        // Copies matching 1s into R4
        AND     R4,R1,1        
        LDR     R3,=15 // Load 15 into R3
        // Loads the address of R0 into R1
        LDRB    R1,[R0]         
        CMP     R4,1 // Compares the overflow bit
        ITE     EQ       
        // Shifts R2 if equal       
        LSLEQ   R2,R2,4      
        // Shifts R3 else
        LSLNE   R3,R3,4       
        // Copies matching 1s  
        AND     R1,R1,R3        
        // Copies 1s
        ORR     R1,R1,R2        
        STRB    R1,[R0]         
        // Pops R4
        POP     {R4}            
        BX      LR             

        .global GetNibble   
GetNibble:          
        LSR     R3,R1,1         
        ADD     R0,R0,R3     
        AND     R2,R1,1     
        LDR     R3,=15     
        LDRB    R1,[R0]         
        CMP     R2,1            
        ITE     EQ              
        LSREQ   R1,R1,4         
        ANDNE   R1,R1,R3  // Instead of LS, we AND R1 and R3 (shifted value, 15)
        MOV     R0,R1        
        BX      LR          

        .end 