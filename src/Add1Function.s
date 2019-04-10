        .syntax     unified
	.cpu        cortex-m4
        .text


// uint32_t  Add1(uint32_t x) ;

        .global     Add1
        .thumb_func
        .align

Add1:   ADD         R0,R0,1		// Return value of parameter plus 1
        BX          LR

        .end

