extends Control

@onready var level_container = %LevelContainer
@onready var level_tab = %LevelTab


func _ready():
	var level = preload("res://scenes/levels/level1.tscn")
	var instance = level.instantiate()
	level_container.set_level(instance)

	level_tab.name = "Level 1"
