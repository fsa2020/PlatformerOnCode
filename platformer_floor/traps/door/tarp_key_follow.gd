extends Trap
class_name TrapKeyFollow
## target need to be player or sth 

var isFollowing = false
var followTarget
var doorId
func _init(id = 0):
	doorId = id

func init():
	text = "<-"
	textColor = Color.GREEN

func _process(delta):
	if not isAddBody:
		addBody()
	if isFollowing:
		delayedFollow(delta)

func delayedFollow(delta):
	if followTarget == null: return 
	
	var center = self.global_position
	var offset = followTarget.global_position-center
	var frame = Vector2(50,30)
	if isArrived(offset,frame):
		return 
	else:
		var delayFollowSpeed = 0.8
		var xMove = offset.x*delayFollowSpeed*delta
		var yMove = offset.y*delayFollowSpeed*delta
		self.position.x += xMove
		self.position.y += yMove
			
func isArrived(offset,approximalSize = Vector2(5,5)):
	return abs(offset.x)<=approximalSize.x and abs(offset.y)<=approximalSize.y 
	
func stopFollow():
	collision_layer = 0
	collision_mask  = 0

	followTarget= null
	isFollowing = false
	trapAction.stop()

func plugIntoDoor(door,finishCall=null):
	stopFollow()
	Actions.MoveTo.new(door.position,0.5,func():
		if finishCall!=null:finishCall.call()
	).run(self)

	
# todo add prop
func initCollisionLayerAndMask():
	collision_layer = 2*2
	collision_mask  = 2*2*2+2*2

var trapAction
func onTargetEnter(target):
	print("key onTargetEnter",target)
	if not isFollowing:
		isFollowing = true
		followTarget = target
		var seq = Actions.Seq.new([
			Actions.ScaleTo.new(1.2,1.0).easeOutCirc(),
			Actions.ScaleTo.new(1.0,1.0).easeOutCirc(),
		])
		trapAction = Actions.Repeat.new(seq)
		trapAction.run(self)
		
func onKeyEnterDoor(door,finishCall=null):
	if door.has_method("isMatched") :
		if door.isMatched(self.doorId) :
			plugIntoDoor(door,finishCall)

func onTargetExited(target):
	pass

