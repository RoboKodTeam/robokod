extends HBoxContainer

@onready var _title_label = $WindowCredentials/TitleLabel
@onready var _back_button = $WindowControls/BackButton

var title: String = "":
	set(value):
		title = value
		_title_label.text = value


func _ready():
	# Set default program name title
	if title.is_empty():
		title = Strings.PROGRAM_NAME

	_toggle_back_button_visibility()
	SceneSwitcher.scene_loaded.connect(_toggle_back_button_visibility)


func _toggle_back_button_visibility():
	_back_button.visible = not SceneSwitcher.is_scene_main()


func _on_minimize_button_pressed():
	Log.info("Minimizing window...")
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)


func _on_back_button_pressed():
	SceneSwitcher.goto_menu()


func _on_close_button_pressed():
	Log.info("Closing application...")

	var tree = get_tree()
	tree.root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	tree.quit()
