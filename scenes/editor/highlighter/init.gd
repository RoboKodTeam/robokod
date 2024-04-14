class_name DefaultCodeHighligher
extends CodeHighlighter

var keyword_color = Color("f92672")
var comment_color = Color("75715e")
var string_color = Color("e6db74")


func _init():
	number_color = Color("ae81ff")
	symbol_color = Color("f8f8dc")
	function_color = Color("a6e22d")
	member_variable_color = function_color

	for word in Strings.KEYWORDS:
		add_keyword_color(word, keyword_color)

	add_color_region("#", "", comment_color)
	add_color_region('"', '"', string_color)
