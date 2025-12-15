class_name ManageGameTimer extends Node
static var ref: ManageGameTimer
func _init() -> void:
	ref = self

var _game_time_ms: int
var _last_update_ms: int
var _running: bool
var _paused: bool

func start_timer():
	_game_time_ms = 0
	_last_update_ms = Time.get_ticks_msec()
	_running = true
	_paused = false
	update_time()

func stop_timer():
	_running = false

func update_time():
	while _running:
		var current_update_ms = Time.get_ticks_msec()
		if !_paused:
			_game_time_ms += 200
			_last_update_ms = current_update_ms
		await get_tree().create_timer(0.2).timeout
		
func get_game_time_ms() -> int:
	return _game_time_ms

func on_focus():
	_last_update_ms = Time.get_ticks_msec()

func _notification(what):
	match what:
		MainLoop.NOTIFICATION_APPLICATION_FOCUS_IN:
			_last_update_ms = Time.get_ticks_msec()
			_paused = false
		MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
			_paused = true
	
