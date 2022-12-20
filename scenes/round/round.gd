extends Node
class_name round

var players := []
var alive_players := []
var game_mode

signal round_over
# Called when the node enters the scene tree for the first time.
func _ready():
	print('round ready')
	start_round()

func start_round():
	players = game_mode.get_players_for_round()
	var spawn_points = $Map/SpawnPoints.get_children()
	for i in range(0,  players.size()):
		var player = players[i]
		alive_players.append(player)
		player.dead.connect(_on_player_death)
		add_child(player)
		player.spawn(spawn_points[i].position)

func _on_player_death(player : Entity):
	remove_child(player)
	alive_players.erase(player)
	if alive_players.size() == 1:
		call_deferred("end_round")

func end_round():
	for player in alive_players:
		remove_child(player)
	emit_signal("round_over")
