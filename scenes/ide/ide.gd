extends Control

@onready var level_container = %LevelContainer
@onready var level_script_tab = %LevelScriptTab
@onready var level_script_editor = %LevelScriptTab/Editor

@onready var run_button = %RunButton
@onready var rerun_button = %RerunButton
@onready var stop_button = %StopButton


func _ready():
	var level1_resource = preload("res://scenes/levels/level1.tscn")
	open_level(level1_resource, "Level 1")


func open_level(resource, title):
	var instance = resource.instantiate()
	level_container.level = instance

	level_script_tab.name = title

	var sample_file = FileAccess.open("res://values/samples/level1.txt", FileAccess.READ)
	level_script_editor.text = sample_file.get_as_text()


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
