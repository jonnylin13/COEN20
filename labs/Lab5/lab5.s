    .syntax   unified
    .cpu      cortex-m4
    .text
    .thumb_func
    .align    2

    .global   MyProduct
  MyProduct:
    PUSH      {LR}
    CMP       R0, #0
    IT        EQ
    POPEQ     {PC}
    SUB       R0, R0, #1
    BL        MyProduct
    ADD       R0, R0, R1
    POP       {PC}

    .global   MyFibonacci
MyFibonacci:
    PUSH      {R0, R1, R2, LR}
    CMP       R0, #1
    IT        LE
    BLLE      .fib1
    MOV       R1, R0
    SUB       R0, R0, #1
    BL        MyFibonacci
    SUB       R1, R1, #2
    BL        MyFibonacci
    ADD       R0, R2, R0
    POP       {R0, R1, R2, PC}
.fib1:
    MOV       R0, #0
    POP       {R0, R1, R2, PC}

    .global   MyAckermann
MyAckermann:
    CMP       R0, #0
    IT        LE
    BLE       .ack1
    CMP       R1, #0
    IT        LE
    BLE       .ack2
    SUB       R0, R0, 1
    PUSH      {R0, R1, LR}
    BL        MyAckermann
    POP       {R1, R0}
    SUB       R1, R1, 1
    PUSH      {R2, R1}
    BL        MyAckermann
    POP       {R1, R0, PC}
.ack1:
    MOV       R2, R0
    ADD       R2, R2, R1
    POP       {R0, R1, R2, PC}
.ack2:
    SUB       R1, R1, 1
    PUSH      {R0, R1}
    BL        MyAckermann
    POP       {R1, R0, PC}

