class_name PlayerController
extends Node2D

@export var player_scene: PackedScene:
	set(value):
		player_scene = value

		_player = player_scene.instantiate()
		add_child(_player)

var _player: Player

# Alias to player position with applied conversions to grid coordinates
@export var position_grid: Vector2i:
	set(value):
		_player.position = Utils.grid_to_coord(value)
	get:
		return Utils.coord_to_grid(_player.position)


# Exposed player movement function
func up(s_steps: String = "1"):
	return await _move(s_steps, Vector2i(0, -1))


# Exposed player movement function
func вверх(s_steps: String = "1"):
	return await up(s_steps)


# Exposed player movement function
func down(s_steps: String = "1"):
	return await _move(s_steps, Vector2i(0, 1))


# Exposed player movement function
func вниз(s_steps: String = "1"):
	return await down(s_steps)


# Exposed player movement function
func left(s_steps: String = "1"):
	return await _move(s_steps, Vector2i(-1, 0))


# Exposed player movement function
func вліво(s_steps: String = "1"):
	return await left(s_steps)


# Exposed player movement function
func right(s_steps: String = "1"):
	return await _move(s_steps, Vector2i(1, 0))


# Exposed player movement function
func вправо(s_steps: String = "1"):
	return await right(s_steps)


func _move(s_steps: String, direction: Vector2i):
	# Parse steps argument
	var steps = Utils.string_to_int(s_steps, 0)
	# Calculate directed movement vector
	var position_grid_delta = direction * steps
	# Get new target
	var target_grid = position_grid + position_grid_delta

	Log.log("Moving from", position_grid, "to", target_grid)

	# Translate grid movement vector to delta
	var target = Utils.grid_to_coord(target_grid)
	# Return error message if passed
	return await _player.move_to(target)
