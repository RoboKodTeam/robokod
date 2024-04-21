class_name ScriptExecutor

var _emulator: Emulator
var _editor: Editor

var _context: ScriptExecutionContext = null


func _init(emulator: Emulator, editor: Editor):
	_emulator = emulator
	_editor = editor


func prepare_context():
	Log.log("Preparing execution context")
	_context = ScriptExecutionContext.new()

	_context.put_entity(Strings.PLAYERS, _get_player_entity())


func _get_player_entity() -> ContextEntity:
	var level = _emulator.level
	if not level:
		Log.error("No level loaded into the emulator")
		return null

	var player = level.player
	if not player:
		Log.error("No player found on the level")
		return null

	# Put player into the appropriate adapter
	var player_adapter = PlayerAdapter.new(player)
	return player_adapter


func run():
	if not _context:
		Log.error("Context is not initialized")
		return

	var script = _editor.get_parsed_script()
	if not script:
		Log.warn("Script has not passed validity checks, execution prevented")
		return

	# Temporarily pause any editor checks to improve performance
	_editor.should_run_checks = false

	Log.log("Asking editor to begin script execution")
	await script.begin_execution(_context)

	# TODO: Show notices to the user
	if notice and not _interrupted:
		Log.error(notice.message, "at line", notice.statement.line_number)

	_editor.should_run_checks = true
