class_name ScriptExecutionContext

var _entities: Dictionary = {}


func put_entity(names: Array, entity: ContextEntity):
	for name in names:
		_entities[name] = entity


func get_entity(entity_name: String) -> ContextEntity:
	return _entities.get(entity_name)


func reset():
	_entities.clear()
