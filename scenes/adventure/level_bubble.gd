@tool
extends Button

@onready var label = $Label

@export var level_number: int = 99:
	set(value):
		level_number = value
		queue_redraw()
var _level_id:
	get:
		return str(level_number)

@export var label_color = Color(1, 1, 1, 1):
	set(value):
		label_color = value
		queue_redraw()

@export var level_resource: PackedScene


func _ready():
	# Create a copy for each instance
	label.label_settings = label.label_settings.duplicate()


func _draw():
	# Set level bubble text
	label.text = _level_id
	# Apply alpha when button is disabled
	label.label_settings.font_color = Color(label_color, 0.3 if disabled else 1)


func _on_pressed():
	var level_name = Strings.LEVEL_NAME % _level_id
	var level_sample = Utils.read_text_file("res://values/samples/level%s.txt" % _level_id)

	# Open IDE scene and load the required level
	SceneSwitcher.goto_ide_scene(level_name, level_sample, level_resource)
