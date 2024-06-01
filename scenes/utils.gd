class_name Utils

const _TILE_HALF = Vector2(0.5, 0.5)


static func coord_to_grid(coord: Vector2) -> Vector2i:
	var out = coord / Dimens.TILE_SIZE - _TILE_HALF
	return Vector2i(roundi(out.x), roundi(out.y))


static func grid_to_coord(grid: Vector2i) -> Vector2:
	return (Vector2(grid) + _TILE_HALF) * Dimens.TILE_SIZE


static func string_to_int(string: String, or_else: int) -> int:
	var as_int = string as int
	if string == str(as_int):
		return as_int

	return or_else


static func read_text_file(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	return file.get_as_text()
