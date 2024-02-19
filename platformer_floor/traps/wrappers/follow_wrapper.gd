extends Area2D
class_name FollowWrapper
## target need to be player or sth 
var trap
var shape
var rectSize
var isAddBody = false
var isFollowing = false
var followTarget
var socketId
func _init(t,id = 0,r = Vector2(100,100)):
	trap = t
	rectSize = r
	socketId = id
	
	self.add_child(trap)

func _ready():
	initCollisionLayerAndMask()

func _process(delta):
	if not isAddBody:
		addBody()
	if isFollowing:
		delayedFollow(delta)

func delayedFollow(delta):
	if followTarget == null: return 
	
	var center = self.global_position
	var offset = followTarget.global_position-center
	var frame = Vector2(100,100)
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
	trapAction.stop()
	resumeTrap()

func plugIntoSocket(socketTrap):
	stopFollow()
	Actions.MoveTo.new(socketTrap.position,0.5).run(self)

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
		isFollowing = true
		followTarget = target
		var seq = Actions.Seq.new([
			Actions.ScaleTo.new(1.2,1.0).easeOutCirc(),
			Actions.ScaleTo.new(1.0,1.0).easeOutCirc(),
		])
		trapAction = Actions.Repeat.new(seq)
		trapAction.run(trap)
		
func onSocketEnter(socket):
	print("follow wrapper onSocketEnter",socket)
	if socket.has_method("isMatched") :
		if socket.isMatched(self.socketId) :
			plugIntoSocket(socket)

func onTargetExited(target):
	pass
		
func addBody():
	shape = CollisionShape2D.new()
	self.add_child(shape)
	var rect = RectangleShape2D.new()
	rect.size = rectSize
	shape.shape = rect
	shape.position = Vector2(rect.size.x / 2, rect.size.y / 2)
	isAddBody = true

