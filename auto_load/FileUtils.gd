extends Node

static func writeStringToFile(filePath: String, content: String) -> void:
	var file = FileAccess.open(filePath, FileAccess.WRITE)
	# bread and butter
	file.store_string(content)
	file = null
	pass
	

static func readFileToString(filePath: String) -> String:
	# make sure our file exists on users system
	if !FileAccess.file_exists(filePath):
		return StringUtils.EMPTY
	
	# allow reading only for file
	var file = FileAccess.open(filePath, FileAccess.READ)
	
	var content = file.get_as_text()
	file = null
	return content

static func readJson(filePath: String):
	var contents = readFileToString(filePath)
	var jsonContent = JSON.parse_string(contents)
	return jsonContent


static func readFileToByteArray(filePath: String) -> PackedByteArray:
	# make sure our file exists on users system
	if !FileAccess.file_exists(filePath):
		return PackedByteArray()
	
	# allow reading only for file
	var file = FileAccess.open(filePath, FileAccess.READ)
	
	var buffer = file.get_buffer(file.get_length())
	file = null
	return buffer
