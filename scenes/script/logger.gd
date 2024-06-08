extends Node

const _LEVEL_INFO = 1
const _LEVEL_WARN = 2
const _LEVEL_ERROR = 3

var out_node = null


func info(message: String):
	_append(_LEVEL_INFO, message)


func warn(message: String):
	_append(_LEVEL_WARN, message)


func error(message: String):
	_append(_LEVEL_ERROR, message)


func _append(level: int, message: String):
	# Add the time of the message
	var time = Time.get_datetime_string_from_system(false, true)
	# Get formatted string
	var level_string = _get_level_string(level)
	# Combine into log entry
	var entry = "[color=SILVER]%s[/color] %s %s" % [time, level_string, message]
	# Pass it to the log frame
	out_node.append(entry)


func _get_level_string(level: int):
	match level:
		_LEVEL_INFO:
			return "[color=GREEN]%s[/color]" % Strings.LOG_INFO
		_LEVEL_WARN:
			return "[color=ORANGE]%s[/color]" % Strings.LOG_WARN
		_LEVEL_ERROR:
			return "[color=RED]%s[/color]" % Strings.LOG_ERROR
		_:
			return "UNKNOWN"
