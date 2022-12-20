extends PlayerControlPanel
class_name Shop
const stats_options_count = 5;

var stat_scene := preload("res://scenes/shop/stat/stat.tscn")
@onready var money = 10

var player
var is_ready = false

signal ready_updated

func initialize(p):
	player = p
	set_device(player.control.device)
	fill_stats()
	$Player.show_stats()
	
func fill_stats():
	for i in range(0, stats_options_count):
		var stat = stat_scene.instantiate()
		stat.buying.connect(buying_stat)
		$StatsContainer.add_child(stat)


func buying_stat(shop_stat : ShopStat):
	player.set(shop_stat.stat.id, player.get(shop_stat.stat.id) + shop_stat.amount)
	reselect()
	remove_from_selectables(shop_stat.get_selectable())
	$StatsContainer.remove_child(shop_stat)
	shop_stat.queue_free()
	$Player.show_stats()


func _on_check_button_ready_updated(r : bool):
	is_ready = r
	ready_updated.emit()
	
