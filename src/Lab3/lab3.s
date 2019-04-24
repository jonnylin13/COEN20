  .syntax   unified
  .cpu      cortex-m4
  .text
  .thumb_func
  .align		2

# Each function copies 512 bytes of data
  .global   UseLDRB
UseLDRB:
  # Loads unsigned byte
  .rept   512
  ldrb    R2, [R1], 1
  strb    R2, [R0], 1
  .endr
  bx      lr

  .global   UseLDRH
UseLDRH:
  .rept   256
  # Loads 2-byte unsigned halfword
  ldrh    R2, [R1], 2
  strh    R2, [R0], 2
  .endr
  bx      lr

  .global   UseLDR
UseLDR:
  # Loads 4-byte word
  .rept   128
  ldr     R2, [R1], 4
  str     R2, [R0], 4
  .endr
  bx      lr

  .global   UseLDRD
UseLDRD:
  # Loads 8-byte doubleword
  .rept   64
  ldr     R2, [R1], 8
  strd    R2, [R0], 8
  .endr
  bx      lr

  .global   UseLDMIA
UseLDMIA:
  # Loads multiple at once
  
  push    {R4-R11} # Protected
  .rept   11
  ldmia   R1!, {R2-R12} # 11 4-byte registers = 44 bytes
  stmia   R0!, {R2-R12} # Repeated 11 times = 484 bytes
  .endr

  # Remaining 512-484=28 bytes
  ldmia   R1, {R2-R8}
  stmia   R0, {R2-R8}
  pop     {R4-R11}
  bx      lr

