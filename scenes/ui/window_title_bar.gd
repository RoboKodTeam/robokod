extends HBoxContainer

@onready var _title_label = $WindowCredentials/TitleLabel

var title: String = "":
	set(value):
		title = value

		_title_label.NOTIFICATION_READY
		_title_label.text = value


func _ready():
	if title.is_empty():
		title = Strings.PROGRAM_NAME


func _on_minimize_button_pressed():
	Log.info("Minimizing window...")
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)


func _on_close_button_pressed():
	Log.info("Closing application...")

	var tree = get_tree()
	tree.root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	tree.quit()
