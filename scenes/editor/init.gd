extends CodeEdit

@export var number_color = Color("ae81ff")
@export var symbol_color = Color("f8f8dc")
@export var function_color = Color("a6e22d")
@export var keyword_color = Color("f92672")
@export var comment_color = Color("75715e")
@export var string_color = Color("e6db74")

var keywords = ["func", "if", "else"]


func _ready():
	var h = CodeHighlighter.new()

	h.set_number_color(number_color)
	h.set_symbol_color(symbol_color)
	h.set_function_color(function_color)

	h.set_member_variable_color(function_color)

	for word in keywords:
		h.add_keyword_color(word, keyword_color)

	h.add_color_region("#", "", comment_color)
	h.add_color_region('"', '"', string_color)

	syntax_highlighter = h
