extends Control

@onready var level_container = %LevelContainer
@onready var level_tab = %LevelTab

@onready var run_button = %RunButton
@onready var rerun_button = %RerunButton
@onready var stop_button = %StopButton


func _ready():
	var level1_resource = preload("res://scenes/levels/level1.tscn")
	open_level(level1_resource, "Level 1.naftascript")


func open_level(resource, title):
	var instance = resource.instantiate()
	level_container.set_level(instance)

	level_tab.name = title


func _on_run_button_pressed():
	run_button.hide()
	rerun_button.show()
	stop_button.show()


func _on_rerun_button_pressed():
	pass


func _on_stop_button_pressed():
	run_button.show()
	rerun_button.hide()
	stop_button.hide()


func _on_minimize_button_pressed():
	Log.info("Minimizing window...")
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)


func _on_close_button_pressed():
	Log.info("Closing application...")
	get_tree().quit()
