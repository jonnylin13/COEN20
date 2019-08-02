  .syntax   unified
  .cpu      cortex-m4
  .text

  .thumb_func
  .align		2
  .global   UseLDRB
UseLDRB:
  .rept   512
  ldrb    R2, [R1], 1
  strb    R2, [R0], 1
  .endr
  bx      lr

  .thumb_func
  .align		2
  .global   UseLDRH
UseLDRH:
  .rept   256
  ldrh    R2, [R1], 2
  strh    R2, [R0], 2
  .endr
  bx      lr

  .thumb_func
  .align		2
  .global   UseLDR
UseLDR:
  .rept   128
  ldr     R2, [R1], 4
  str     R2, [R0], 4
  .endr
  bx      lr

  .thumb_func
  .align		2
  .global   UseLDRD
UseLDRD:
  .rept   64
  ldrd    R2, [R1], 8
  strd    R2, [R0], 8
  .endr
  bx      lr

  .thumb_func
  .align		2
  .global   UseLDMIA
UseLDMIA:
  push    {R4-R11}
  .rept   11
  ldmia   R1!, {R2-R12}
  stmia   R0!, {R2-R12}
  .endr

  ldmia   R1, {R2-R8}
  stmia   R0, {R2-R8}
  pop     {R4-R11}
  bx      lr

  .end

