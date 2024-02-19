extends Node2D

## add PlatformerBlock as child
class_name PlatformerBlock

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not isAddBody:
		addBody()
		# playShake()
		# Actions.Delay.new(2.0,func():
		# 	stopShake()
		# 	playFall()).run(self)

var label
var body
var shape
var isAddBody = false
var type

var grabAreaRight
var grabAreaLeft

var trapTipVisible = true

var isOrgFloorBlock = true

func setContent(content,fontSize):
	# print(content)
	isAddBody = false
	addLabel(content,fontSize)

func addLabel(content,size):
	self.name = content[0]+str(self)
	label = Label.new()
	label.text = content[0]

	if FloorUtils.SIMPIFY_TYPE.has(content[1]):
		type =  FloorUtils.SIMPIFY_TYPE[content[1]]
		if type ==  FloorUtils.BlockType.NAME:
			if len(content) > 2:
				if content[2][0] == ' ' or content[2][0] == ':':
					type = FloorUtils.BlockType.NC
				elif content[2][0] == '(' :
					type = FloorUtils.BlockType.NF
		# do with diff name 
		
		# print("colorIndex",colorIndex)
	else:
		type = FloorUtils.BlockType.OTHER

	var ls = LabelSettings.new() 

	ls.set_font_color(FloorUtils.TYPE_COLOR[type]) 
	# print("TYPE_COLOR",FloorUtils.TYPE_COLOR[colorIndex])
	ls.set_font_size(size) 
	var f = FontFile.new()
	f.load_dynamic_font("res://asset/fonts/cmu-typewriter/Typewriter/cmuntb.ttf")
	ls.font = f
	label.label_settings = ls
	# label.font_size = size
	self.add_child(label)
	
	if isTrapTip() : label.visible = trapTipVisible
	

func isTrapTip():
	var tLen = len(label.text)
	return tLen>4 and label.text[0]=='/' and label.text[1]=='*' and label.text[tLen-1]=='/' and label.text[tLen-2]=='*'

func isSmoothWall():
	var tLen = len(label.text)
	return tLen==4 and label.text[0]=='/' and label.text[1]=='*' and label.text[tLen-1]=='/' and label.text[tLen-2]=='*'

func addBody():
	if type == FloorUtils.BlockType.EMPTY or isTrapTip(): return
	
	addStaticBody()
	if type != FloorUtils.BlockType.LINE and (not isSmoothWall()): 
		addGrabArea()
#	var w = label.size.x/len(label.text)
#	print("singleCharWidth",w)
	
	isAddBody = true
	
func addStaticBody():
	body = StaticBody2D.new()
	shape = CollisionShape2D.new()

	self.add_child(body)
	body.add_child(shape)

	var rect = RectangleShape2D.new()
	rect.size = label.get_rect().size
	rect.size.y -= 8
	shape.shape = rect
	shape.position = Vector2(rect.size.x / 2, rect.size.y / 2)
	
func addGrabArea():
	var size = shape.shape.size
	var rect = Vector2(2,size.y)
	# right  area
	grabAreaRight = GrabArea.new()
	grabAreaRight.setShape(rect)
	grabAreaRight.position = Vector2(size.x-1, 0)
	self.add_child(grabAreaRight)
	# left  area
	grabAreaLeft = GrabArea.new()
	grabAreaLeft.setShape(rect)
	grabAreaLeft.position = Vector2(-1,0)
	self.add_child(grabAreaLeft)
	
func clone():
	var block = PlatformerBlock.new()
	block.label = self.label.duplicate()
	block.add_child(block.label)
	
	block.body =  self.body.duplicate()
	block.add_child(block.body)
	
	block.shape =  self.shape.duplicate()
	block.body.add_child(block.shape)
	
	block.type =  self.type
	
#	block.grabAreaRight = self.grabAreaRight.duplicate()
#	block.grabAreaLeft = self.grabAreaLeft.duplicate()
	block.isAddBody = true
	block.isOrgFloorBlock = false
#	block.addGrabArea()
	return block

var rng = RandomNumberGenerator.new()
var actionShake

