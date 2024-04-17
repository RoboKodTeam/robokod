class_name Statement

var line_number: int
var level: int
var words: PackedStringArray


func _init(p_line_number: int, p_level: int, p_words: PackedStringArray):
	line_number = p_line_number
	level = p_level
	words = p_words


func to_printable():
	return {line_number = line_number, level = level, words = words}
