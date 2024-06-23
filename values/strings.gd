extends Node

# Program info
var PROGRAM_NAME = ProjectSettings.get_setting("application/config/name")
var PROGRAM_VERSION = ProjectSettings.get_setting("application/config/version")
#var PROGRAM_TITLE = PROGRAM_NAME + " v" + PROGRAM_VERSION

# Menu
const MENU_BTN_ADVENTURE = "Пригода"
const MENU_BTN_CONSTRUCTOR = "Конструктор"
const MENU_BTN_SETTINGS = "Налаштування"

# IDE
const LEVEL_NAME = "Рівень %s"
const LEVEL_NAME_CUSTOM = "Власний рівень"
const TAB_EMULATOR = "Виконавець коду"
const TAB_LOG = "Журнал виконання"
const TAB_EDITOR = "Редактор коду"
const TAB_EDITOR_PLACEHOLDER = "А Ви ризикові починати з чистого листа. У будь-якому випадку, удачі й натхнення"
const TAB_DOCS = "Документація"
const BUTTON_RUN = "Запустити"
const BUTTON_RERUN = "Перезапустити"
const BUTTON_STOP = "Зупинити"

# Log
const LOG_INFO = "Інформація"
const LOG_WARN = "Зауваження"
const LOG_ERROR = "Помилка   "

# Constructor
const TAB_WALLS_TOP = "Стіни"
const TAB_WALLS_VERT = "Внутрішні стіни"
const TAB_FLOOR = "Підлога"
const TAB_OBJECTS = "Предмети"
const BUTTON_CLEAR = "Очистити"
const LABEL_PLAYER_X = "Розтащування гравця по X"
const LABEL_PLAYER_Y = "Розтащування гравця по Y"

# Parser
const KEYWORDS_FUNCTION = ["function", "функція"]
const KEYWORDS_IF = ["if", "якщо"]
const KEYWORDS_ELSE = ["else", "інакше"]
const KEYWORDS = KEYWORDS_FUNCTION + KEYWORDS_IF + KEYWORDS_ELSE
const PLAYERS = ["player", "гравець"]
const FUNCTIONS_START = ["start", "почати"]

# Validator
const ERROR_COLON_MISSING = "Укінці рядка потрібна двокрапка"
const ERROR_COLON_INDENT = "Після двокрапки потрібно відступити вправо"
const ERROR_NOT_FUNCTION = "Цей рядок повинен мати відступ, інакше він не попадає в межі функції"

# Execution
const INFO_BEGIN = "Початок виконання"
const INFO_END = "Кінець виконання"
const ERROR_NOT_ENOUGH_WORDS = "У рядку %d замало слів"
const ERROR_TOO_MANY_WORDS = "У рядку %d забагато слів"
const ERROR_UNABLE_TO_FIND_ENTITY = "Не вийшло знайти сутність %s"
const UNABLE_TO_FIND_FUNCTION = "Не вийшло знайти функцію %s у %s"
const INFO_PLAYER_MOVING = "Гравець рухається з клітинки %s до клітинки %s"
const ERROR_PLAYER_ALREADY_IN_AIR = "Гравець уже в повітрі"
const ERROR_PLAYER_NOT_IN_AIR_YET = "Гравець ще не злетів"
const ERROR_PLAYER_COLLIDED_WITH_OBSTACLE = "Гравець зіткнувся з перешкодою"
