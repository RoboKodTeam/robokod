class_name IPZScriptUtils


static func get_code_block(main: Statement):
	var command = main.words[0]

	if Strings.KEYWORDS_FUNCTION.has(command):
		return FunctionCodeBlock.new(main)

	if Strings.KEYWORDS_IF.has(command):
		return IfCodeBlock.new(main)

	Log.warn("Code block at line", main.line_number, "unidentified:", main.words)
	return CodeBlock.new(main)
