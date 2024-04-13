extends Control

@onready var level_container = $HSplitContainer/EmulatorTabContainer/Emulator/LevelContainer


func _ready():
	var level = preload("res://scenes/levels/level1.tscn")
	var instance = level.instantiate()
	instance.apply_scale(Vector2(2, 2))
	level_container.set_level(instance)
