extends Node

var PROGRAM_TITLE = (
	ProjectSettings.get_setting("application/config/name")
	+ " v"
	+ ProjectSettings.get_setting("application/config/version")
)

const TAB_EMULATOR = "Виконавець коду"
const TAB_EDITOR = "Редактор коду"
const TAB_DOCS = "Документація"

const KEYWORDS_FUNCTION = ["function", "функція"]
const KEYWORDS_IF = ["if", "якщо"]
const KEYWORDS_ELSE = ["else", "інакше"]
const KEYWORDS = KEYWORDS_FUNCTION + KEYWORDS_IF + KEYWORDS_ELSE
const PLAYERS = ["player", "гравець"]
const FUNCTIONS_START = ["start", "почати"]

const ERROR_COLON_MISSING = "Укінці рядка потрібна двокрапка"
const ERROR_COLON_INDENT = "Після двокрапки потрібно відступити вправо"
const ERROR_NOT_FUNCTION = "Цей рядок повинен мати відступ, інакше він не попадає в межі функції"
