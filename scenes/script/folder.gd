class_name RoboScriptFolder


static func fold(statements: Array[Statement]) -> CodeBlock:
	Log.log("Folding code blocks")

	var iterator = StatementsArrayIterator.new(statements)

	# Fold everything into the root block
	var root_statement = Statement.new(-1, -1, ["function", "root:"])
	var root_block = _group_into_code_block(iterator, root_statement, 0)

	Log.info("Folded code blocks in root:", root_block.children.size())
	return root_block


static func _group_into_code_block(
	iterator: StatementsArrayIterator, main: Statement, level_to_process: int
) -> CodeBlock:
	Log.log("Folding code block at level", level_to_process)

	var out = RoboScriptFolder.get_code_block(main)

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
			last = _group_into_code_block(iterator, last, next.level)
			continue

	# Save the last cached statement
	if last != null:
		out.children.push_back(last)

	return out


static func get_code_block(main: Statement) -> CodeBlock:
	var command = main.words[0]

	if command in Strings.KEYWORDS_FUNCTION:
		return FunctionCodeBlock.new(main)

	if command in Strings.KEYWORDS_IF:
		return IfCodeBlock.new(main)

	Log.warn("Code block at line", main.line_number, "unidentified:", main.words)
	return CodeBlock.new(main)


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
