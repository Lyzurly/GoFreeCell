class_name ManageAudio extends Node
static var ref: ManageAudio
func _init() -> void:
	ref = self

const _SOUNDS_DIRECTORY: String = "res://audio/"
var _sounds_array: Array[AudioStreamWAV]

enum SOUND_NAMES {CARD_HARD,CARD_SOFT}

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	_ready_sounds()

func _ready_sounds() -> void:
	var directory: DirAccess = DirAccess.open(_SOUNDS_DIRECTORY)
	for audio_path: String in directory.get_files():
		if audio_path.right(4) == ".wav":
			_sounds_array.append(load(_SOUNDS_DIRECTORY + "/" + audio_path))
	
func play_sound(sound_name: SOUND_NAMES) -> void:
	var sound_name_string: String = SOUND_NAMES.find_key(sound_name)
	var file_name_to_find: String = sound_name_string.to_lower() + ".mp3"
	var _sound_to_play: AudioStreamWAV
	
	for file: AudioStreamWAV in _sounds_array:
		if file.resource_path.contains(file_name_to_find):
			_sound_to_play = file
			audio_stream_player.stream = file
			audio_stream_player.play()
