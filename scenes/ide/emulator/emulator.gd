class_name Emulator
extends Container

var level: Level:
	set(value):
		for child in get_children():
			remove_child(child)

		Log.info("Setting level")
		add_child(value)
		queue_sort()
	get:
		var children = get_children()
		return null if children.is_empty() else children[0]


func _on_resized():
	queue_sort()


func _notification(what):
	if what == NOTIFICATION_SORT_CHILDREN:
		# Must re-sort the children
		for child in get_children():
			var content_scale = _get_relative_content_scale()
			child.scale *= content_scale

			var content_position = _get_content_position()
			child.position = content_position


func _get_relative_content_scale():
	var wanted_size = get_parent_area_size() * 0.85
	var level_size = _get_level_rect().size

	var scale_rect = Vector2(wanted_size.x / level_size.x, wanted_size.y / level_size.y)
	var scale_factor = min(scale_rect.x, scale_rect.y)

	return Vector2(scale_factor, scale_factor)


func _get_content_position():
	# Get emulator size
	var emulator_size = get_parent_area_size()
	# Measure level dimens
	var level_rect = _get_level_rect()
	var level_size = level_rect.size
	var level_offset = level_rect.position
	# Calculate content position
	var content_position = (emulator_size - level_size) / 2 - level_offset
	return content_position


func _get_level_rect() -> Rect2:
	if level == null:
		Log.warn("No level in the emulator, returning Rect.ZERO")
		return Rect2(0, 0, 0, 0)

	return level.get_level_rect()
