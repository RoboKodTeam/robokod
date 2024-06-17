class_name RoboScriptParser


static func parse(text: String) -> Array[Statement]:
	Log.log("Extracting code statements")

	var out: Array[Statement] = []

	# Start spinning through the lines
	var line_n = -1
	for line in text.split("\n"):
		# Keep track of line numbers
		line_n += 1

		# Skip comments and empty lines
		if line.is_empty() or line.begins_with("#"):
			continue

		# Replace tabs with spaces
		line = line.replace("\t", "    ")
		# Get only meaningful words
		var words = line.split(" ", false)

		# The string happended to only have tabs or spaces
		if words.is_empty():
			continue

		# Find the first word to create a statement
		var first_word_index = line.find(words[0])
		# Find out every statement indentation level (btw, allow minor indentation errors)
		var statement_level = (first_word_index + 1) / 4

		# Pack everything into a structure
		var statement = Statement.new(line_n, statement_level, words)
		Log.log("  - statement:", statement)

		# And push to the back of the list
		out.push_back(statement)

	Log.info("Collected statements:", out.size())
	return out
