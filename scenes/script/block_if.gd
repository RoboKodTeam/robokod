class_name IfCodeBlock
extends CodeBlock


func execute(context: ScriptExecutionContext) -> Notice:
	# TODO: Implement expression checking
	for statement in children:
		var notice = await statement.execute(context)

		if notice:
			return notice

	return null
