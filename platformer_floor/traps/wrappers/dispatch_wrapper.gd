extends Area2D
class_name DispatchWrapper
## target need to be player or sth 
var trap
var shape
var rectSize
var isAddBody = false
var isFollowing = false
var followTarget

var orgPos

func _init(t,r = Vector2(50,50)):
	trap = t
	rectSize = r

	self.add_child(trap)
	initTrap()

func initTrap():
	trap.position = rectSize*0.5+Vector2(-5,-20)
	addTip()

var tip
func addTip():
	if tip == null:
		tip = RichTextLabel.new()
		tip.bbcode_enabled = true

		tip.text = "[wave amp=20 freq=5]"+"[ ]"+"[/wave]"

		var f = FontFile.new()
		f.load_dynamic_font("res://asset/fonts/poco/Poco.ttf")
		tip.theme = Theme.new()
		tip.theme.default_font = f
		tip.theme.default_font_size = 25
		
		tip.add_theme_color_override("default_color",Color.DARK_SEA_GREEN)

		tip.size = Vector2(50,50)
		tip.position = trap.position+Vector2(-10,-10)
		self.add_child(tip)
		
	else:
		tip.visible = true

func _ready():
	initCollisionLayerAndMask()


func _process(delta):
	if not isAddBody:
		addBody()
		orgPos = Vector2(self.position.x,self.position.y)
	if isFollowing:
		delayedFollow(delta)

func delayedFollow(delta):
	if followTarget == null: return 
	
	var center = self.global_position
	var offset = followTarget.global_position-center
	var frame = Vector2(30,30)
	if isArrived(offset,frame):
		return 
	else:
		var delayFollowSpeed = 1.5
		var xMove = offset.x*delayFollowSpeed*delta
		var yMove = offset.y*delayFollowSpeed*delta
		self.position.x += xMove
		self.position.y += yMove
			
func isArrived(offset,approximalSize = Vector2(5,5)):
	return abs(offset.x)<=approximalSize.x and abs(offset.y)<=approximalSize.y 
	
func stopFollow():
	followTarget= null
	isFollowing = false
	if trapAction !=null: trapAction.stop()
	resumeTrap()


func resumeTrap():
	trap.collision_layer = 2*2
	trap.collision_mask  = 2*2*2
	trap.scale = Vector2.ONE
	
	collision_layer = 0
	collision_mask  = 0
	
# todo add prop
func initCollisionLayerAndMask():
	collision_layer = 2*2
	collision_mask  = 2*2*2+2*2
	
	trap.collision_layer = 0
	trap.collision_mask  = 0

var trapAction

func onTargetEnter(target):
	print("follow wrapper onTargetEnter",target)
	if not isFollowing:
		startFollow(target)

func startFollow(target):
	Events.playEffectSound.emit("Fruit collect 1.wav")
	tip.visible = false

	isFollowing = true
	followTarget = target
	# action while follow
	var seq = Actions.Seq.new([
		Actions.ScaleTo.new(1.2,1.0).easeOutCirc(),
		Actions.ScaleTo.new(1.0,1.0).easeOutCirc(),
	])
	trapAction = Actions.Repeat.new(seq)
	trapAction.run(trap)
	if target.has_method("addDispatchItem"):
		target.addDispatchItem(self)
		
		if UserData.curLv == 3 and not UserData.checkSpecifiedRecord("guidePause"):
			
			get_tree().paused = true
			
			Events.StartPlot.emit("GuidePause",func():
				UserData.setSpecifiedRecord("guidePause")
				get_tree().paused = false)

func onTargetExited(target):
	pass

var selectedAction
var trapOrgColor

func playSelectedAction():
	trapOrgColor = trap.modulate
	selectedAction = Actions.Blink.new(0.1).run(trap)

func stopSelectedAction():
	if selectedAction!=null:
		selectedAction.stop()
		trap.modulate = trapOrgColor


func addBody():
	shape = CollisionShape2D.new()
	self.add_child(shape)
	var rect = RectangleShape2D.new()
	rect.size = rectSize
	shape.shape = rect
	shape.position = Vector2(rect.size.x / 2, rect.size.y / 2)
	isAddBody = true

func reset():
	stopFollow()
	initCollisionLayerAndMask()
	initTrap()

	if orgPos != null:
		self.position = orgPos
		

