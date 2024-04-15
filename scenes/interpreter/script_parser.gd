class_name CustomScript
extends Object

var statements: Array[Statement] = []
var pos: int = 0


func parse(text: String):
	Log.log("Extracting code statements")

	var line_n = -1
	for line in text.split("\n"):
		line_n += 1

		if line.is_empty() or line.begins_with("#"):
			continue

		# Replace tabs with spaces
		line = line.replace("\t", "    ")
		# Get only meaningful words
		var words = line.split(" ", false)

		if words.is_empty():
			continue

		var first_word_index = line.find(words[0])
		# Find out every statement indentation level (btw, allow minor indentation errors)
		var statement_level = (first_word_index + 1) / 4

		# Pack everything into a structure
		var statement = Statement.new(line_n, statement_level, words)
		Log.log("  - statement:", statement)

		statements.push_back(statement)


func validate() -> Array:
	Log.log("Validating statements")

	var out = []

	var last: Statement = null
	for current in statements:
		if last != null:
			# Check for colon after keywords
			if Strings.KEYWORDS.has(last.words[0]):
				if not last.words[-1].ends_with(":"):
					out.push_back({statement = last, message = Strings.ERROR_COLON_MISSING})
					continue

			# Check for next line indentation after colon
			if last.words[-1].ends_with(":"):
				if last.level >= current.level:
					out.push_back({statement = current, message = Strings.ERROR_COLON_INDENT})
					continue

			# Only allow functions as top-level statements
			if current.level == 0:
				if not Strings.KEYWORDS_FUNCTION.has(current.words[0]):
					out.push_back({statement = current, message = Strings.ERROR_NOT_FUNCTION})

		last = current

	Log.log("Collected", out.size(), "notices")
	return out


func collapse_statements() -> Array[Statement]:
	var anonymous_parent = _collapse_code_block(Statement.new(), 0)
	return anonymous_parent.children


func _collapse_code_block(main: Statement, level_to_process: int) -> CodeBlock:
	var out = CodeBlock.new(main)

	var last: Statement = null
	while pos < statements.size():
		var next = statements[pos]

		# End of code block reached
		if next.level < level_to_process:
			break

		# Same level
		if next.level == level_to_process:
			# Save last cached statement
			if last != null:
				out.children.push_back(last)

			# Accept a new statement for future
			last = next

			# Increment current statement index
			pos += 1
			continue

		# Code block statements begin
		if next.level > level_to_process:
			last = _collapse_code_block(last, next.level)
			continue

	# Save the last cached statement
	if last != null:
		out.children.push_back(last)

	return out


class Statement:
	var line_number: int
	var level: int
	var words: PackedStringArray

	func _init(p_line: int = 0, p_level: int = 0, p_words: PackedStringArray = []):
		line_number = p_line
		level = p_level
		words = p_words

	func to_printable():
		return {line = line_number, level = level, words = words}


class CodeBlock:
	extends Statement

	var children: Array[Statement] = []

	func _init(main: Statement):
		line_number = main.line_number
		level = main.level
		words = main.words

	func add(statement: Statement):
		children.push_back(statement)

	func to_printable():
		return {line = line_number, level = level, words = words, children = children}
