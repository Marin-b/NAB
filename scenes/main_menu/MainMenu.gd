extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Practice.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_practice_pressed():
	return launch_practice()


func launch_practice():
	get_tree().change_scene_to_file("res://scenes/gamemodes/practice/practice.tscn")


func _on_local_multiplayer_pressed():
	get_tree().change_scene_to_file("res://scenes/gamemodes/local_multiplayer/local_multiplayer.tscn")
