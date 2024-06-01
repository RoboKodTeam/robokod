extends "res://addons/gd-plug/plug.gd"


func _plugging():
	# [Godot Engine UI]
	# gd-plug UI integration
	plug("imjp94/gd-plug-ui")
	# Script tabs instead of side panel
	plug("MakovWait/godot-script-tabs")
	# Automatic script formatting
	plug("ryan-haskell/gdformat-on-save")
	# Signal visualizer
	plug("Ericdowney/SignalVisualizer")
	# ToDo editor tab
	plug("OrigamiDev-Pete/TODO_Manager", {"exclude": ["addons/Todo_Manager/doc"]})
	# Project time tracker
	plug("victormajida/project-time-tracker")

	# [Development and debugging]
	# Event logger
	plug("russmatney/log.gd", {"include": ["addons/log"]})

# Managed manually
# imjp94/gd-plug
# godotengine/godot-git-plugin
