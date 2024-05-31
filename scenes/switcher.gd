extends Node

const _SCENE_IDE = "res://scenes/ide/ide.tscn"

var _current_scene = null
signal scene_loaded


func _ready():
	# Get initial Main Scene
	var root = get_tree().root
	_current_scene = root.get_child(root.get_child_count() - 1)


func goto_ide(level_name, level_sample, level_resource):
	Log.info("Loading IDE scene")

	# When IDE scene is fully loaded, open the required level
	scene_loaded.connect(
		func(): _current_scene.open_level(level_name, level_sample, level_resource)
	)

	# Try loading the IDE scene
	_goto_scene(_SCENE_IDE)


func _goto_scene(scene_path: String):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running
	call_deferred("_deferred_goto_scene", scene_path)


func _deferred_goto_scene(scene_path: String):
	# It is now safe to remove the current scene
	_current_scene.free()

	# Load the new scene
	var s = ResourceLoader.load(scene_path)
	# Instance the new scene
	_current_scene = s.instantiate()
	# Add it to the active scene, as child of root
	var tree = get_tree()
	tree.root.add_child(_current_scene)
	# Optionally, make it compatible with the SceneTree.change_scene() API
	tree.current_scene = _current_scene

	# Return signal to allow all callables to be executed
	scene_loaded.emit()
