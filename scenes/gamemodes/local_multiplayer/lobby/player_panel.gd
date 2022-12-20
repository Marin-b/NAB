extends PanelContainer

@export var connected: Control
@export var control_panel: PlayerControlPanel
@export var ready_button : CheckButton
@export var label : Label
@export var not_connected : Control

signal ready_updated

var is_ready = false
var device = -1

func _ready():
	ready_button.ready_updated.connect(_on_ready_updated)
	
func device_connected(d):
	device = d
	label.text = 'Player ' + str(device)
	is_ready = false
	not_connected.visible = false
	connected.visible = true
	control_panel.set_device(device)

func device_disconnected():
	not_connected.visible = true
	connected.visible = false
	device = -1
	control_panel.set_device(device)

func _on_ready_updated(ready_signal):
	is_ready = ready_signal
	ready_updated.emit()
