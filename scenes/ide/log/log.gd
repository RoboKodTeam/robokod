class_name UserLog
extends Control

const LEVEL_INFO = 1
const LEVEL_WARN = 2
const LEVEL_ERROR = 3

@onready var _label = %RichTextLabel


func info(message: String):
	_append(LEVEL_INFO, message)


func warn(message: String):
	_append(LEVEL_WARN, message)


func error(message: String):
	_append(LEVEL_ERROR, message)


func _append(level: int, message: String):
	# Add the time of the message
	var time = Time.get_datetime_string_from_system(false, true)

	# Get formatted string
	var level_string = _get_level_string(level)

	# Add a newline at the end of each
	_label.text += "[color=SILVER]%s[/color] %s %s\n" % [time, level_string, message]


func _get_level_string(level: int):
	var name = "Unknown"

	match level:
		LEVEL_INFO:
			name = "[color=GREEN]%s[/color]" % Strings.LOG_INFO
		LEVEL_WARN:
			name = "[color=ORANGE]%s[/color]" % Strings.LOG_WARN
		LEVEL_ERROR:
			name = "[color=RED]%s[/color]" % Strings.LOG_ERROR

	return name
