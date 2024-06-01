extends Control

@onready var program_name_label = %ProgramNameLabel
@onready var adventure_button = %AdventureButton
@onready var constructor_button = %ConstructorButton
@onready var settings_button = %SettingsButton


func _ready():
	program_name_label.text = Strings.PROGRAM_NAME
	adventure_button.text = Strings.MENU_BTN_ADVENTURE
	constructor_button.text = Strings.MENU_BTN_CONSTRUCTOR
	settings_button.text = Strings.MENU_BTN_SETTINGS


func _on_adventure_button_pressed():
	var level_name = "Рівень 1"
	var level_sample = Utils.read_text_file("res://values/samples/level1.txt")
	var level_resource = preload("res://scenes/level/level1.tscn")

	# Open IDE scene and load the required level
	SceneSwitcher.goto_ide(level_name, level_sample, level_resource)
