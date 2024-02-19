extends Panel
class_name PanelPlot
# Called when the node enters the scene tree for the first time.
@onready var player = $"../../PlatformerController2D"
@onready var lvManager = $"../../LevelManager"
@onready var trapRoot = $"../../TrapRoot"
@onready var flooRoot = $"../../PlatformerFloor"

@onready var cLeft = $cLeft
@onready var cRight = $cRight

@onready var wordRect = $WordRect
@onready var wordLabel = $WordRect/Label

var wordRectPosHide
var wordRectPosShow

var cLeftPosHide
var cLeftPosShow

var cRightPosHide
var cRightPosShow

var curLeftId
var curRightId

func _ready():
	size = get_viewport_rect().size
	
	wordRectPosHide = Vector2((self.size.x-wordRect.size.x)/2,size.y + 100)
	wordRectPosShow = Vector2((self.size.x-wordRect.size.x)/2,size.y - 150)

	var characterY = self.size.y*0.66
	var gap = 50
	
	cLeftPosHide = Vector2(-cLeft.texture.get_size().x-gap,characterY)
	cLeftPosShow = Vector2(gap,characterY)

	cRightPosHide = Vector2(self.size.x+gap,characterY)
	cRightPosShow = Vector2(self.size.x-gap-cRight.texture.get_size().x,characterY)
	
	initCharacter()
	initWord()
	self.visible = false

	Events.StartPlot.connect(playByName)


func initCharacter():
	cLeft.position = cLeftPosHide
	cRight.position = cRightPosHide
	
func initWord():
	wordRect.position = wordRectPosHide
	

var plotList
var isInputEnabled = false
	

var wordDisplayAction

## plots[0] = {"word" = "xxx","character" = [id1,id2],"expression" = id,"bg" = "path"}
func playByName(plotName,finishCall = null):
	if not TrapCfg.plots.has(plotName): return 
	startPlot( TrapCfg.plots[plotName].duplicate(),finishCall)

var plotFinishCall = null

func startPlot(plots,finishCall = null):
	if plots == null or len(plots)==0:return	
	plotList = plots
	player.setControllerEnabled(false)
	player.setMoveEnabled(false)
	self.visible = true
	
	var character = [null,null]
	if plots[0].has("character"): character = plots[0]["character"]
	
	var moveTime = 1.0
	
	if character[0]!=null:
		loadCharacterSprite(cLeft,character[0])
		
	if character[1]!=null:
		loadCharacterSprite(cRight,character[0])
	
	# word appear action
	isInputEnabled = false
	Actions.MoveTo.new(wordRectPosShow,moveTime,func():
		isInputEnabled = true).easeOutCirc().run(wordRect)
	
	self.modulate.a = 0
	Actions.FadeOut.new(0.1).run(self)
	
	showPlot(plots[0])
	plotFinishCall = finishCall


func loadCharacterSprite(node,cId):
	pass
	
func endPlot():
	if wordDisplayAction!= null:
		wordDisplayAction.stop()	
		wordDisplayAction = null
		
	Actions.FadeIn.new(0.1).run(self)
	Actions.MoveTo.new(cLeftPosHide,leaveTime).run(cLeft)
	Actions.MoveTo.new(cRightPosHide,leaveTime).run(cRight)
	Actions.MoveTo.new(wordRectPosHide,leaveTime,func ():
		player.setControllerEnabled(true)
		player.setMoveEnabled(true)
		
		if plotFinishCall != null: 
			plotFinishCall.call()
			plotFinishCall = null
	
		isInputEnabled = false
		curLeftId = null
		curRightId = null
		plotList = null
		wordLabel.text = ""
		self.visible = false).run(wordRect)

var leaveTime = 0.2
var comeTime = 0.6

func showPlot(plotData):
	wordDisplayAction = Actions.WordDisplay.new(0.1,plotData["word"],func():
		wordDisplayAction = null
	).run(wordLabel)
	
	var leftId = plotData["character"][0]
	var rightId = plotData["character"][1]
	

	
	if  leftId != curLeftId or rightId != curRightId :
		isInputEnabled = false
	
	if leftId != curLeftId:
	
		if curLeftId == null:
			loadCharacterSprite(cLeft,leftId)
			Actions.MoveTo.new(cLeftPosShow,comeTime,func():
				isInputEnabled = true).run(cLeft)
		else:
			Actions.MoveTo.new(cLeftPosHide,leaveTime,func():
				if leftId == null:return
				loadCharacterSprite(cLeft,leftId)
				Actions.MoveTo.new(cLeftPosShow,comeTime,func():
					isInputEnabled = true).run(cLeft)).run(cLeft)
		curLeftId = leftId

	if rightId != curRightId:
		if curRightId == null:
			loadCharacterSprite(cRight,rightId)
			Actions.MoveTo.new(cRightPosShow,comeTime,func():
				isInputEnabled = true).run(cRight)
		else:
			Actions.MoveTo.new(cRightPosHide,leaveTime,func():
				if rightId == null:return
				loadCharacterSprite(cRight,rightId)
				Actions.MoveTo.new(cRightPosShow,comeTime,func():
					isInputEnabled = true).run(cRight)).run(cRight)
		curRightId = rightId

@export var input_use : String = "use"

func _input(event):
	if Input.is_action_just_pressed(input_use) and isInputEnabled :
		if  wordDisplayAction != null:
			skipWordPlaying()
		else:
			nextPlot()

func skipWordPlaying():
	wordDisplayAction.stop()	
	wordDisplayAction = null
	wordLabel.text = plotList[0]["word"]
	
func nextPlot():
	if len(plotList) <= 1:
		endPlot()
	else:
		plotList.remove_at(0)
		showPlot(plotList[0])
	
