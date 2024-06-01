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
