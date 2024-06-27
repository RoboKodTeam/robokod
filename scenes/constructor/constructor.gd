extends Control

@onready var _library = %ElementsLibrary
@onready var _run_button = %RunButton
@onready var _clear_button = %ClearButton
@onready var _player_x_label = %PlayerXLabel
@onready var _player_x_spin_box = %PlayerXSpinBox
@onready var _player_y_label = %PlayerYLabel
@onready var _player_y_spin_box = %PlayerYSpinBox

@onready var _level = $Level
@onready var _tilemap: LevelTileMap = _level.tilemap
@onready var _tileset: TileSet = _tilemap.tile_set

var _cursor_element: ElementContainer = null


func _ready():
	_run_button.text = Strings.BUTTON_RUN
	_clear_button.text = Strings.BUTTON_CLEAR
	_player_x_label.text = Strings.LABEL_PLAYER_X
	_player_y_label.text = Strings.LABEL_PLAYER_Y

	# Let the player move
	await _level.player.take_off()


func _on_clear_button_pressed():
	_cursor_element = null


func _on_library_element_selected(element: ElementContainer):
	_cursor_element = element


func _on_window_content_gui_input(event):
	if event is InputEvent and event.is_action_pressed("mb_left"):
		_on_try_place_tile()


func _on_try_place_tile():
	var cell_coords = _get_mouse_cell_coords()

	if _cursor_element:
		_place_element(_cursor_element, cell_coords)

		var layer_name = _cursor_element.layer

		if LevelTileMap.LAYER_WALLS_TOP == layer_name:
			var walls_vert_element = _library.get_random_walls_vert_element()
			var tile_pos_below = cell_coords + Vector2(0, 1)
			_place_element(walls_vert_element, tile_pos_below)
	else:
		_erase_elements(cell_coords)


func _get_mouse_cell_coords() -> Vector2:
	var level_scale = _level.scale
	var mouse_at = get_local_mouse_position() / level_scale
	var cell_coords: Vector2 = _tilemap.local_to_map(mouse_at)
	Log.log("Mouse click", mouse_at, "converted to", cell_coords)
	return cell_coords


func _place_element(element: ElementContainer, cell_coords: Vector2):
	var layer_name = element.layer
	var layer_id = _get_layer_id(layer_name)
	var atlas_coords = element.atlas_coords
	var source_id = _get_tile_set_source_id()

	Log.log("Placing element")
	Log.log("  - layer_id:    ", layer_id)
	Log.log("  - cell_coords: ", cell_coords)
	Log.log("  - source_id:   ", source_id)
	Log.log("  - atlas_coords:", atlas_coords)

	_tilemap.set_cell(layer_id, cell_coords, source_id, atlas_coords)


func _erase_elements(cell_coords: Vector2):
	for layer_i in _tilemap.get_layers_count():
		_tilemap.erase_cell(layer_i, cell_coords)


func _get_layer_id(layer_name: String) -> int:
	for layer_i in _tilemap.get_layers_count():
		var compared_name = _tilemap.get_layer_name(layer_i)

		if layer_name == compared_name:
			return layer_i

	Log.error("Layer id by name", layer_name, "not found")
	return -1


func _get_tile_set_source_id() -> int:
	for source_i in _tileset.get_source_count():
		return _tileset.get_source_id(source_i)

	Log.error("Unable to find tile set source id")
	return -1


func _on_run_button_pressed():
	var level_name = Strings.LEVEL_NAME_CUSTOM
	var level_sample = Utils.read_text_file("res://values/samples/level1.txt")

	var level_resource = PackedScene.new()
	level_resource.pack(_level)

	# Open IDE scene and load the required level
	SceneSwitcher.goto_ide_scene(level_name, level_sample, level_resource)


func _on_player_coord_changed(_value):
	var x = _player_x_spin_box.value
	var y = _player_y_spin_box.value

	var pos = Vector2i(x, y)
	Log.log("New player position:", pos)

	await _level.player.move_to(pos)
