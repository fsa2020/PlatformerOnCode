extends Node

const EMPTY: String = ""
const EMPTY_JSON: String = "{}"

# Checks if a String is empty ("") or null
static func isEmpty(s: String) -> bool:
	return s == null or s.length() == 0

static func isNotEmpty(s: String) -> bool:
	return !isEmpty(s)

# 检查是否为空的字符串
static func isBlank(s: String) -> bool:
	if isEmpty(s):
		return true
	
	if isEmpty(s.strip_edges(true, true)):
		return true
		
	return false
