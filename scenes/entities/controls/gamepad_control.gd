extends Node

var previous_rota := Vector2.ZERO
var device : int = 0

func get_left_joystick_value():
	return Vector2(Input.get_joy_axis(device, JOY_AXIS_LEFT_X), Input.get_joy_axis(device, JOY_AXIS_LEFT_Y))
	
func get_right_joystick_value():
	return Vector2(Input.get_joy_axis(device, JOY_AXIS_RIGHT_X), Input.get_joy_axis(device, JOY_AXIS_RIGHT_Y))
	
func get_move_direction():
	return get_left_joystick_value().normalized()

func is_attacking():
	return get_right_joystick_value() != Vector2.ZERO
	
func get_rotation_angle():
	var rota = get_right_joystick_value()
	if rota == Vector2.ZERO:
		rota = get_move_direction()
	if rota == Vector2.ZERO:
		return previous_rota.angle()
	previous_rota = rota
	return rota.angle()
	
func is_starting_dash():
	return Input.is_action_pressed('dash')
