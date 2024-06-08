extends Node

const _LEVEL_INFO = 1
const _LEVEL_WARN = 2
const _LEVEL_ERROR = 3

const _PLACEHOLDER = "4417"

var out_node = null


func info(
	msg1: String,
	msg2 = _PLACEHOLDER,
	msg3 = _PLACEHOLDER,
	msg4 = _PLACEHOLDER,
	msg5 = _PLACEHOLDER,
	msg6 = _PLACEHOLDER,
	msg7 = _PLACEHOLDER
):
	var message = _filter_and_merge([msg1, msg2, msg3, msg4, msg5, msg6, msg7])
	_append(_LEVEL_INFO, message)


func warn(
	msg1: String,
	msg2 = _PLACEHOLDER,
	msg3 = _PLACEHOLDER,
	msg4 = _PLACEHOLDER,
	msg5 = _PLACEHOLDER,
	msg6 = _PLACEHOLDER,
	msg7 = _PLACEHOLDER
):
	var message = _filter_and_merge([msg1, msg2, msg3, msg4, msg5, msg6, msg7])
	_append(_LEVEL_WARN, message)


func error(
	msg1: String,
	msg2 = _PLACEHOLDER,
	msg3 = _PLACEHOLDER,
	msg4 = _PLACEHOLDER,
	msg5 = _PLACEHOLDER,
	msg6 = _PLACEHOLDER,
	msg7 = _PLACEHOLDER
):
	var message = _filter_and_merge([msg1, msg2, msg3, msg4, msg5, msg6, msg7])
	_append(_LEVEL_ERROR, message)


func _filter_and_merge(messages) -> String:
	var combined = null

	for m in messages:
		var m_str = str(m)
		if _PLACEHOLDER == m_str:
			break

		if not combined:
			combined = m_str
		else:
			combined += " " + m_str

	return combined


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
