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
	SceneSwitcher.goto_adventure_scene()


func _on_constructor_button_pressed():
	SceneSwitcher.goto_constructor_scene()
