class_name ManageGameStates extends Node
static var ref: ManageGameStates
func _init() -> void:
	ref = self
	
signal new_game_started(deal_nbr: int, is_challenge_deal: bool)
signal game_won(deal_nbr: int, moves: int, time: int, is_challenge_deal: bool)
