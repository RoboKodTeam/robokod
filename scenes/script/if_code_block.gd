class_name IfCodeBlock
extends CodeBlock


func execute(env: ScriptEnvironment) -> Notice:
	# TODO: Implement expression checking
	for statement in children:
		var notice = await statement.execute(env)

		if notice:
			return notice

	return null
