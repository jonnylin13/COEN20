

    .syntax     unified
    .cpu        cortex-m4
    .align


    .global DecodeMessage
    .thumb_func
    .align
DecodeMessage:        // void DecodeMessage(void *msg, char array[]) 
    PUSH      {R4, R5, R6}
    MOV       R2, R0
    MOV       R3, R1
    B         start
start:
    MOV       R4, 0         // k is R4
    MOV       R5, 0         // bitnum is R5
    B         top
top:
    MOV       R0, R2        // Set parameters for GetBit
    MOV       R1, R5
    B         GetBit
    ADD       R5, R5, 1     // Increment bitnum
    ADD       R4, R4, 1     // Change to 2k + 1 or 2k + 2
    ADD       R4, R4, R0
    LSL       R4, 2
    LDRB      R6, [R3, R4]  // R6 <- array[k]
    CMP       R6, 0
    IT        EQ
    BEQ       top
    CMP       R6, 36
    IT        EQ
    BEQ       done
    MOV       R0, R4
    B         putchar 
    B         start
done:
    POP       {R4, R5, R6}
    BX        LR


    .global GetBit
    .thumb_func
    .align
GetBit:               // int GetBit(void *msg, uint32_t bitnum) 
    SUB       R3, R0, 0x20000000
    LSL       R3, R3, 5
    ADD       R3, R3, R1, LSL 2
    ADD       R3, R3, 0x22000000
    LDRB      R0, [R3]
    BX        LR

