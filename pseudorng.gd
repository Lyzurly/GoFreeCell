class_name PseudoRNG

#region Microsoft's Original Linear Congruential Generator (LCG)
# Usage of the word "Linear" here represents how the formula's multiplication and addition maintains a single-line for the values to move along, while using "Congruential" is to represent the modulo range that the value will wrap around.

## 32-bits, or 2^31 represented in bitwise. Modulo that limits [param current_state] to an int between 0 and 2,147,483,647, which is later reduced to a range of 0–32767 by the bitwise shift operation.
const MODULUS: int = 1 << 31

## Classic and necessary FreeCell multiplication factor that shifts the state across the [param MODULUS] range. Ensures 1) a good spread of randomness and 2) reproducible deals across various FreeCell games.
const MULTIPLIER: int = 214013 

## Classic and necessary FreeCell addition increment that shifts the state across the [param MODULUS] range to ensure 1) a good spread of randomness and 2) reproducible deals across various FreeCell games.
const INCREMENT: int = 2531011

## Classic and necessary FreeCell bit adjustment that will isolate the 32-bit result's "high" 16 bits by shifting the 32-bit number to the right by 16 steps, and filling the now-empty 16 bits on the left with zeroes. Doing so excises the result's previously "low" 16 bits out of the 32-bit range, thus making the previously high bits the new low bits. Shifting the high bits to excise the low bits ensures 1) a better spread of randomness since the low bits are more likely to repeat, and 2) reproducibility across various FreeCell games since it is how Microsoft also originally determined deal distributions.
const SHIFT_BITS: int = 16

## Initially the seed i.e. the deal number, this represents how that initial value has changed across each call of [method get_number] during its loop.
var current_state: int

## The first state that runs through the RNG. Should be the deal number.
func set_seed(deal_number: int) -> void:
	current_state = deal_number

## Called 52 times, starting with the seed via [param current_state], i.e. the deal number.
## Always returns an [class int] betwen 0 and 32767, which is then modulo'd by its calling function to fit between 0 and the number of cards left -1 (until there are none left).
## Each of the remaining 51 calls randomly evolve the [param current_state] until an array of -- initially 52 -- cards is empty.
func get_number() -> int:
	current_state = (
		MULTIPLIER * current_state + INCREMENT
		) % MODULUS
	
	## Shifts the resultant signed 32-bit int 16 bits right, making the first 16 empty and unused since they are less reliable for good randomness.
	return current_state >> SHIFT_BITS
#endregion
