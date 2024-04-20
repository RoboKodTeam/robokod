class_name RoboScriptValidator


static func validate(statements: Array[Statement]) -> Array[Notice]:
	Log.log("Validating statements")

	var out: Array[Notice] = []

	var last: Statement = null
	for current in statements:
		if last != null:
			# Check for colon after keywords
			if last.words[0] in Strings.KEYWORDS:
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
				if current.words[0] not in Strings.KEYWORDS_FUNCTION:
					out.push_back(Notice.new(current, Strings.ERROR_NOT_FUNCTION))

		last = current

	Log.info("Collected notices:", out.size())
	return out
