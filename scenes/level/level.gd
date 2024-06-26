class_name Level
extends Node2D

# Accessed externally by the Executor instance
@onready var player = $Player
@onready var tilemap: LevelTileMap = $LevelTileMap


func get_level_rect() -> Rect2:
	var used_rect = Rect2(tilemap.get_used_rect())
	# Scale level rect
	var pos = _scale(used_rect.position)
	var size = _scale(used_rect.size)
	# Put everithing back into rect
	return Rect2(pos, size)


func _scale(vector: Vector2) -> Vector2:
	# Get scale factors
	var tile_size = tilemap.tile_set.tile_size
	var map_scale = tilemap.scale
	var level_scale = scale
	# Scale at each level
	var tile_dimens = Vector2(vector.x * tile_size.x, vector.y * tile_size.y)
	var map_dimens = Vector2(tile_dimens.x * map_scale.x, tile_dimens.y * map_scale.y)
	var level_dimens = Vector2(map_dimens.x * level_scale.x, map_dimens.y * level_scale.y)
	return level_dimens


func has_player_reached_target_cell() -> bool:
	var player_pos = player.position_grid
	var has_reached = tilemap.is_target_cell(player_pos)
	Log.info("Player", "has" if has_reached else "hasn't", "reached target cell")
	return has_reached
