extends Container


func _get_maximum_content_size():
	var max_size = Vector2()
	for child in get_children():
		var min_size = child.get_level_dimensions()
		max_size = Vector2(max(max_size.x, min_size.x), max(max_size.y, min_size.y))
	return max_size


func _get_relative_content_scale():
	var wanted_size = get_parent_area_size() * 0.85
	var min_size = _get_maximum_content_size()

	var scale_rect = Vector2(wanted_size.x / min_size.x, wanted_size.y / min_size.y)
	var scale_factor = min(scale_rect.x, scale_rect.y)

	return Vector2(scale_factor, scale_factor)


func _get_content_position():
	var available_size = get_parent_area_size()
	var min_size = _get_maximum_content_size()
	return (available_size - min_size) / 2


func _notification(what):
	if what == NOTIFICATION_SORT_CHILDREN:
		# Must re-sort the children
		for child in get_children():
			var content_scale = _get_relative_content_scale()
			child.scale *= content_scale

			var content_position = _get_content_position()
			child.position = content_position


func _on_emulator_resized():
	queue_sort()


func set_level(level: Node2D):
	for child in get_children():
		remove_child(child)

	Log.info("Setting level")
	add_child(level)
