class_name Statement

var line_number: int
var level: int
var words: PackedStringArray


func _init(p_line_number: int, p_level: int, p_words: PackedStringArray):
	line_number = p_line_number
	level = p_level
	words = p_words


func execute(context: ScriptExecutionContext) -> bool:
	var command = words[0]
	var object_names = command.split(".")

	if object_names.size() < 2:
		UserLog.error("У рядку", line_number, "замало слів")
		return false

	if object_names.size() > 2:
		UserLog.error("У рядку", line_number, "забагато слів")
		return false

	var entity_name = object_names[0]

	var entity = context.get_entity(entity_name)
	if not entity:
		UserLog.error("Не вийшло знайти", entity_name)
		return false

	var method_name = object_names[1]
	# Core BUG: Doesn't work
	#if entity.has_method(method_name):
	#	UserLog.error("Не вийшло знайти функцію", method_name, "у", entity_name)
	#	return false

	var callable = Callable(entity, method_name)

	var arguments = []
	for i in range(1, words.size()):
		arguments.push_back(words[i])

	# Finally call the method of the entity
	Log.log("Calling", method_name, "with", arguments)
	var execution_successful: bool = await callable.callv(arguments)

	return execution_successful


func to_printable():
	return {line_number = line_number, level = level, words = words}
