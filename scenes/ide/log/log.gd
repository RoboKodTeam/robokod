extends Control

@onready var _label = %RichTextLabel


func append(message: String):
	_label.append_text("%s\n" % message)
