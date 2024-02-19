extends Node2D

## add PlatformerBlock as child
class_name PlatformerFloor
func _ready():
	eventConnect()
# Called when the node enters the scene tree for the first time.
@onready var player = $"../PlatformerController2D"
@onready var camera = $"../Camera2D"
#func _ready():
#	initFloorByLv(1)
	
#var noFloor = true
#func _process(delta):
#	if noFloor :
#		initFloorByLv(0)
#		noFloor = false

@export var layerGap : int = 25;
@export var fontSize : int = 16;

@export var path : String = "platformer_floor/codeFloor/"


var layerList = []
var curLv

func initFloorByLv(lv,startLine = 0):	
	curLv = lv
	layerList = []
	
	var jsonContent = FileUtils.readJson(path+"floor"+str(lv)+".json")
	var layerNum = len(jsonContent)
	
	for i in range(layerNum):
		layerList.append(null)

	addBoundary()
	
	var oneLayerTime = 0.01
	var aDown = Actions.Schedule.new(oneLayerTime,func(p):
		createLayer(jsonContent[p.curNum],p.curNum)
		p.curNum += 1
		,{"curNum" = startLine},layerNum-startLine)
	aDown.run(self)
	
	if startLine > 0:
		var aUp = Actions.Schedule.new(oneLayerTime,func(p):
			createLayer(jsonContent[p.curNum],p.curNum)
			p.curNum -= 1
			,{"curNum" = startLine-1},startLine)	
		aUp.run(self)
	


var leftBoundary
var rightBoundary

func addBoundary():
	if leftBoundary != null or rightBoundary!= null :
		removeBoundary()

	var rect = RectangleShape2D.new()
	var floorHeight = layerGap*len(layerList)
	var width = 50
	rect.size = Vector2(50,floorHeight*1.5)
	
	leftBoundary = StaticBody2D.new()
	var shapeLeft = CollisionShape2D.new()
	leftBoundary.position = Vector2(0-width/2,floorHeight/2)
	shapeLeft.shape = rect
	leftBoundary.add_child(shapeLeft)
	
	rightBoundary = StaticBody2D.new()
	var shapeRight = CollisionShape2D.new()
	rightBoundary.position = Vector2(get_viewport_rect().size.x+width/2,floorHeight/2)
	shapeRight.shape = rect
	rightBoundary.add_child(shapeRight)
	
	self.add_child(leftBoundary)
	self.add_child(rightBoundary)




	

func removeBoundary():
	if leftBoundary != null:leftBoundary.queue_free()
	if rightBoundary != null:rightBoundary.queue_free()

	leftBoundary = null
	rightBoundary = null


func createLayer(line,lineIndex):
	print("createLayer",lineIndex)
	var layer = PlatformerLayer.new()
	line = addLineIndex(line,lineIndex)
	layer.setBlocks(line,fontSize)
	self.add_child(layer)
	layerList[lineIndex] = layer
	layer.position.y  = layerGap*lineIndex


func clearFloor():
	for layer in layerList:
		if layer != null:
			layer.queue_free()
	removeBoundary()
		
		
	
func addLineIndex(line,index):
	var lIndexStr = str(index+1)
	while len(lIndexStr)<4:
		lIndexStr = " "+lIndexStr
	line.insert(0,[lIndexStr,"line"])
	return line

func getFloorHeight():
	return layerGap*len(layerList)
	
func getLayersInScreen(): 
	var viewRect = get_viewport_rect()
	var maxY = viewRect.position.y + camera.position.y + viewRect.size.y
	var minY = viewRect.position.y + camera.position.y
	
	var layers = []
	for layer in layerList:
		if layer and layer.position.y<= maxY and layer.position.y>=minY:
			layers.append(layer)
	return layers  
	
func getBlocksInScreen():
	var layers = getLayersInScreen()
	var blocks = []
	for layer in layers:
		for block in layer.blockList:
			# fliter empty 
			if block.type != FloorUtils.BlockType.EMPTY and block.type != FloorUtils.BlockType.LINE:
				blocks.append(block)
	return blocks
	
func getLayerBelow(target):
	var pos = target.position
	for layer in layerList:
		if layer.position.y>pos.y:
			var block = layer.getBlockByPosX(pos.x)
			if block!=null:
				return layer

func getLayerAbove(target):
	var pos = target.position
	for i in range(len(layerList)-1,-1,-1):
		var layer = layerList[i]
		if layer.position.y<pos.y:
			var block = layer.getBlockByPosX(pos.x)
			if block!=null:
				return layer

func getBlockBelow(target):
	var pos = target.position
	for layer in layerList:
		if layer!= null and layer.position.y>pos.y:
			var block = layer.getBlockByPosX(pos.x)
			if block!=null:
				return block

func getBlockAbove(target):
	var pos = target.position
	for i in range(len(layerList)-1,-1,-1):
		var layer = layerList[i]
		if layer.position.y<pos.y:
			var block = layer.getBlockByPosX(pos.x)
			if block!=null:
				return block

