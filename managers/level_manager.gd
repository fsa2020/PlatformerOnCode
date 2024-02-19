extends Node2D

@onready var floorNode = $"../PlatformerFloor" 
@onready var trapNode = $"../TrapRoot"
@onready var player = $"../PlatformerController2D"
@onready var colorRect = $"../CanvasLayer/ColorRect"
@onready var camera = $"../Camera2D"

func _ready():
	UserData.loadRecord()
	eventConnect()
	
var isInit = false
var isReborning = false

func _process(delta):
	if not isInit:
		var initLv = UserData.getRecordLv()
		initLevel(initLv)
		isInit = true
	if not isReborning and floorNode.isOutLvRange(player):
		isReborning = true
		playerDead(func():isReborning=false)
		
	refreshSavingPoint()

var curLv = 0
var curPoint = 0
var curSavingPointIndex = 0

func initLevel(level):
	var startLine = TrapCfg.playerPos["lv"+str(level)].line
	floorNode.clearFloor()
	trapNode.clearTrap()
	floorNode.initFloorByLv(level,startLine)
	trapNode.initTrapsByLv(level)
	initPlayerPosByLv(level,1.0)
	curLv = level
	curPoint = 0
	setSavingPointIndex(0)
	UserData.setRecord(level,-1)

func stepIntoLevel(level):
	Events.playEffectSound.emit("Big Egg collect 1.wav")
	UserData.setRecord(curLv,curPoint)
	UserData.setRecord(level,-1)
	UserData.saveRecord()
	var startLine = TrapCfg.playerPos["lv"+str(level)].line
	Actions.Seq.new([
		Actions.FadeOut.new(0.3,func():
			trapNode.reset()
			floorNode.stopPerform()
			floorNode.reset()
			initLevel(level)) ,
		Actions.FadeIn.new(0.5) 
	]).run(colorRect)

func playerDead(finishCallBack = null):
	#to do 
	#1. paly dead animation
	#2. reset traps
	#3. init pos by userdata record saving point
	player.onDead()
	Events.playEffectSound.emit("Boss hit 1.wav")
	Actions.Seq.new([
		Actions.FadeOut.new(0.3,func():
			trapNode.reset()
			floorNode.reset()
			initPlayerPosBySavingPoint()
			player.onReborn()
			if finishCallBack : finishCallBack.call()) ,
		Actions.FadeIn.new(0.5) 
	]).run(colorRect)
	

func setSavingPointIndex(index):
	curSavingPointIndex = index
		
func initPlayerPos(pos,controllerUnenabledTime = 0.1):
	player.setControllerEnabled(false)
	player.position = getPos(pos)
	Actions.Delay.new(controllerUnenabledTime,func():
		player.setControllerEnabled(true)).run(player)
		
func initPlayerPosByLv(lv,controllerUnenabledTime = 0.1):
	player.setControllerEnabled(false)
	player.position = getPos(TrapCfg.playerPos["lv"+str(lv)])
	Actions.Delay.new(controllerUnenabledTime,func():
		player.setControllerEnabled(true)).run(player)

func initPlayerPosBySavingPoint(index = curSavingPointIndex,controllerUnenabledTime = 0.1):
	player.setControllerEnabled(false)
	player.position = getPos(TrapCfg.savingPoints["lv"+str(curLv)][index])
	Actions.Delay.new(controllerUnenabledTime,func():
		player.setControllerEnabled(true)).run(player)
		
func getPos(pos):
	if typeof(pos) == TYPE_VECTOR2:
		return pos
	elif typeof(pos) == TYPE_DICTIONARY:
		var lineIndex = pos.line-1
		var wordIndex = pos.count-1+4
		var offsetV = Vector2(0,0)
		if pos.has("offset"):
			offsetV = pos.offset
		return offsetV + Vector2(
			TrapCfg.singleCharWidth*wordIndex,
			TrapCfg.layerHeight*lineIndex)

func isArrived(tarOffset,approximalSize = Vector2(100,60)):
	return abs(tarOffset.x)<=approximalSize.x and abs(tarOffset.y)<=approximalSize.y 

func refreshSavingPoint():
	if player.is_feet_on_ground():
		var curSavingIndex = UserData.getCurSavingPoint()
		var points = TrapCfg.savingPoints["lv"+str(curLv)]
		var totalNum = len(points)
		var newP = curSavingIndex
		for i in range(curSavingIndex+1,totalNum) :
			if isArrived(player.position-getPos(points[i])):
				newP = i
		UserData.setSavingPoint(newP)
		setSavingPointIndex(newP)

func eventConnect():
	
	Events.StepIntoLv.connect(stepIntoLevel)

