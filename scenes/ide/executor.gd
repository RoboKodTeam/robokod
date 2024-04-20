class_name ScriptExecutor

var _emulator: Emulator
var _editor: Editor

var _context = ScriptExecutionContext.new()


func _init(emulator: Emulator, editor: Editor):
	_emulator = emulator
	_editor = editor


func prepare_context():
	Log.log("Preparing execution context")

	var level = _emulator.level
	if not level:
		Log.error("No level loaded into the emulator")
		return

	var player = level.get_player()
	if not player:
		Log.error("No player found on the level")
		return

	_context.reset()
	_context.put_entity(Strings.PLAYERS, player)


func run():
	var script = _editor.get_parsed_script()
	if not script:
		Log.warn("Script has not passed validity checks, execution prevented")
		return

	# Temporarily pause any editor checks to improve performance
	_editor.should_run_checks = false

	Log.log("Asking editor to begin script execution")
	await script.begin_execution(_context)

	_editor.should_run_checks = true
