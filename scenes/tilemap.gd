extends TileMap


func get_map_dimensions():
	var tile_size = tile_set.tile_size
	var map_rect = get_used_rect().size
	var tile_dimens = Vector2(tile_size.x * map_rect.x, tile_size.y * map_rect.y)
	var map_dimens = Vector2(tile_dimens.x * scale.x, tile_dimens.y * scale.y)
	Log.prn("Map dimensions counted: ", map_dimens)
	return map_dimens
