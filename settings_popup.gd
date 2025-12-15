class_name SettingsPopup
extends Control

@onready var difficulty: OptionButton = %Difficulty_OptionButton
@onready var max_deal_number: LineEdit = %DealNumber_LineEdit
@onready var autocomplete: OptionButton = %Autocomplete_OptionButton
@onready var color_picker: ColorPickerButton = %ColorPickerButton

@export var background: TextureRect

var player_settings: PlayerSettings

func _ready():
	self.visible = false
	player_settings = PlayerProfile.get_player_profile().player_settings
	difficulty.selected = player_settings.difficulty
	max_deal_number.text = "%s" % player_settings.max_deal_number
	autocomplete.selected = player_settings.auto_complete
	color_picker.color = background.self_modulate

func open():
	max_deal_number.text = "%s" % player_settings.max_deal_number
	self.visible = true

func close():
	self.visible = false

func on_difficulty_selected(_difficulty: int):
	player_settings.difficulty = _difficulty as PlayerSettings.Difficulty
	player_settings.player_settings_changed.emit()

func on_max_deal_number_changed(_max_deal_number: String):
	var nbr = _max_deal_number as int
	if nbr > 0:		
		player_settings.max_deal_number = _max_deal_number as int
		player_settings.player_settings_changed.emit()

func on_autocomplete_selected(_auto_complete: int):
	player_settings.auto_complete = _auto_complete as PlayerSettings.Autocomplete
	player_settings.player_settings_changed.emit()

func on_background_color_selected(color: Color):
	player_settings.background_color = color
	background.self_modulate = color
	player_settings.player_settings_changed.emit()
