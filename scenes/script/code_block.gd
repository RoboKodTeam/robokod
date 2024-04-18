class_name CodeBlock
extends Statement

var children: Array[Statement] = []


func _init(main: Statement):
	line_number = main.line_number
	level = main.level
	words = main.words


func add(statement: Statement):
	children.push_back(statement)


func execute(_env: ScriptEnvironment) -> Notice:
	Log.error("No behavior defined for this code block")
	return null


func to_printable():
	return {line = line_number, level = level, words = words, children = children}
