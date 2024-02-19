extends Node

const UserSettingPath : String = "res://user/userSetting.json"

var setting = {}

func initSetting():
	setting = {
		"global music volume" = 1.0,
		"back ground music volume" = 0.5,
		"effect sound volume" = 0.5,}

func loadSetting():
	if !FileAccess.file_exists(UserSettingPath):
		# init record
		initSetting()
		saveSetting()
		
	setting = FileUtils.readJson(UserSettingPath)
	return setting


func saveSetting():
	var json_string = JSON.stringify(setting)
	FileUtils.writeStringToFile(UserSettingPath,json_string)

func setGlobalMusicVolume(v):
	if v>1: v = 1
	if v<0: v = 0
	setting["global music volume"] = v

func setBgmVolume(v):
	if v>1: v = 1
	if v<0: v = 0
	setting["back ground music volume"] = v
	
func getBgmVolume():
	return setting["global music volume"]*setting["back ground music volume"]
	
func setEffectSoundVolume(v):
	if v>1: v = 1
	if v<0: v = 0
	setting["effect sound volume"] = v
	
func getEffectSoundVolume():
	return setting["global music volume"]*setting["effect sound volume"]
