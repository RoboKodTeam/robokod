@tool
extends Control

@onready var label = $Label

@export var level_number: int = 99:
	set(value):
		level_number = value
		queue_redraw()
var _level_id:
	get:
		return str(level_number)

@export var level_resource: PackedScene


func _draw():
	label.text = _level_id


func _on_pressed():
	var level_name = Strings.LEVEL_NAME % _level_id
	var level_sample = Utils.read_text_file("res://values/samples/level%s.txt" % _level_id)

	# Open IDE scene and load the required level
	SceneSwitcher.goto_ide_scene(level_name, level_sample, level_resource)
