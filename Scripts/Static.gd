class_name Static extends Node

## Derived from 2^32 divided by 1000 and then rounded. Used in a bitwise operation to convert ms to seconds (ms/1000) using bitwise math to avoid [class float] -> [class int] conversion.
const BITWISE_DIVISOR_1000: int = 4294967

## Avoids [class float] -> [class int] conversion.
## Scales milliseconds so that when they're shifted right 32 bits (>>), the equivalent of ms/1000 is achieved, converting them into seconds.
static func bitwise_ms_to_s(ms: int) -> int:
	return ms * BITWISE_DIVISOR_1000 >> 32 


## Derived from 2^32 divided by 60 and then rounded. Used in [method bitwise_s_to_m] to convert seconds to minutes (s/60) using bitwise math to avoid [class float] -> [class int] conversion.
const BITWISE_DIVISOR_60: int = 71582788

## Avoids [class float] -> [class int] conversion.
## Scales seconds so that when they're shifted right 32 bits (>>), the equivalent of s/60 is achieved, converting them into minutes.
static func bitwise_s_to_m(seconds: int) -> int:
	return seconds * BITWISE_DIVISOR_60 >> 32
