extends VBoxContainer

func show_stats():
	remove_stats()
	for stat in Stats.ALL:
		var label = Label.new()
		var format_string = "{stat}: {amount}"
		var actual_string = format_string.format({"stat": stat.display_name, "amount": owner.player.get(stat.id)})
		label.text = actual_string
		add_child(label)

func remove_stats():
	for n in get_children():
		remove_child(n)
		n.queue_free()
