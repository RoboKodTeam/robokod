class_name RoboScriptUtils


static func string_to_int(string: String, or_else: int) -> int:
	var as_int = string as int
	if string == str(as_int):
		return as_int

	return or_else
