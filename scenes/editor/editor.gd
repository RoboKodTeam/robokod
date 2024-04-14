extends CodeEdit

@onready var idle_timer = $IdleTimer

@export var perform_idle_syntax_check: bool = false

var _lines_with_errors = []


func _input(_event):
	# Restart idle timer every time any input is given
	if perform_idle_syntax_check:
		idle_timer.start()


func _on_idle_timer_timeout():
	_parse_code_for_errors()


func _parse_code_for_errors():
	clear_errors()

	var parser = ScriptParser.new()
	var notices = parser.parse(text)

	for notice in notices:
		mark_line_as_flawed(notice.statement.line_number, notice.message)


func clear_errors():
	for line_number in _lines_with_errors:
		set_line_background_color(line_number, Color(0, 0, 0, 0))

	_lines_with_errors.clear()


func mark_line_as_flawed(line_number: int, message: String):
	set_line_background_color(line_number, Color("603c3d"))

	# Show hint if caret at the flawed line
	if line_number == get_caret_line():
		set_code_hint(message)
		set_code_hint_draw_below(false)

	_lines_with_errors.push_back(line_number)
