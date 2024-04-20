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
@onready var docs = %DocsTab/Editor

@onready var executor = ScriptExecutor.new(emulator, editor)


func _ready():
	emulator_tab.name = Strings.TAB_EMULATOR
	editor_tab.name = Strings.TAB_EDITOR
	docs_tab.name = Strings.TAB_DOCS

	var level1_resource = preload("res://scenes/level/level1.tscn")
	open_level(level1_resource, "Рівень 1")

	docs.text = IDEUtils.read_text_file("res://values/samples/docs.txt")


func open_level(level_resource: Resource, title: String):
	# Setup emulator
	emulator.level = level_resource.instantiate()

	# Update window title
	window_title.text = Strings.PROGRAM_TITLE + " | " + title

	# Add sample code to the editor
	editor.text = IDEUtils.read_text_file("res://values/samples/level1.txt")


func _on_run_button_pressed():
	run_button.hide()
	rerun_button.show()
	stop_button.show()

	executor.prepare_context()
	await executor.run()

	_on_stop_button_pressed()


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
