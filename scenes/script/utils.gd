class_name IPZScriptUtils


static func get_code_block(main: Statement):
	var command = main.words[0]

	if command in Strings.KEYWORDS_FUNCTION:
		return FunctionCodeBlock.new(main)

	if command in Strings.KEYWORDS_IF:
		return IfCodeBlock.new(main)

	Log.warn("Code block at line", main.line_number, "unidentified:", main.words)
	return CodeBlock.new(main)
