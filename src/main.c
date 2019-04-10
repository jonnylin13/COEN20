#include <stdio.h>
#include <stdint.h>
#include "library.h"
#include "intrinsics.h"

extern uint32_t  Add1(uint32_t x) ;

int main(void)
	{
	uint32_t strt, stop, before, after ;

	InitializeHardware(HEADER, "Sample Program") ;

	before = 0 ;
	while (1)  // Never exit
		{
		strt = GetClockCycleCount() ;
		after = Add1(before) ;
		stop = GetClockCycleCount() ;

		printf("Before: a = %u\n", (unsigned) before) ;
		printf(" After: a = %u\n", (unsigned) after) ;
		printf("CPU Clock Cycles: %u\n", (unsigned) (stop - strt)) ;

		WaitForPushButton() ;
		ClearDisplay() ;
		before = after ;
		}
	}
