extends Control

@onready var tab_container = %TabContainer

var _all_elements = []

signal element_selected(element: ElementContainer)


func _ready():
	_collect_all_elements()

	# Connect to each element's signal
	for element: ElementContainer in _all_elements:
		element.connect("toggled", _select_element)


func _collect_all_elements():
	_all_elements.clear()

	# For each tab (even hidden)
	for tab in tab_container.get_children():
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
