extends Control
class_name Lobby

@onready var split_screen : SplitScreen = $SplitScreen
@onready var connected_player_scene = preload("res://scenes/gamemodes/local_multiplayer/lobby/player_panel.tscn") 

const PLAYER_NUM = 4

signal all_ready

func _ready():
	split_screen.initialize(PLAYER_NUM)
	for screen in split_screen.screens:
		var player_panel = connected_player_scene.instantiate()
		player_panel.ready_updated.connect(_on_ready_updated)
		screen.add_child(player_panel)

func _input(event: InputEvent) -> void:
	var device = event.device
	#var just_connected = Engine.get_frames_drawn() - devices_last_connected_at < Engine.get_frames_per_second()
	if !find_panel_by_device(device) && event.is_action('connect'):
		add_player(device)
	elif find_panel_by_device(device) && event.is_action('disconnect'):
		remove_player(device)
			

func add_player(device):
	var empty_panel = find_panel_by_device(-1)
	empty_panel.device_connected(device)

func remove_player(device):
	var panel = find_panel_by_device(device)
	panel.device_disconnected()

func get_panels():
	var panels = []
	for screen in split_screen.screens:
		panels.append(screen.get_children()[0])
	return panels
	
func find_panel_by_device(device):
	var panels = get_panels()
	var target = null 
	for panel in panels:
		if(panel.device == device):
			target = panel
			break
	
	return target
	
func _on_ready_updated():
	var should_start = true
	var players = []
	for panel in get_panels():
		if panel.device != - 1:
			players.append(panel.device)
			if !panel.is_ready:
				should_start = false

	if should_start && players.size() > 1:
		all_ready.emit(players)
	
	
