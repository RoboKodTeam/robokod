extends Control

@onready var level_container = %LevelContainer


func _ready():
	var level = preload("res://scenes/levels/level1.tscn")
	var instance = level.instantiate()
	level_container.set_level(instance)
