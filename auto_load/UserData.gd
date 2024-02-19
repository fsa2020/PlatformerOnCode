extends Node

const UserRecordPath : String = "res://user/userRecord.json"

var record = []
var curLv = 0

func initRecord():
	record = []
	for i in range(len(TrapCfg.levels)):
		record.append({
			"lv" = i,
			"locked" = true,
			"scoreNum" = 0,
			"scoreGained" = {},
			"plotGained" = {},
			"savingPoint" = 0
		})
	record[0]["locked"] = false
	
func loadRecord():
	if !FileAccess.file_exists(UserRecordPath):
		# init record
		initRecord()
		saveRecord()
	## 暂时只根据关卡数量校验
	elif len(FileUtils.readJson(UserRecordPath))!=len(TrapCfg.levels):
		initRecord()
		saveRecord()
		
	record = FileUtils.readJson(UserRecordPath)
	return record

func setRecord(lv,point = 0,savingPoint = 0):
	if record!= null:
		record[lv]["locked"] = false
		if point > 0 :
			record[lv]["scoreNum"] = point
		if savingPoint > 0 :
			record[lv]["savingPoint"] = savingPoint
	curLv = lv

func getCurSavingPoint():
	if record!= null:
		return record[curLv]["savingPoint"]
	return 0

func setSavingPoint(savingPoint = 0):
	if record!= null:
		if savingPoint > 0 :
			record[curLv]["savingPoint"] = savingPoint

func saveRecord():
	var json_string = JSON.stringify(record)
	FileUtils.writeStringToFile(UserRecordPath,json_string)

func isScoreGainedInCurLv(id):
	if record[curLv]["scoreGained"].has(id):
		return record[curLv]["scoreGained"][id]
	else:
		return false

func setScoreGainedInCurLv(id):
	record[curLv]["scoreGained"][id] = true


func isPlotGainedInCurLv(name):
	if record[curLv]["plotGained"].has(name):
		return record[curLv]["plotGained"][name]
	else:
		return false

func setPlotGainedInCurLv(name):
	record[curLv]["plotGained"][name] = true
	# saveRecord()
		

func checkSpecifiedRecord(name):
	if record[curLv].has(name):
		return true
	return false

func setSpecifiedRecord(name):
	record[curLv][name] = true

func clearRecord():
	initRecord()
	saveRecord()

func getRecordLv():
	var lv = 0
	for i in range(len(record)):
		if record[i]["locked"] == true: break
		lv = i
	return curLv

