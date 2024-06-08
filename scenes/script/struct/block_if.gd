class_name IfCodeBlock
extends CodeBlock


func execute(context: ScriptExecutionContext) -> bool:
	# TODO: Implement expression checking
	for statement in children:
		var execution_successful: bool = await statement.execute(context)

		if not execution_successful:
			return false

	# Execution was successful
	return true
