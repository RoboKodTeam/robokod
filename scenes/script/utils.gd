class_name RoboScriptUtils


static func get_code_block(main: Statement) -> CodeBlock:
	var command = main.words[0]

	if command in Strings.KEYWORDS_FUNCTION:
		return FunctionCodeBlock.new(main)

	if command in Strings.KEYWORDS_IF:
		return IfCodeBlock.new(main)

	Log.warn("Code block at line", main.line_number, "unidentified:", main.words)
	return CodeBlock.new(main)


static func string_to_int(string: String, or_else: int) -> int:
	var as_int = string as int
	if string == str(as_int):
		return as_int

	return or_else
