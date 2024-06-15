extends Control

@onready var _tab_container = %TabContainer
@onready var _walls_top_tab = %WallsTopTab
@onready var _walls_vert_tab = %WallsVertTab
@onready var _floor_tab = %FloorTab

@onready var _walls_vert_container = %WallsVertContainer

var _all_elements = []
var _rng = RandomNumberGenerator.new()

signal element_selected(element: ElementContainer)


func _ready():
	_walls_top_tab.name = Strings.TAB_WALLS_TOP
	_walls_vert_tab.name = Strings.TAB_WALLS_VERT
	_floor_tab.name = Strings.TAB_FLOOR

	_collect_all_elements()

	# Connect to each element's signal
	for element: ElementContainer in _all_elements:
		element.connect("toggled", _select_element)


func _collect_all_elements():
	_all_elements.clear()

	# For each tab (even hidden)
	for tab in _tab_container.get_children():
		# Get all tab elements through the tree
		var scroll_container = tab.get_child(0)
		var margin_container = scroll_container.get_child(0)
		var grid_container = margin_container.get_child(0)
		var elements = grid_container.get_children()
		_all_elements.append_array(elements)


func _select_element(toggled: ElementContainer):
	# Deselect all elements other than the toggled
	for element: ElementContainer in _all_elements:
		if toggled != element:
			element.deselect()

	if toggled.selected:
		element_selected.emit(toggled)


func get_random_walls_vert_element() -> ElementContainer:
	var elements = _walls_vert_container.get_children()
	var elements_size = elements.size()

	if elements_size < 2:
		Log.error("Missing walls vert elements in the library")
		return

	if _rng.randi_range(0, 3) > 0:  # 25% chance
		# Default wall is first
		return elements[0]

	var other_elements = elements.slice(1, elements_size)
	var other_index = _rng.randi_range(0, elements_size - 2)
	return other_elements[other_index]
