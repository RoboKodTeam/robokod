class_name Editor
extends CodeEdit

@onready var idle_timer = $IdleTimer

@export var auto_format_on_idle: bool = true
@export var validate_syntax_on_idle: bool = true
var should_run_checks: bool = true:
	set(value):
		should_run_checks = value

		if not should_run_checks:
			idle_timer.stop()

var _lines_with_errors = []


func _input(_event: InputEvent):
	if editable and should_run_checks:
		# Restart idle timer every time any input is given
		idle_timer.start()


func _on_idle_timer_timeout():
	if auto_format_on_idle:
		_format_code()

	if validate_syntax_on_idle:
		_validate_script()


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


func _validate_script():
	_clear_errors()

	var script = get_parsed_script()
	for notice in script.notices:
		# TODO: Create a popup or a panel for notices
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


func get_parsed_script() -> RoboScript:
	var script = RoboScript.new()
	script.parse(text)
	return script
