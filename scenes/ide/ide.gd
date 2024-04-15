extends Control

@onready var window_title = %WindowTitle

@onready var emulator_tab = %EmulatorTab
@onready var emulator = %Emulator

@onready var run_button = %RunButton
@onready var rerun_button = %RerunButton
@onready var stop_button = %StopButton

@onready var editor_tab = %LevelScriptTab
@onready var editor = %LevelScriptTab/Editor
@onready var docs_tab = %DocsTab


func _ready():
	emulator_tab.name = Strings.TAB_EMULATOR
	editor_tab.name = Strings.TAB_EDITOR
	docs_tab.name = Strings.TAB_DOCS

	var level1_resource = preload("res://scenes/levels/level1.tscn")
	open_level(level1_resource, "Рівень 1")


func open_level(level_resource, title):
	# Setup emulator
	emulator.level = level_resource.instantiate()

	# Update window title
	window_title.text = Strings.PROGRAM_TITLE + " | " + title

	# Add sample code to the editor
	var sample_file = FileAccess.open("res://values/samples/level1.txt", FileAccess.READ)
	editor.text = sample_file.get_as_text()


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
