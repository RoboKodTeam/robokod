class_name Level
extends Node2D

@onready var tile_map = $TileMap
@onready var player_container = $PlayerContainer


func get_level_dimensions() -> Vector2:
	var map_dimens = tile_map.get_map_dimensions()
	var level_dimens = Vector2(map_dimens.x * scale.x, map_dimens.y * scale.y)
	return level_dimens


# Must return player implementation
func get_player() -> Player:
	return player_container.get_child(0) as Player
