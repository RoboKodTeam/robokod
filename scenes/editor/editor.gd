extends CodeEdit

@onready var idle_timer = $IdleTimer

@export var auto_format_on_idle: bool = true
@export var validate_syntax_on_idle: bool = true

var _lines_with_errors = []


func _input(_event):
	if editable:
		# Restart idle timer every time any input is given
		idle_timer.start()


func _on_idle_timer_timeout():
	if auto_format_on_idle:
		_format_code()

	if validate_syntax_on_idle:
		_validate_syntax()


func _format_code():
	if text.count("\t") > 0:
		# Save scroll progress
		var scroll_progress = Vector2(scroll_horizontal, scroll_vertical)
		# Save caret position
		var caret_pos = Vector2i(get_caret_column(), get_caret_line())
		var caret_line = get_line(caret_pos.y)

		if caret_pos.x > 0:
			# Count tabs prior to caret
			var tabs_count = caret_line.count("\t", 0, caret_pos.x)
			if tabs_count > 0:
				# Update caret coords to leave position unchanged after formatting
				caret_pos.x += tabs_count * (4 - 1)

		# Replace tabs with spaces
		text = text.replace("\t", "    ")

		Log.log("Updating caret position to", caret_pos)
		set_caret_line(caret_pos.y)
		set_caret_column(caret_pos.x)

		# Restore scroll progress
		scroll_vertical = scroll_progress.y
		scroll_horizontal = scroll_progress.x


func _validate_syntax():
	_clear_errors()

	var script = IPZScript.new()
	script.parse(text)

	var notices = script.validate()
	for notice in notices:
		_mark_line_as_flawed(notice.statement.line_number, notice.message)


func _clear_errors():
	for line_number in _lines_with_errors:
		set_line_background_color(line_number, Color(0, 0, 0, 0))

	_lines_with_errors.clear()


func _mark_line_as_flawed(line_number: int, message: String):
	set_line_background_color(line_number, Color("603c3d"))

	# Show hint if caret at the flawed line
	if line_number == get_caret_line():
		set_code_hint(message)
		set_code_hint_draw_below(false)

	_lines_with_errors.push_back(line_number)
