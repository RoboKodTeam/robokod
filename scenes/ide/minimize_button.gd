extends Button


func _on_pressed():
	Log.info("Minimizing window...")
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)
