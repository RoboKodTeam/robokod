extends Control

@onready var window_title_bar = %WindowTitleBar

@onready var emulator_tab = %EmulatorTab
@onready var emulator = %Emulator

@onready var run_button = %RunButton
@onready var rerun_button = %RerunButton
@onready var stop_button = %StopButton

@onready var log_tab = %LogTab
@onready var editor_tab = %LevelScriptTab
@onready var editor = %LevelScriptTab/Editor
@onready var docs_tab = %DocsTab
@onready var docs = %DocsTab/Editor

@onready var _executor = ScriptExecutor.new(emulator, editor)


func _ready():
	emulator_tab.name = Strings.TAB_EMULATOR
	log_tab.name = Strings.TAB_LOG
	editor_tab.name = Strings.TAB_EDITOR
	editor.placeholder_text = Strings.TAB_EDITOR_PLACEHOLDER
	docs_tab.name = Strings.TAB_DOCS

	docs.text = Utils.read_text_file("res://values/samples/docs.txt")


func open_level(level_name: String, level_sample: String, level_resource: Resource):
	Log.info("Opening level")
	Log.info("  - level_name:    ", level_name)
	Log.info("  - level_resource:", level_resource)

	# Update window title
	window_title_bar.title = level_name
	# Add sample code to the editor
	editor.text = level_sample
	# Setup emulator
	emulator.level = level_resource.instantiate()


func _on_run_button_pressed():
	run_button.hide()
	rerun_button.show()
	stop_button.show()

	# Prepare context for the script to run within
	_executor.prepare_context()
	# Await for executor to finish
	await _executor.run()

	_on_stop_button_pressed()


func _on_rerun_button_pressed():
	pass


func _on_stop_button_pressed():
	_executor.interrupt()

	run_button.show()
	rerun_button.hide()
	stop_button.hide()
