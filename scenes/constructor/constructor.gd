extends Control

@onready var _library = %ElementsLibrary

@onready var _level = $Level
@onready var _tile_map: TileMap = _level.tile_map
@onready var _tile_set: TileSet = _tile_map.tile_set

var _cursor_element: ElementContainer = null


func _on_library_element_selected(element: ElementContainer):
	_cursor_element = element


func _on_window_content_gui_input(event):
	if event is InputEvent and event.is_action_pressed("mb_left"):
		if not _cursor_element:
			return

		var level_scale = _level.scale
		var mouse_at = get_local_mouse_position() / level_scale
		var cell_coords: Vector2 = _tile_map.local_to_map(mouse_at)
		Log.log("Mouse click", mouse_at, "converted to", cell_coords)

		_place_tile(_cursor_element, cell_coords)

		var layer_name = _cursor_element.layer

		if Dimens.LAYER_WALLS_TOP == layer_name:
			var walls_vert_element = _library.get_random_walls_vert_element()
			var tile_pos_below = cell_coords + Vector2(0, 1)
			_place_tile(walls_vert_element, tile_pos_below)


func _place_tile(element: ElementContainer, cell_coords: Vector2):
	var layer_name = element.layer
	var layer_id = _get_layer_id(layer_name)
	var atlas_coords = element.atlas_coords
	var source_id = _get_tile_set_source_id()

	Log.log("Placing tile")
	Log.log("  - layer_id:    ", layer_id)
	Log.log("  - cell_coords: ", cell_coords)
	Log.log("  - source_id:   ", source_id)
	Log.log("  - atlas_coords:", atlas_coords)

	_tile_map.set_cell(layer_id, cell_coords, source_id, atlas_coords)


func _get_layer_id(layer_name: String) -> int:
	for layer_i in _tile_map.get_layers_count():
		var compared_name = _tile_map.get_layer_name(layer_i)

		if layer_name == compared_name:
			return layer_i

	Log.error("Layer id by name", layer_name, "not found")
	return -1


func _get_tile_set_source_id() -> int:
	for source_i in _tile_set.get_source_count():
		return _tile_set.get_source_id(source_i)

	Log.error("Unable to find tile set source id")
	return -1
