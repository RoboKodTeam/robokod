class_name Statement

var line_number: int
var level: int
var words: PackedStringArray


func _init(p_line_number: int, p_level: int, p_words: PackedStringArray):
	line_number = p_line_number
	level = p_level
	words = p_words


func execute(context: ScriptExecutionContext) -> Notice:
	var command = words[0]
	var object_names = command.split(".")

	if object_names.size() < 2:
		return Notice.new(self, "У цьому рядку замало слів")

	if object_names.size() > 2:
		return Notice.new(self, "У цьому рядку забагато слів")

	var entity_name = object_names[0]

	var entity = context.get_entity(entity_name)
	if not entity:
		return Notice.new(self, "Не вийшло знайти '" + entity_name + "'")

	var method_name = object_names[1]
	# Core BUG: Doesn't work
	#if entity.has_method(method_name):
	#	return Notice.new(
	#		self, "Не вийшло знайти функцію '" + method_name + "' у '" + entity_name + "'"
	#	)

	var callable = Callable(entity, method_name)

	var arguments = []
	for i in range(1, words.size()):
		arguments.push_back(words[i])

	# Finally call the method of the entity
	Log.log("Calling", method_name, "with", arguments)
	var result = await callable.callv(arguments)
	if result:
		return Notice.new(self, result)

	return null


func to_printable():
	return {line_number = line_number, level = level, words = words}
