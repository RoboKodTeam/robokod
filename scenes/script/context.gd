class_name ScriptExecutionContext

var _entities: Dictionary = {}


func put_entity(names: Array, entity: Node):
	for name in names:
		_entities[name] = entity


func get_entity(entity_name) -> Node:
	return _entities.get(entity_name)


func reset():
	_entities.clear()
