extends ProgressBar

@onready var core : Entity = get_parent()

func _ready():
	core.current_health_updated.connect(value_updated)
	core.max_health_updated.connect(max_value_updated)

func value_updated(new_value):
	value = new_value

func max_value_updated(new_value):
	max_value = new_value
