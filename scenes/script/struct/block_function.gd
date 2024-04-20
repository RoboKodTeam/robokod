class_name FunctionCodeBlock
extends CodeBlock


func execute(context: ScriptExecutionContext) -> Notice:
	for statement in children:
		var notice = await statement.execute(context)

		if notice:
			return notice

	return null


func get_name() -> String:
	return words[1].replace(":", "") if words.size() > 1 else ""


func is_start() -> bool:
	return get_name() in Strings.FUNCTIONS_START
