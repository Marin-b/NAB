extends Control
class_name SelectableItem

signal pressed

var neighbors := [null, null, null, null]

@onready var active_stylebox : StyleBox = theme.get_stylebox('panel_active', 'PanelContainer')

func select():
	add_theme_stylebox_override('panel', active_stylebox)
	
func deselect():
	remove_theme_stylebox_override('panel')

func selectable_pressed():
	pressed.emit()
