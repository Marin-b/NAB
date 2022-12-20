extends Node

@onready var ALL := []


func _ready():
	load_stat_classes()

func load_stat_classes():
	var dir_path = "res://common/scripts/stats"
	var dir = DirAccess.open(dir_path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		print("Found file: " + file_name)
		var stat = load(dir_path + "/" + file_name)
		ALL.append(stat.new())
		file_name = dir.get_next()
