class_name IDEUtils


static func read_text_file(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	return file.get_as_text()
