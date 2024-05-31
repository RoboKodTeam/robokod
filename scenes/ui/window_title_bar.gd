extends HBoxContainer

@onready var _title_label = $WindowCredentials/TitleLabel

@export var title: String:
	set(value):
		_title_label.text = value
	get:
		return _title_label.text


func _ready():
	title = Strings.PROGRAM_NAME


func _on_minimize_button_pressed():
	Log.info("Minimizing window...")
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)


func _on_close_button_pressed():
	Log.info("Closing application...")
	get_tree().quit()
