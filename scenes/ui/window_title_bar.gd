extends MarginContainer

@onready var _title_label = %TitleLabel
@onready var _back_button = %BackButton

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
	Log.info("  - current mode:", DisplayServer.window_get_mode())

	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)

	Log.info("  - new mode:    ", DisplayServer.window_get_mode())


func _on_back_button_pressed():
	SceneSwitcher.goto_menu_scene()


func _on_close_button_pressed():
	Log.info("Closing application...")

	var tree = get_tree()
	tree.root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	tree.quit()
