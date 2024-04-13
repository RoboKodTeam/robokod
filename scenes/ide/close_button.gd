extends Button


func _on_pressed():
	Log.info("Closing application...")
	get_tree().quit()
