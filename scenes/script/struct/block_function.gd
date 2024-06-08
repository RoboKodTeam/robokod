class_name FunctionCodeBlock
extends CodeBlock


func execute(context: ScriptExecutionContext) -> bool:
	for statement in children:
		var execution_successful: bool = await statement.execute(context)

		if not execution_successful:
			return false

	# Execution was successful
	return true


func get_name() -> String:
	return words[1].replace(":", "") if words.size() > 1 else ""


func is_start() -> bool:
	return get_name() in Strings.FUNCTIONS_START
