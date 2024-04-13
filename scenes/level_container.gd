extends Container


func _get_maximum_content_size():
	var max_size = Vector2()
	for child in get_children():
		var min_size = child.get_level_dimensions()
		max_size = Vector2(max(max_size.x, min_size.x), max(max_size.y, min_size.y))
	return max_size


func _get_content_position():
	var min_size = _get_maximum_content_size()
	return (get_parent_area_size() - min_size) / 2


func _notification(what):
	if what == NOTIFICATION_SORT_CHILDREN:
		var content_position = _get_content_position()

		# Must re-sort the children
		for child in get_children():
			child.set_position(content_position)


func _on_emulator_resized():
	Log.info("Emulator resized, asking to redraw")
	queue_sort()


func set_level(level: Node2D):
	for child in get_children():
		remove_child(child)

	add_child(level)
