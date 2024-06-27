class_name LevelTileMap
extends TileMap

const LAYER_WALLS_TOP = "walls_top"
const LAYER_WALLS_VERT = "walls_vert"
const LAYER_FLOOR = "floor"

@onready var TILESET_SOURCE_ID = tile_set.get_source_id(0)


func set_cell_from_default_atlas(layer_name: String, cell_coords: Vector2i, atlas_coords: Vector2i):
	var layer_id = get_layer_id(layer_name)

	Log.log("Setting atlas cell", atlas_coords, "on layer", layer_id, "at", cell_coords)
	set_cell(layer_id, cell_coords, TILESET_SOURCE_ID, atlas_coords)


func erase_cell_at_all_layers(cell_coords: Vector2i):
	for layer_i in get_layers_count():
		erase_cell(layer_i, cell_coords)


func get_layer_id(layer_name: String) -> int:
	for layer_i in get_layers_count():
		var compared_name = get_layer_name(layer_i)

		if layer_name == compared_name:
			return layer_i

	Log.error("Layer id by name", layer_name, "not found")
	return -1

