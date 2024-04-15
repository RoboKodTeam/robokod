extends Node

const KEYWORDS_FUNCTION = ["function", "функція"]
const KEYWORDS_IF = ["if", "якщо"]
const KEYWORDS_ELSE = ["else", "інакше"]
const KEYWORDS = KEYWORDS_FUNCTION + KEYWORDS_IF + KEYWORDS_ELSE

const ERROR_COLON_MISSING = "Укінці рядка потрібна двокрапка"
const ERROR_COLON_INDENT = "Після двокрапки потрібно відступити вправо"
const ERROR_NOT_FUNCTION = "Цей рядок повинен мати відступ, інакше він не попадає в межі функції"

const LEVEL1_CODE = """
#
# Гра починається з головної функції. Тут можна запрограмувати дії гравця щоб пройти рівень. Усі дії гравець виконує послідовно, але будьте обережними, щоб він не врізався в стінку чи не впав!
#

function start(player):
	player.right(2)
	player.down(2)
	player.right()


#
# Щоб гравець реагував на різні непередбачувані події в грі використовуйте функцію ігрового тіку. Таким чином можна дочекатися певної умови за допомогою if і відповісти на неї. Наприклад, якщо в поле зору потрапить жук, гравець одразу піде його зібрати!
#

function tik(player):
	if player.canSeeBugs():
		player.collectBugs()
"""
