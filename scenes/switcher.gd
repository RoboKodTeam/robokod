extends Node

var _SCENE_PATH_MAIN = ProjectSettings.get_setting("application/run/main_scene")
const _SCENE_PATH_MENU = "res://scenes/menu/menu.tscn"
const _SCENE_PATH_ADVENTURE = "res://scenes/adventure/adventure.tscn"
const _SCENE_PATH_IDE = "res://scenes/ide/ide.tscn"

var _current_scene = null
var _current_scene_path:
	get:
		return _current_scene.scene_file_path

# Bind callbacks requiring scene to be loaded
signal scene_loaded


func _ready():
	# Get initial Main Scene
	var root = get_tree().root
	_current_scene = root.get_child(root.get_child_count() - 1)


func goto_menu_scene():
	Log.info("Switching to scene: Menu")
	_goto_scene(_SCENE_PATH_MENU)


func goto_adventure_scene():
	Log.info("Switching to scene: Adventure")
	_goto_scene(_SCENE_PATH_ADVENTURE)


func goto_ide_scene(level_name, level_sample, level_resource):
	Log.info("Switching to scene: IDE")

	# When IDE scene is fully loaded, open the required level
	var and_then = func(): _current_scene.open_level(level_name, level_sample, level_resource)

	# Actually load the scene
	_goto_scene(_SCENE_PATH_IDE, and_then)


func _goto_scene(scene_path: String, and_then: Callable = func(): pass):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running
	call_deferred("_deferred_goto_scene", scene_path, and_then)


func _deferred_goto_scene(scene_path: String, and_then: Callable):
	# It is now safe to remove the current scene
	_current_scene.free()

	# Load the new scene
	var scene_resource = ResourceLoader.load(scene_path)
	# Instance the new scene
	_current_scene = scene_resource.instantiate()
	# Add it to the active scene, as child of root
	var tree = get_tree()
	tree.root.add_child(_current_scene)
	# Make it compatible with the SceneTree.change_scene() API
	tree.current_scene = _current_scene

	# Notify all callables scene is loaded
	and_then.call()
	scene_loaded.emit()


func is_scene_main():
	return _SCENE_PATH_MAIN == _current_scene_path
