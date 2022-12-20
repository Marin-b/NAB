extends Node2D


@onready var core : Entity = get_parent()
@onready var animation_player : AnimationPlayer = $AnimationPlayer

var animation = "Idle"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	set_global_rotation(core.velocity.angle())
	if core.velocity == Vector2.ZERO:
		animation = "Idle"
	else:
		animation = "Walk"

	if animation_player.get_current_animation() != animation:
		animation_player.play(animation)
