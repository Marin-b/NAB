extends Entity
class_name ControllableEntity

@onready var control = $Control

func _process(_delta):
	is_attacking = control.is_attacking()
	velocity = control.get_move_direction() * move_speed
	aiming_at = control.get_rotation_angle()

func _physics_process(_delta):
	move_and_slide()
	if is_attacking && weapon:
		weapon.attack()

