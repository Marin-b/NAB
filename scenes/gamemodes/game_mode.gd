extends Node
class_name GameMode

var players : Array
# Called when the node enters the scene tree for the first time.

var player_scene = preload("res://scenes/entities/types/gladiator/gladiator.tscn")

var split_screen_scene = preload("res://scenes/UI/split_screen/split_screen.tscn")

var round_scene = preload("res://scenes/round/round.tscn")

var control_scene = preload("res://scenes/entities/controls/gamepad_control.tscn")
var weapon_scene = preload("res://scenes/weapons/sword/sword.tscn")

# Called when the node enters the scene tree for the first time.
var current_child
var shops = []

func start_round():
	var new_round = round_scene.instantiate()
	new_round.round_over.connect(_on_round_over)
	new_round.game_mode = self
	add_child(new_round)
	return new_round

func start_shop():
	var split_screen = split_screen_scene.instantiate()
	var shop_players = get_players_for_shop()
	split_screen.initialize(shop_players.size())
	for i in range(shop_players.size()):
		var shop = CSF.create_shop(shop_players[i], split_screen.screens[i])
		shop.ready_updated.connect(shop_ready_updated)
		shops.append(shop)
		
	add_child(split_screen)
	return split_screen
	
func _on_round_over():
	current_child.queue_free()
	remove_child(current_child)
	current_child = start_shop()

func shop_over():
	shops = []
	current_child.queue_free()
	remove_child(current_child)
	current_child = start_round()

func shop_ready_updated():
	var done = true
	for shop in shops:
		if !shop.is_ready:
			done = false
	
	if done:
		shop_over()

func build_player(device = 0):
	var instance = player_scene.instantiate()
	var control = control_scene.instantiate()
	control.device = device
	instance.add_child(control)
	instance.add_child(weapon_scene.instantiate())
	return instance


func get_players_for_round():
	return players
	
func get_players_for_shop():
	return players
