        .syntax unified
        .cpu    cortex-m4
        .text


        .global SIMD_USatAdd         
        .thumb_func
        .align
SIMD_USatAdd:                           // void SIMD_USatAdd(uint8_t bytes [], uint32_t count, uint8_t amount) 
        PUSH        {R4-R11}          
        BFI         R2, R2, 8, 8           // Insert 8
        BFI         R2, R2, 16, 16         // Insert 16
loop:
        CMP         R1, 40              // Compare count against 40
        BLT         cleanup             // Branch if count < 40
        LDMIA       R0, {R3-R12}        // Load registers
        UQADD8      R3, R3, R2          // Add amt parallel 10 * 4 bytes
        UQADD8      R4, R4, R2         
        UQADD8      R5, R5, R2         
        UQADD8      R6, R6, R2        
        UQADD8      R7, R7, R2        
        UQADD8      R8, R8, R2        
        UQADD8      R9, R9, R2        
        UQADD8      R10, R10, R2      
        UQADD8      R11, R11, R2      
        UQADD8      R12, R12, R2       
        STMIA       R0!, {R3-R12}       // Store added values
        SUB         R1, R1, 40          // Subtract 40 bytes from count
        B           loop               
cleanup:              
        CBZ         R1, done            // Branch if count is 0
        LDR         R3, [R0]            // Load address in R0
        UQADD8      R3, R3, R2          // Adds bytes to the register to increase saturation
        STR         R3, [R0], 4         // Store result
        SUB         R1, R1, 4           // Decrement Count
        B           cleanup            
done:               
        POP         {R4-R11}         
        BX          LR                 

        .global SIMD_USatSub
        .thumb_func
        .align
SIMD_USatSub:                           // void SIMD_USatSub(uint8_t bytes[], uint32_t count, uint8_t amount) 
        PUSH        {R4-R11}           
        BFI         R2, R2, 8, 8           // Insert 8
        BFI         R2, R2, 16, 16         // Insert 16
uloop:
        CMP         R1, 40               // Compare count against 40
        BLT         ucleanup            // Branch if count < 40
        LDMIA       R0, {R3-R12}         // Load registers
        UQSUB8      R3, R3, R2           
        UQSUB8      R4, R4, R2         
        UQSUB8      R5, R5, R2           
        UQSUB8      R6, R6, R2           
        UQSUB8      R7, R7, R2           
        UQSUB8      R8, R8, R2           
        UQSUB8      R9, R9, R2            
        UQSUB8      R10, R10, R2          
        UQSUB8      R11, R11, R2          
        UQSUB8      R12, R12, R2          
        STMIA       R0!, {R3-R12}        // Store results
        SUB         R1, R1, 40            
        B           uloop               
ucleanup:              
        CBZ         R1, udone           // Compare and branch if count == 0
        LDR         R3, [R0]            // Load register
        UQSUB8      R3, R3, R2          // Subtract bytes from the register to decrease saturation
        STR         R3, [R0], 4         // Store result
        SUB         R1, R1, 4           // Decrement count
        B           ucleanup            
udone:              
        POP         {R4-R11}            
        BX          LR                  


        .end            