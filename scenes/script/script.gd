class_name RoboScript

var notices: Array[Notice] = []
var _script_block: CodeBlock = null


func parse(text: String):
	var statements = RoboScriptParser.parse(text)
	notices = RoboScriptValidator.validate(statements)

	# No notices - proceed to grouping
	if notices.is_empty():
		_script_block = RoboScriptFolder.fold(statements)


func execute(context: ScriptExecutionContext) -> bool:
	if not _script_block:
		Log.warn("Script has not passed validity checks, execution prevented")
		return false

	for statement in _script_block.children:
		if statement is FunctionCodeBlock:
			if statement.is_start():
				Log.info("Executing start function")
				UserLog.info(Strings.INFO_BEGIN)

				var execution_successful: bool = await statement.execute(context)

				Log.info("Execution finished")
				UserLog.info(Strings.INFO_END)
				return execution_successful

	Log.info("Start function not found")
	return false
