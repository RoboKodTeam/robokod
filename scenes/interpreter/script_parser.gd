class_name ScriptParser
extends Object


func parse(text: String):
	Log.log("Beginning parsing script")

	var statements = ScriptParser._extract_statements_from(text)
	var notices = ScriptParser._validate(statements)

	Log.log("Parsing finished")
	return notices


static func _extract_statements_from(text: String) -> Array[Statement]:
	Log.log("Extracting code statements")

	var out: Array[Statement] = []

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

		out.push_back(statement)

	return out


class Statement:
	var line_number: int
	var level: int
	var words: PackedStringArray

	func _init(p_line: int, p_level: int, p_words: PackedStringArray):
		line_number = p_line
		level = p_level
		words = p_words

	func to_printable():
		return {line = line_number, level = level, words = words}


static func _validate(statements: Array[Statement]) -> Array:
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
