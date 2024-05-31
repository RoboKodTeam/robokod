extends Control

@onready var adventure_button = %MenuButtons/AdventureButton
@onready var constructor_button = %MenuButtons/ConstructorButton
@onready var settings_button = %MenuButtons/SettingsButton


func _ready():
	adventure_button.text = Strings.MENU_BTN_ADVENTURE
	constructor_button.text = Strings.MENU_BTN_CONSTRUCTOR
	settings_button.text = Strings.MENU_BTN_SETTINGS
