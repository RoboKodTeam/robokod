extends Node2D

@export var player_scene: PackedScene:
	set(value):
		player_scene = value

		_player = player_scene.instantiate()
		add_child(_player)

var _player: Player

# Alias with applied conversions to grid coordinates
@export var position_grid: Vector2i:
	set(value):
		_player.position = Utils.grid_to_coord(value)
	get:
		return Utils.coord_to_grid(_player.position)


# Alias with applied conversions to grid coordinates
func move_by(position_grid_delta: Vector2i):
	# Get new target
	var target_grid = position_grid + position_grid_delta

	Log.log("Moving from", position_grid, "to", target_grid)

	# Translate grid movement vector to delta
	var target = Utils.grid_to_coord(target_grid)
	# Return movement result
	return await _player.move_to(target)
