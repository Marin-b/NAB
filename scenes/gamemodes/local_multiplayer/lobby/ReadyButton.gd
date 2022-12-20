extends CheckButton
class_name ReadyButton

@onready var parent : SelectableItem = get_parent()

signal ready_updated

func _ready():
	update_button()
	
func _on_selectable_pressed():
	button_pressed = !button_pressed
	ready_updated.emit(button_pressed)
	update_button()

func update_button():
	if button_pressed:
		text = '     ready '
	else:
		text = ' not ready '
