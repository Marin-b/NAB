extends Sprite2D

var sprite_index = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]

func _process(_delta):
	var direction = Vector2(cos(owner.aiming_at), sin(owner.aiming_at)).normalized().round()
	var vframe = sprite_index.find(direction)
	if (vframe != -1):
		set("frame_coords", Vector2(0,vframe))