func playShake():
	if actionShake!= null:return


	var randX =  rng.randf_range(-10.0, 10.0)
	var randY =  rng.randf_range(-5.0, 5.0)
	
	var move1 = Actions.MoveBy.new(Vector2(randX,randY),0.02)
	var move2 = Actions.MoveBy.new(Vector2(-randX,-randY),0.02)
	
	actionShake = Actions.Seq.new([
		move1,move2
	],func():
		stopShake()
		playShake()
	).run(label)

func stopShake():
	if actionShake == null:return
	actionShake.stop()
	actionShake = null
	
var actionFall
func playFall():
	if actionFall!= null:return
	var randX =  rng.randf_range(-10.0, 10.0)
	var randY =  rng.randf_range(300.0,200.0)
	var move1 = Actions.MoveBy.new(Vector2(randX,0),0.1)
	var move2 = Actions.MoveBy.new(Vector2(0,randY),1.2).easeInCirc()
	var fadeIn = Actions.FadeIn.new(1.0).easeInCirc()
	
	actionFall = Actions.Merge.new([
		move1,move2,fadeIn
	]).run(label)

func stopFall():
	if actionFall == null:return
	actionFall.stop()
	actionFall = null

func setGrabAreaEnabled(enabled):
	if self.grabAreaLeft:
		grabAreaLeft.setCollisionEnabled(enabled)
	if self.grabAreaRight:
		grabAreaRight.setCollisionEnabled(enabled)

func setCollisionEnabled(enabled):
	if self.body==null:return
		
	setGrabAreaEnabled(enabled)
	if enabled:
		self.body.collision_layer = 1
		self.body.collision_mask = 1
	else:
		self.body.collision_layer = 0
		self.body.collision_mask = 0

func isCollisionEnabled():
	if self.body==null:return false
	return self.body.collision_layer == 1 and self.body.collision_mask == 1

	
func shakeAndFall():
	playShake()
	Actions.Delay.new(2.0,func():
		setCollisionEnabled(false)
		stopShake()
		playFall()
	).run(self)

func shakeAndExplode():
	playShake()
	Actions.Delay.new(0.8,func():
		setCollisionEnabled(false)
		stopShake()
		playExplode()
	).run(self)

var tempSplitLabels = []
var explodeActions = []
var explodeEndCount = 0
func playExplode():
	if len(explodeActions)>0 or len(tempSplitLabels)>0:return

	tempSplitLabels = []
	explodeActions = []

	label.visible = false
	var gap = label.get_rect().size.x/len(label.text)
	
#	var l = label.duplicate()
#	l.visible = true
#	l.text = "test"
#	l.position = Vector2(0,0)
#	self.add_child(l)
	
	for i in range(len(label.text)):
#		var l = Label.new() 
		var l = label.duplicate()
		l.text = label.text[i]
		l.position = Vector2(i*gap,0) 
		l.visible = true

		self.add_child(l)
		tempSplitLabels.append(l)
	
	for temp in tempSplitLabels:
		var randX =  rng.randf_range(-100.0, 100.0)

		var randY1 =  rng.randf_range(-20.0,-5.0)
		var randY2 =  rng.randf_range(200.0,300.0)
		var randR =  rng.randf_range(90.0,180.0)

		var move1 = Actions.MoveBy.new(Vector2(randX,0),0.1)

		var move2 = Actions.Seq.new([
			Actions.MoveBy.new(Vector2(0,randY1),0.2),
			Actions.MoveBy.new(Vector2(0,randY2),1.2)
		]).easeOutCirc()

		var rotate = Actions.RotateBy.new(randR,0.8).easeOutCirc()
		var fadeIn = Actions.FadeIn.new(1.2).easeInCirc()
		
		var explodeAction = Actions.Merge.new([
			move1,move2,rotate,fadeIn
		],func():
			stopExplode(1)
		).run(temp)
		explodeActions.append(explodeAction)

func stopExplode(count = null):
	var numMax = len(label.text)
	if count == null or explodeEndCount + count == numMax:
		explodeEndCount = 0
		for l in tempSplitLabels:
			l.queue_free()
		tempSplitLabels = []

		for a in explodeActions:
			a.stop()
		explodeActions = []
	else:
		explodeEndCount += count
	

func resumeLabel():
	label.visible = true
	label.position = Vector2(0,0)	
	label.modulate.a = 1.0


func reset():
	self.visible = true
	stopShake()
	stopFall()
	stopExplode()
	setCollisionEnabled(true)
	resumeLabel()
