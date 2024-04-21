class_name Level
extends Node2D

@onready var tile_map = $TileMap
@onready var player = $PlayerGridController


func get_level_dimensions() -> Vector2:
	var map_rect = tile_map.get_used_rect().size
	var tile_size = tile_map.tile_set.tile_size
	var map_scale = tile_map.scale

	var tile_dimens = Vector2(map_rect.x * tile_size.x, map_rect.y * tile_size.y)
	var map_dimens = Vector2(tile_dimens.x * map_scale.x, tile_dimens.y * map_scale.y)
	var level_dimens = Vector2(map_dimens.x * scale.x, map_dimens.y * scale.y)
	return level_dimens
