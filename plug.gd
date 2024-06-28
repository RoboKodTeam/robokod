extends "res://addons/gd-plug/plug.gd"


func _plugging():
	# [[[Engine Features]]]
	# gd-plug UI integration
	plug("imjp94/gd-plug-ui")
	# Script tabs instead of side panel
	plug("MakovWait/godot-script-tabs")
	# Automatic script formatting
	plug("ryan-haskell/gdformat-on-save")
	# Improve script scrolling behavior
	plug("IcterusGames/SimpleScriptScroll")
	# Signal visualizer
	plug("Ericdowney/SignalVisualizer")
	# Find in files dialog
	plug("MakovWait/godot-find-everywhere")
	# ToDo editor tab
	plug("OrigamiDev-Pete/TODO_Manager", {"exclude": ["addons/Todo_Manager/doc"]})
	# Project time tracker
	plug("victormajida/project-time-tracker")

	# [[[Libraries]]]
	# Logger library
	plug("russmatney/log.gd", {"include": ["addons/log"]})

# Managed manually
# imjp94/gd-plug
