    .syntax unified
    .cpu cortex-m4
    .text

floatz:   .float  0.0
floatone: .float  1.0

    .global HWFlPtPoly
    .thumb_func
    .align
HWFlPtPoly: //S0 = x, R0 = &a[0], R1 = n
    VLDR        S1, floatz
    VLDR        S2, floatone      // coef
loop:		   
    CBZ         R1, done
    VLDMIA      R0!,{S3}          // S3 = a[i]

    VMLA.F32    S1, S2, S3        // S1 += coef * (x^n)
    VMUL.F32    S2, S0, S2        // x_i-1 + x_i
    SUB         R1, R1, 1         // n--
    B           loop
done:		   
    VMOV        S0, S1
    BX          LR


    .global SWFlPtPoly
    .thumb_func
    .align
SWFlPtPoly:
    // R0 = x, R1 = &a[0], R2 = n
    PUSH        {R4, R5, R6, R7}
    // Copy R0, R1, R2 into R5, R6, R7
    MOV         R5, R0
    MOV         R6, R1
    MOV         R7, R2
    LDR         R3, =0      // SUM
    LDR         R4, =1      // COEF
other_loop:
    CBZ         R7, other_done
    LDMIA       R6!, {R0}
    
    MOV         R2, R4             // R0 should be a[i]
    B           MulFloats          // R1 should be coef
    MOV         R1, R3
    B           AddFloats          // R0 contains coef * x^n, R1 contains SUM
    MOV         R3, R0             // Goes into SUM
    MOV         R0, R5
    MOV         R1, R4 
    B           MulFloats
    MOV         R4, R0             // Goes into COEF
    SUB         R7, R7, 1
    B           other_loop
other_done:
    MOV         R0, R3
    POP         {R4, R5, R6, R7}
    BX          LR

    .global Q16FxdPoly
    .thumb_func
    .align
Q16FxdPoly: //R0 = x, R1 = &a[0], R2 = n
    PUSH        {R4, R5, R6}

    LDR         R3, =0              // coef
    LDR         R4, =0              // lower half
    LDR         R5, =0              // upper half
    LDR         R6, =65536          // X^n
Loop:		   
    CBZ         R2, Done           
    LDR         R3, [R1], 4         // Q16 coef into R3

    SMLAL       R4, R5, R3, R6      // coef * X^n to r4/r5 reg pair of answers
    SMULL       R3, R6, R0, R6      // X^n * x into r3/r6
    LSR         R3, R3, 16          // Get fractional bits
    ORR         R6, R3, R6, LSL 16  // Put in R6 for next loop
    SUB         R2, R2, 1           // n--
    B           Loop
Done:		   
    LSL         R0, R5, 16          // Get fractional bits in R0
    ORR         R0, R0, R4, LSR 16  // Put ans in R0 return reg
    POP         {R4, R5, R6}    
    BX          LR                 
		   
    .end