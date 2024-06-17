@tool
class_name ElementContainer
extends PanelContainer

const BOX_NORMAL = preload("res://themes/element/box_normal.tres")
const BOX_FOCUS = preload("res://themes/element/box_focus.tres")

@onready var _texture_rect = %TextureRect

@export var atlas: CompressedTexture2D:
	set(value):
		atlas = value
		queue_redraw()
@export var atlas_coords: Vector2i:
	set(value):
		atlas_coords = value
		queue_redraw()

@export_enum(Dimens.LAYER_WALLS_TOP, Dimens.LAYER_WALLS_VERT, Dimens.LAYER_FLOOR) var layer: String

@export var selected: bool = false:
	set(value):
		selected = value
		queue_redraw()

# The element state was just changed
signal toggled(element: ElementContainer)


func _draw():
	if not atlas:
		return

	var texture = AtlasTexture.new()
	texture.atlas = atlas

	var pos = atlas_coords * Dimens.TILE_SIZE
	var rect = Vector2(Dimens.TILE_SIZE, Dimens.TILE_SIZE)
	texture.region = Rect2(pos, rect)

	_texture_rect.texture = texture


func _on_gui_input(event):
	if event is InputEvent and event.is_action_pressed("mb_left"):
		toggle()


func toggle():
	if not selected:
		select()
	else:
		deselect()

	toggled.emit(self)


func select():
	selected = true
	add_theme_stylebox_override("panel", BOX_FOCUS)


func deselect():
	selected = false
	add_theme_stylebox_override("panel", BOX_NORMAL)
