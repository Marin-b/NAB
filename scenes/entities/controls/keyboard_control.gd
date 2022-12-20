extends Node

func get_move_direction():
	return Input.get_vector('left', 'right', 'up', 'down').normalized()

func is_attacking():
	return Input.is_action_pressed('attack')
	
func get_rotation_angle():
	var angle = get_parent().position.angle_to_point(get_viewport().get_mouse_position())
	return angle
	
func is_starting_dash():
	return Input.is_action_pressed('dash')
