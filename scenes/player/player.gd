extends Node2D

var _character: Player

# Alias with applied conversions to grid coordinates
@export var _position_grid: Vector2i:
	set(value):
		# FIXME: remove
		Log.log("SETTING PLAYER POSITION")
		_character.position = Utils.grid_to_coord(value)
	get:
		return Utils.coord_to_grid(_character.position)


func _init():
	_set_character()


func _set_character():
	var type: String = Preferences.player_character

	Log.info("Loading character scene: %s.tscn" % type)
	var scene = load("res://scenes/player/character/%s.tscn" % type)

	_character = scene.instantiate()
	add_child(_character)


func take_off() -> bool:
	return await _character.take_off()


func land() -> bool:
	return await _character.land()


# Alias with applied conversions to grid coordinates
func move_by(position_grid_delta: Vector2i) -> bool:
	# Get new target
	var target_grid = _position_grid + position_grid_delta

	UserLog.info(Strings.INFO_PLAYER_MOVING % [_position_grid, target_grid])

	# Translate grid movement vector to delta
	var target = Utils.grid_to_coord(target_grid)
	# Pass optional result
	return await _character.move_to(target)
