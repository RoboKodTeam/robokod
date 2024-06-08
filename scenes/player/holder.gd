extends Node2D

var _player: Player
@export var player_scene: PackedScene:
	set(value):
		player_scene = value

		_player = player_scene.instantiate()
		add_child(_player)

# Alias with applied conversions to grid coordinates
@export var position_grid: Vector2i:
	set(value):
		_player.position = Utils.grid_to_coord(value)
	get:
		return Utils.coord_to_grid(_player.position)


func take_off() -> bool:
	return await _player.take_off()


func land() -> bool:
	return await _player.land()


# Alias with applied conversions to grid coordinates
func move_by(position_grid_delta: Vector2i) -> bool:
	# Get new target
	var target_grid = position_grid + position_grid_delta

	UserLog.info(Strings.INFO_PLAYER_MOVING % [position_grid, target_grid])

	# Translate grid movement vector to delta
	var target = Utils.grid_to_coord(target_grid)
	# Pass optional result
	return await _player.move_to(target)
