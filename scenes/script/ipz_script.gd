class_name IPZScript

var script_block: CodeBlock = null


func parse(text: String) -> Array[Notice]:
	var statements = IPZScript._parse_statements(text)

	var notices = IPZScript._validate(statements)

	# No notices - proceed to grouping
	if notices.is_empty():
		script_block = IPZScript._collapse(statements)

	return notices


static func _parse_statements(text: String) -> Array[Statement]:
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

	Log.info("Collected statements:", out.size())
	return out


static func _validate(statements: Array[Statement]) -> Array[Notice]:
	Log.log("Validating statements")

	var out: Array[Notice] = []

	var last: Statement = null
	for current in statements:
		if last != null:
			# Check for colon after keywords
			if Strings.KEYWORDS.has(last.words[0]):
				if not last.words[-1].ends_with(":"):
					out.push_back(Notice.new(last, Strings.ERROR_COLON_MISSING))
					continue

			# Check for next line indentation after colon
			if last.words[-1].ends_with(":"):
				if last.level >= current.level:
					out.push_back(Notice.new(current, Strings.ERROR_COLON_INDENT))
					continue

			# Only allow functions as top-level statements
			if current.level == 0:
				if not Strings.KEYWORDS_FUNCTION.has(current.words[0]):
					out.push_back(Notice.new(current, Strings.ERROR_NOT_FUNCTION))

		last = current

	Log.info("Collected notices:", out.size())
	return out


static func _collapse(statements: Array[Statement]) -> CodeBlock:
	Log.log("Collapsing code blocks")

	var iterator = StatementsArrayIterator.new(statements)

	# Collapse everything into the root block
	var root_statement = Statement.new(-1, -1, ["function", "root():"])
	var root_block = _collapse_code_block(iterator, root_statement, 0)

	Log.info("Collapsed code blocks in root:", root_block.children.size())
	return root_block


static func _collapse_code_block(
	iterator: StatementsArrayIterator, main: Statement, level_to_process: int
) -> CodeBlock:
	Log.log("Collapsing code block at level", level_to_process)

	var out = IPZScriptUtils.get_code_block(main)

	var last: Statement = null
	while iterator.has_next():
		var next = iterator.next()

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
			iterator.increment()
			continue

		# Code block statements begin
		if next.level > level_to_process:
			last = _collapse_code_block(iterator, last, next.level)
			continue

	# Save the last cached statement
	if last != null:
		out.children.push_back(last)

	return out


func execute_script():
	Log.log("Beginning script execution")

	IPZScript._execute(script_block)

	Log.info("Execution finished")


static func _execute(statement: Statement):
	# Identify whether the command is a block
	if statement is FunctionCodeBlock:
		Log.log("Processing function block:", statement.words)
		# Execute child statements as if a function is just a group
		for s: Statement in statement.children:
			_execute(s)
		return

	if statement is IfCodeBlock:
		Log.log("Processing if block:", statement.words)
		return

	if statement is CodeBlock:
		Log.warn("Ignoring unexpected block:", statement.words)
		return

	# Proceed to execution of a single statement otherwise
	Log.log("Not processing single statement:", statement)


class Notice:
	var statement: Statement
	var message: String

	func _init(p_statement: Statement, p_message: String):
		statement = p_statement
		message = p_message


class StatementsArrayIterator:
	var _array: Array[Statement]
	var _pos = 0

	func _init(array: Array[Statement]):
		_array = array

	func has_next() -> bool:
		return _pos < _array.size()

	func next() -> Statement:
		return _array[_pos]

	func increment():
		_pos += 1