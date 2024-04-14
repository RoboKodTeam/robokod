extends Node2D

@onready var tile_map = $TileMap


func get_level_dimensions():
	var map_dimens = tile_map.get_map_dimensions()
	var level_dimens = Vector2(map_dimens.x * scale.x, map_dimens.y * scale.y)
	return level_dimens
