extends GameMode

var target_dummy_scene = preload("res://scenes/entities/types/target_dummy/target_dummy.tscn")

@onready var target_dummy = target_dummy_scene.instantiate()
@onready var player = build_player()
# Called when the node enters the scene tree for the first time.

func _ready():
	current_child = start_round()

func get_players_for_shop():
	return [player]
	
func get_players_for_round():
	return [player, target_dummy]
