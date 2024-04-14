extends Control

@onready var level_container = %LevelContainer
@onready var level_tab = %LevelTab


func _ready():
	var level1_resource = preload("res://scenes/levels/level1.tscn")
	open_level(level1_resource, "Level 1")


func open_level(resource, title):
	var instance = resource.instantiate()
	level_container.set_level(instance)

	level_tab.name = title
