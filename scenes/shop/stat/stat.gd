extends VBoxContainer
class_name ShopStat


@onready var stats = Stats.ALL
@onready var chosen_stat_index = randi() % stats.size()
@onready var stat = stats[chosen_stat_index]
@onready var multiplier = round(randf_range(1,10)) # TODO Biased rng
@onready var amount = stat.base_amount * multiplier
@export var label : Label

signal buying
# Called when the node enters the scene tree for the first time.
func _ready():
	var format_string = "{stat}: {amount}"
	var actual_string = format_string.format({"stat": stat.display_name, "amount": amount})
	label.text = actual_string

func _on_selectable_item_pressed():
	buying.emit(self)

func get_selectable() -> SelectableItem:
	return $selectable_item
