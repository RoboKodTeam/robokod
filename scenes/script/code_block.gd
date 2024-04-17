class_name CodeBlock
extends Statement

var children: Array[Statement] = []


func _init(main: Statement):
	line_number = main.line_number
	level = main.level
	words = main.words


func add(statement: Statement):
	children.push_back(statement)


func is_function():
	return Strings.KEYWORDS_FUNCTION.has(words[0])


func is_if():
	return Strings.KEYWORDS_IF.has(words[0])


func to_printable():
	return {line = line_number, level = level, words = words, children = children}
