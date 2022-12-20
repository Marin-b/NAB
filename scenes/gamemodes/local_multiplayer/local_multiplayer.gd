extends GameMode
class_name LocalMultiplayer

var lobby_scene = preload('res://scenes/gamemodes/local_multiplayer/lobby/lobby.tscn')
@onready var lobby : Lobby = lobby_scene.instantiate()

func _ready():
	lobby.all_ready.connect(start_game)
	add_child(lobby)
	
	
func start_game(player_devices):
	for device in player_devices:
		players.append(build_player(device))
	
	remove_child(lobby)
	current_child = start_round()