func getExitLayerBlockAbove(target,blockType):
	var pos = target.position
	var targetHeight = target.getCollisionShape().shape.size.y
	var endBlock
	var endLayerIndex
	var layers = getLayersInScreen()
	for i in range(len(layers)-1,-1,-1):
		var layer = layerList[i]
		if endBlock == null and layer.position.y<pos.y-targetHeight/2:
			var block = layer.getBlockByPosX(pos.x)
			if block!=null and (blockType == null or blockType == block.type):
				endBlock = block
				endLayerIndex = i
				continue
		if endBlock != null and layer.position.y<pos.y-targetHeight/2:
			var block = layer.getBlockByPosX(pos.x)
			if block == null or (blockType != null and blockType != block.type):
				break
			else:
				endBlock = block
				endLayerIndex = i
	if endLayerIndex == null: return null
	var canStayHere = canStay(target,pos.x,layers,endLayerIndex)
	if endBlock == null or (not canStayHere ): return null
	
	return [layers[endLayerIndex],endBlock]
	
func canStay(target,x,layers,layerIndex):
	var targetHeight = target.getCollisionShape().shape.size.y
	var targetWidth = target.getCollisionShape().shape.size.x
	var startY = layers[layerIndex+1].position.y
	
	for i in range(layerIndex,-1,-1):
		var layer = layers[i]
		var widthEnough = layer.isEmpty(x-targetWidth/2,x+targetWidth/2)
		if not widthEnough:
			return false
		var height = startY - layer.position.y
		if widthEnough and height>targetHeight:
			return true
	return false

func isLayerInitOver():
	if len(layerList)==0:return false
	if layerList[0] == null or layerList[-1] == null:return false
	return true

func isOutLvRange(tar):
	if not isLayerInitOver() :return false

	var lastLayerPos = layerList[len(layerList)-1].position
	if tar.global_position.y > lastLayerPos.y + 300:
		return true

	if tar.global_position.x < lastLayerPos.x - 300:
		return true

	if tar.global_position.x > lastLayerPos.x + get_viewport_rect().size.x + 300:
		return true
	
	return false

func eventConnect():
	Events.FloorShakeAndFallStart.connect(floorShakeAndFall)
	Events.FloorShakeAndFallStop.connect(stopFloorShakeAndFall)

	Events.BlockShakeAndFallStart.connect(blockShakeAndFall)
	Events.BlockShakeAndFallStop.connect(stopBlockShakeAndFall)

	Events.BlockExplodeStart.connect(blockExplode)
	Events.BlockExplodeStop.connect(stopBlockExplode)

############## perform FloorShakeAndFall ##########
var scheduleFloorShakeAndFall = null

func floorShakeAndFall():
	var fallingLayers = {}
	var a = Actions.Schedule.new(0.1,func():
		if not player.is_feet_on_ground():return
		var curLayer = getLayerBelow(player)
		if curLayer != null and not fallingLayers.has(curLayer):
			fallingLayers[curLayer] = true
			curLayer.shakeAndFall()
	)
	scheduleFloorShakeAndFall = a.run(self)
	resetResumePerform = self.floorShakeAndFall

func stopFloorShakeAndFall():
	var fallingLayers = {}
	if scheduleFloorShakeAndFall!= null:
		scheduleFloorShakeAndFall.stop()
		resetResumePerform = null


############## perform BlockShakeAndFall ##########
var scheduleBlockShakeAndFall = null

func blockShakeAndFall():
	var fallingBlocks = {}
	var a = Actions.Schedule.new(0.1,func():
		if not player.is_feet_on_ground():return
		var curBlock= getBlockBelow(player)
		if curBlock != null and not fallingBlocks.has(curBlock):
			fallingBlocks[curBlock] = true
			curBlock.shakeAndFall()
	)
	scheduleBlockShakeAndFall = a.run(self)
	resetResumePerform = self.blockShakeAndFall

func stopBlockShakeAndFall():
	var fallingLayers = {}
	if scheduleBlockShakeAndFall!= null:
		scheduleBlockShakeAndFall.stop()
		resetResumePerform = null


############## perform BlockExplode ##########
var scheduleBlockExplode = null

func blockExplode():
	var explodeBlocks = {}
	var a = Actions.Schedule.new(0.1,func():
		var curBlock= getBlockBelow(player)
		if curBlock != null and not explodeBlocks.has(curBlock):
			explodeBlocks[curBlock] = true
			curBlock.shakeAndExplode()
	)
	scheduleBlockExplode = a.run(self)
	resetResumePerform = self.blockExplode

func stopBlockExplode():
	var fallingLayers = {}
	if scheduleBlockExplode!= null:
		scheduleBlockExplode.stop()
		resetResumePerform = null

var resetResumePerform 

func stopPerform():
	stopBlockExplode()
	stopBlockShakeAndFall()
	stopFloorShakeAndFall()
	
func reset():
	var resume = resetResumePerform

	stopPerform()

	for l in layerList:
		if l != null:
			l.reset()

	if resume!=null:
		resume.call()
