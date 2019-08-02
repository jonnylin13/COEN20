        .syntax     unified
        .cpu        cortex-m4
        .text
        .align       2

        .global     SDIVby13
        .thumb_func
SDIVby13:
        MOV     R1, 13                
        SDIV    R0, R0, R1              
        BX      LR                     

        .global     MySDIVby13
        .thumb_func
MySDIVby13:
        // R0 is signed dividend
        LDR     R1, =0x4EC4EC4F         
        SMMUL   R1, R1, R0              
        ASRS.N  R1, R1, 2               
        ADD     R0, R1, R0, LSR 31    
        BX      LR             


        .global     UDIVby13
        .thumb_func
UDIVby13:
        MOV     R1, 13                 
        UDIV    R0, R0, R1              
        BX      LR                      


        .global     MyUDIVby13
        .thumb_func
MyUDIVby13:
        // R0 is unsigned dividend
        LDR     R1, =0x4EC4EC4F         
        UMULL   R2, R1, R1, R0          
        LSRS.N  R0, R1, 2       
        BX      LR                       
        
        .end