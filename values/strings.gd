extends Node

var PROGRAM_NAME = ProjectSettings.get_setting("application/config/name")
var PROGRAM_VERSION = ProjectSettings.get_setting("application/config/version")
#var PROGRAM_TITLE = PROGRAM_NAME + " v" + PROGRAM_VERSION

const MENU_BTN_ADVENTURE = "Пригода"
const MENU_BTN_CONSTRUCTOR = "Конструктор"
const MENU_BTN_SETTINGS = "Налаштування"

const LEVEL_NAME = "Рівень %s"

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

const NOTICE_PLAYER_ALREADY_IN_AIR = "Гравець уже в повітрі"
const NOTICE_PLAYER_NOT_IN_AIR_YET = "Гравець ще не злетів"
const NOTICE_PLAYER_COLLIDED_WITH_OBSTACLE = "Гравець зіткнувся з перешкодою"
