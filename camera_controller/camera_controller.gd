extends Camera2D

var player
@export var delayFollowSpeed :float = 5.0
@export var framedFollowScaleX :float = 1.0
@export var framedFollowScaleY :float = 0.25
# Called when the node enters the scene tree for the first time.
func _ready():
	player = $"../PlatformerController2D"
	setFollowTarget(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
enum FollowType  {None,Framed,Attached,Delayed,DelayedFramed}

var follow = FollowType.Framed
var targert
func _physics_process(delta):
#	attachFollow(player)
#	delayedFollow(player,delta)
	if follow == FollowType.None:
		return
	elif  follow == FollowType.Framed:
		framedFollow(targert)
	elif  follow == FollowType.Attached:
		attachFollow(targert)
	elif  follow == FollowType.Delayed:
		delayedFollow(targert,delta)
	elif  follow == FollowType.DelayedFramed:
		delayedFramedFollow(targert,delta)
		
func setFollowTarget(tar):
	targert = tar

func getCenterPos():
	var viewRect = get_viewport_rect().size/zoom
	return Vector2(position.x+viewRect.x/2,position.y+viewRect.y/2)
	
func attachFollow(target):
	var center = getCenterPos()
	var tarOffset = target.global_position-center
	self.position += tarOffset

func delayedFollow(target,delta):
	var center = getCenterPos()
	var tarOffset = target.global_position-center
	var xMove = tarOffset.x*delayFollowSpeed*delta
	var yMove = tarOffset.y*delayFollowSpeed*delta
	self.position.x += xMove
	self.position.y += yMove

func isArrived(tarOffset,approximalSize = Vector2(5,5)):

	return abs(tarOffset.x)<=approximalSize.x and abs(tarOffset.y)<=approximalSize.y 

func framedFollow(target):
	var center = getCenterPos()
	var tarOffset = target.global_position-center
	var viewRect = get_viewport_rect().size/zoom
	var frame = Vector2(viewRect.x*framedFollowScaleX/2,viewRect.y*framedFollowScaleY/2)
	if isArrived(tarOffset,frame):
		return
	else:
		if abs(tarOffset.x) > frame.x:
			var xMove = sign(tarOffset.x)*(abs(tarOffset.x)-abs(frame.x))
			self.position.x += xMove
		if abs(tarOffset.y) > frame.y:
			var yMove = sign(tarOffset.y)*(abs(tarOffset.y)-abs(frame.y))
			self.position.y += yMove
			
func delayedFramedFollow(target,delta):
	var center = getCenterPos()
	var tarOffset = target.global_position-center
	var viewRect = get_viewport_rect().size/zoom
	var frame = Vector2(viewRect.x*framedFollowScaleX/2,viewRect.y*framedFollowScaleY/2)
	if isArrived(tarOffset,frame):
		return
	else:
		if abs(tarOffset.x) > frame.x:
			var xMove = tarOffset.x*delayFollowSpeed*delta*0.3
			self.position.x += xMove
		if abs(tarOffset.y) > frame.y:
			var yMove = tarOffset.y*delayFollowSpeed*delta*0.3
			self.position.y += yMove
			
var zoomDeltaTime = 0.02

func zoomReset(time = null,finishCall = null):
	if time == null or time <= zoomDeltaTime:
		zoom = Vector2.ONE
		self.position.x = 0
	else:
		var orgZoom = Vector2(zoom)
		var orgX = position.x
		var orgY = position.y
		var tarY = position.y
		if targert!=null:
			var precent = (targert.global_position-self.global_position)/((get_viewport_rect().size/zoom))
			tarY = get_parent().to_local(targert.global_position-get_viewport_rect().size*precent).y
			
		var orgFollowType = follow
		
		follow = FollowType.None
		var num = time/zoomDeltaTime
		
		var aZoom = Actions.Schedule.new(zoomDeltaTime,func(p):
			p.curNum += 1

			zoom = lerp(orgZoom, Vector2.ONE,p.curNum/num)
			position.x = lerp(orgX, 0.0,p.curNum/num)
			position.y = lerp(orgY, tarY,p.curNum/num)
			print(zoom,position.x)
			print(position.y,"pos y")
			if p.curNum == num:
				follow = orgFollowType
				if finishCall != null : finishCall.call()
				
		,{"curNum" = 0},num)

		aZoom.run(self)


func zoomIn(size,time = null,finishCall = null):
	
	if time == null or time <= zoomDeltaTime:
		zoom = Vector2(size,size)
	else:
		var orgZoom = Vector2(zoom)
		var orgFollowType = follow
		follow = FollowType.None

		var num = time/zoomDeltaTime
	
		var tempPos = self.position
		
		var zoomAnchor = Vector2(0.5,0.5)
		if targert != null:
			var pos = targert.global_position-self.global_position
			zoomAnchor = pos/(get_viewport_rect().size)
		
		var aZoom = Actions.Schedule.new(zoomDeltaTime,func(p):
			p.curNum += 1
			
			zoom = lerp(orgZoom, Vector2(size,size),p.curNum/num)
			self.position = tempPos+getZoomOffset(zoom,zoomAnchor)
			
			if p.curNum == num:
				follow = orgFollowType
				if finishCall != null : finishCall.call()
				
		,{"curNum" = 0},num)

		aZoom.run(self)
		
func getZoomOffset(z,anchor):
	var zp = get_viewport_rect().size/zoom*anchor
	var p = get_viewport_rect().size*anchor
	return p-zp
