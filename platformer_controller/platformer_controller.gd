extends CharacterBody2D

class_name PlatformerController2D

signal jumped(is_ground_jump: bool)
signal hit_ground()

signal rush_start()
signal rush_end()



# Set these to the name of your action (in the Input Map)
## Name of input action to move left.
@export var input_left : String = "move_left"
## Name of input action to move right.
@export var input_right : String = "move_right"
## Name of input action to move up.
@export var input_up : String = "move_up"
## Name of input action to move down.
@export var input_down : String = "move_down"
## Name of input action to jump.
@export var input_jump : String = "jump"
## Name of input action to rush.
@export var input_rush : String = "rush"
## Name of input action to grab.
@export var input_grab : String = "grab"
## Name of input action to use.
@export var input_use : String = "use"

const DEFAULT_MAX_JUMP_HEIGHT = 150
const DEFAULT_MIN_JUMP_HEIGHT = 60
const DEFAULT_DOUBLE_JUMP_HEIGHT = 100
const DEFAULT_JUMP_DURATION = 0.3

@export var max_velocity_x : float = 2000
@export var max_velocity_y : float = 2000

var _max_jump_height: float = DEFAULT_MAX_JUMP_HEIGHT
## The max jump height in pixels (holding jump).
@export var max_jump_height: float = DEFAULT_MAX_JUMP_HEIGHT: 
	get:
		return _max_jump_height
	set(value):
		_max_jump_height = value
	
		default_gravity = calculate_gravity(_max_jump_height, jump_duration)
		jump_velocity = calculate_jump_velocity(_max_jump_height, jump_duration)
		double_jump_velocity = calculate_jump_velocity2(double_jump_height, default_gravity)
		release_gravity_multiplier = calculate_release_gravity_multiplier(
				jump_velocity, min_jump_height, default_gravity)
			

var _min_jump_height: float = DEFAULT_MIN_JUMP_HEIGHT
## The minimum jump height (tapping jump).
@export var min_jump_height: float = DEFAULT_MIN_JUMP_HEIGHT: 
	get:
		return _min_jump_height
	set(value):
		_min_jump_height = value
		release_gravity_multiplier = calculate_release_gravity_multiplier(
				jump_velocity, min_jump_height, default_gravity)



var _double_jump_height: float = DEFAULT_DOUBLE_JUMP_HEIGHT
## The height of your jump in the air.
@export var double_jump_height: float = DEFAULT_DOUBLE_JUMP_HEIGHT:
	get:
		return _double_jump_height
	set(value):
		_double_jump_height = value
		double_jump_velocity = calculate_jump_velocity2(double_jump_height, default_gravity)
		

var _jump_duration: float = DEFAULT_JUMP_DURATION
## How long it takes to get to the peak of the jump in seconds.
@export var jump_duration: float = DEFAULT_JUMP_DURATION:
	get:
		return _jump_duration
	set(value):
		_jump_duration = value
	
		default_gravity = calculate_gravity(max_jump_height, jump_duration)
		jump_velocity = calculate_jump_velocity(max_jump_height, jump_duration)
		double_jump_velocity = calculate_jump_velocity2(double_jump_height, default_gravity)
		release_gravity_multiplier = calculate_release_gravity_multiplier(
				jump_velocity, min_jump_height, default_gravity)
		
## Multiplies the gravity by this while falling.
@export var falling_gravity_multiplier = 1.5
## Amount of jumps allowed before needing to touch the ground again. Set to 2 for double jump.
@export var max_jump_amount = 1
@export var max_acceleration = 2000
@export var friction : float = 15.0
@export var can_hold_jump : bool = false
## You can still jump this many seconds after falling off a ledge.
@export var coyote_time : float = 0.1
## Pressing jump this many seconds before hitting the ground will still make you jump.
## Only neccessary when can_hold_jump is unchecked.
@export var jump_buffer : float = 0.1



# These will be calcualted automatically
# Gravity will be positive if it's going down, and negative if it's going up
var default_gravity : float
var jump_velocity : float
var double_jump_velocity : float
# Multiplies the gravity by this when we release jump
var release_gravity_multiplier : float


var jumps_left : int
var holding_jump := false

enum JumpType {NONE, GROUND, AIR, GRAB}
enum FaceDirection {LEFT, RIGHT}
## The type of jump the player is performing. Is JumpType.NONE if they player is on the ground.
var current_jump_type: JumpType = JumpType.NONE

# Used to detect if player just hit the ground
var _was_on_ground: bool

var acc = Vector2()
var grabMoveSpeed = 0

## rush
@export var can_rush : bool = true
@export var rush_velocity : float = 2000.0
@export var rush_cd : float = 0.8


var is_rushing := false
var rushing_time := 0.0
var face_to := FaceDirection.LEFT

# coyote_time and jump_buffer must be above zero to work. Otherwise, godot will throw an error.
@onready var is_coyote_time_enabled = coyote_time > 0
@onready var is_jump_buffer_enabled = jump_buffer > 0
@onready var coyote_timer = Timer.new()
@onready var jump_buffer_timer = Timer.new()


@onready var  lvManager = $"../LevelManager"
@onready var  enterTrapBox = $EnterTrapBox
@onready var  camera = $"../Camera2D"
@onready var  floorNode = $"../PlatformerFloor"


func _init():
	default_gravity = calculate_gravity(max_jump_height, jump_duration)
	jump_velocity = calculate_jump_velocity(max_jump_height, jump_duration)
	double_jump_velocity = calculate_jump_velocity2(double_jump_height, default_gravity)
	release_gravity_multiplier = calculate_release_gravity_multiplier(
			jump_velocity, min_jump_height, default_gravity)


func _ready():
	if is_coyote_time_enabled:
		add_child(coyote_timer)
		coyote_timer.wait_time = coyote_time
		coyote_timer.one_shot = true
	
	if is_jump_buffer_enabled:
		add_child(jump_buffer_timer)
		jump_buffer_timer.wait_time = jump_buffer
		jump_buffer_timer.one_shot = true
	
		
func input_process():
	if not controllerEnabled : return
	acc.x = 0
	grabMoveSpeed = 0
	if isInGrabArea and Input.is_action_pressed(input_grab):
		doGrab()
		
	if Input.is_action_pressed(input_left) and not isGrabbing:
		acc.x = -max_acceleration
		face_to = FaceDirection.LEFT
	
	if Input.is_action_pressed(input_right) and not isGrabbing:
		acc.x = max_acceleration
		face_to = FaceDirection.RIGHT
		
	if Input.is_action_pressed(input_up) and isGrabbing:
		grabMoveSpeed = -100
	
	if Input.is_action_pressed(input_down) and isGrabbing:
		grabMoveSpeed = 150

	if Input.is_action_just_pressed(input_jump):

#		Events.CmdOut.emit("jump pressed")

		holding_jump = true
		start_jump_buffer_timer()
		
		if (isInGrabArea and not is_feet_on_ground()) or isGrabbing:
			jumpFromGrabbing()
		elif (not can_hold_jump and can_ground_jump()) or can_double_jump():
			jump()
			
	if Input.is_action_just_released(input_jump):
		holding_jump = false
	


var platformVelocity
var keepStatic = false

func _physics_process(delta):
	input_process()
	
	if not moveEnabled:return
	
	if  (not isInGrabArea) or (isGrabbing and Input.is_action_just_released(input_grab)):
		isGrabbing = false
		forceResumeGravity()
		
	if is_coyote_timer_running() or current_jump_type == JumpType.NONE:
		jumps_left = max_jump_amount
		tempJumpTime = 0

	if _was_on_ground and not is_feet_on_ground() and not isGrabbing:  
		jumps_left -= 1
	
	if is_feet_on_ground() and current_jump_type == JumpType.NONE:
		start_coyote_timer()
		
	# Check if we just hit the ground this frame
	if not _was_on_ground and is_feet_on_ground():
		current_jump_type = JumpType.NONE
		
		
		if is_jump_buffer_timer_running() and not can_hold_jump: 
			jump()
		
		hit_ground.emit()
		Events.playEffectSound.emit("Hit damage 1.wav")
	
	
	# Cannot do this in _input because it needs to be checked every frame
	if controllerEnabled and Input.is_action_pressed(input_jump)  :
		if can_ground_jump() and can_hold_jump:
			jump()
	
	if isGrabbing:
		velocity.y = grabMoveSpeed
	else:
		var gravity = apply_gravity_multipliers_to(default_gravity)
		acc.y = gravity
			
		if is_feet_on_ground():
			velocity.x *= 1 / (1 + (delta * friction))
#			print("acc on_ground",acc.x)
		else:
			velocity.x *= 1 / (1 + (delta * (friction*0.1)))
			acc.x *=0.15
#			print("acc in air",acc.x)
	
			
		velocity += acc * delta
		
	
	if controllerEnabled and Input.is_action_pressed(input_rush) and can_rush and not is_rushing :
		start_rush()

	count_rushing_time(delta)

	_was_on_ground = is_feet_on_ground()
	
	restrictVelocity()
	move_and_slide()
	
	platformVelocity = get_platform_velocity()

## start rush action by add a velocity to aixs x 
func start_rush():
	is_rushing = true
	rushing_time = 0.0
	# can do  dir->vector2d
	var dir = 0
	if(face_to == FaceDirection.LEFT):
		dir = -1
	elif(face_to == FaceDirection.RIGHT):
		dir = 1

	velocity.x += dir*rush_velocity
	
	rush_start.emit()

func count_rushing_time(delta):
	if not is_rushing:
		return
	rushing_time += delta
	if rushing_time >= rush_cd:
		velocity.x = 0
		is_rushing = false
		rush_end.emit()
		

## Use this instead of coyote_timer.start() to check if the coyote_timer is enabled first
func start_coyote_timer():
	if is_coyote_time_enabled:
		coyote_timer.start()

## Use this instead of jump_buffer_timer.start() to check if the jump_buffer is enabled first
func start_jump_buffer_timer():
	if is_jump_buffer_enabled:
		jump_buffer_timer.start()

## Use this instead of `not coyote_timer.is_stopped()`. This will always return false if 
## the coyote_timer is disabled
func is_coyote_timer_running():
	if (is_coyote_time_enabled and not coyote_timer.is_stopped()):
		return true
	
	return false

## Use this instead of `not jump_buffer_timer.is_stopped()`. This will always return false if 
## the jump_buffer_timer is disabled
func is_jump_buffer_timer_running():
	if is_jump_buffer_enabled and not jump_buffer_timer.is_stopped():
		return true
	
	return false


func can_ground_jump() -> bool:
	if jumps_left > 0 and is_feet_on_ground() and current_jump_type == JumpType.NONE:
		return true
	elif is_coyote_timer_running():
		return true
	
	return false


func can_double_jump():
	if tempJumpTime > 0:return true
	
	if jumps_left <= 1 and jumps_left == max_jump_amount:
		# Special case where you've fallen off a cliff and only have 1 jump. You cannot use your
		# first jump in the air
		return false
	
	if jumps_left > 0 and not is_feet_on_ground() and coyote_timer.is_stopped():
		return true
	
	return false


## Same as is_on_floor(), but also returns true if gravity is reversed and you are on the ceiling
func is_feet_on_ground():
	if is_on_floor() and default_gravity >= 0:
		return true
	if is_on_ceiling() and default_gravity <= 0:
		return true
	
	return false


## Perform a ground jump, or a double jump if the character is in the air.
func jump():
	if can_double_jump():
		double_jump()
	else:
		ground_jump()


## Perform a double jump without checking if the player is able to.
func double_jump():
	if tempJumpTime>0:
		tempJumpTime -= 1
	elif jumps_left == max_jump_amount:
		# Your first jump must be used when on the ground.
		# If your first jump is used in the air, an additional jump will be taken away.
		jumps_left -= 1
	
	velocity.y = -double_jump_velocity
	current_jump_type = JumpType.AIR
	jumps_left -= 1
	jumped.emit(false)
	Events.playEffectSound.emit("Jump 1.wav")


## Perform a ground jump without checking if the player is able to.
func ground_jump():
	velocity.y = -jump_velocity
	# add platform v
	var addV = Vector2(platformVelocity.x,min(platformVelocity.y,0))
	velocity += addV
	
	current_jump_type = JumpType.GROUND
	jumps_left -= 1
	coyote_timer.stop()
	jumped.emit(true)
	Events.playEffectSound.emit("Jump 1.wav")


func apply_gravity_multipliers_to(gravity) -> float:
	if velocity.y * sign(default_gravity) > 0: # If we are falling
		gravity *= falling_gravity_multiplier
	
	# if we released jump and are still rising
	elif velocity.y * sign(default_gravity) < 0:
		if not holding_jump: 
			if not current_jump_type == JumpType.AIR: # Always jump to max height when we are using a double jump
				gravity *= release_gravity_multiplier # multiply the gravity so we have a lower jump
	
	
	return gravity


## Calculates the desired gravity from jump height and jump duration.  [br]
## Formula is from [url=https://www.youtube.com/watch?v=hG9SzQxaCm8]this video[/url] 
func calculate_gravity(p_max_jump_height, p_jump_duration):
	return (2 * p_max_jump_height) / pow(p_jump_duration, 2)


## Calculates the desired jump velocity from jump height and jump duration.
func calculate_jump_velocity(p_max_jump_height, p_jump_duration):
	return (2 * p_max_jump_height) / (p_jump_duration)


## Calculates jump velocity from jump height and gravity.  [br]
## Formula from 
## [url]https://sciencing.com/acceleration-velocity-distance-7779124.html#:~:text=in%20every%20step.-,Starting%20from%3A,-v%5E2%3Du[/url]
func calculate_jump_velocity2(p_max_jump_height, p_gravity):
	return sqrt(abs(2 * p_gravity * p_max_jump_height)) * sign(p_max_jump_height)


## Calculates the gravity when the key is released based off the minimum jump height and jump velocity.  [br]
## Formula is from [url]https://sciencing.com/acceleration-velocity-distance-7779124.html[/url]
func calculate_release_gravity_multiplier(p_jump_velocity, p_min_jump_height, p_gravity):
	var release_gravity = pow(p_jump_velocity, 2) / (2 * p_min_jump_height)
	return release_gravity / p_gravity


## Returns a value for friction that will hit the max speed after 90% of time_to_max seconds.  [br]
## Formula from [url]https://www.reddit.com/r/gamedev/comments/bdbery/comment/ekxw9g4/?utm_source=share&utm_medium=web2x&context=3[/url]
func calculate_friction(time_to_max):
	return 1 - (2.30259 / time_to_max)


## Formula from [url]https://www.reddit.com/r/gamedev/comments/bdbery/comment/ekxw9g4/?utm_source=share&utm_medium=web2x&context=3[/url]
func calculate_speed(p_max_speed, p_friction):
	return (p_max_speed / p_friction) - p_max_speed

func getCollisionShape():
	return $"CollisionShape2D"

var orgMaxJump
func setMaxJumpTime(t):
	if orgMaxJump == null : orgMaxJump = max_jump_amount
	max_jump_amount = t
	
func resumeMaxJumpTime():
	if orgMaxJump == null : orgMaxJump = max_jump_amount
	max_jump_amount = orgMaxJump

func resetJumpTime():
	jumps_left = max_jump_amount

var tempJumpTime = 0
func addTempJumpTime():
	tempJumpTime = 1

# deal with action or trap run on player
var orgGravity
var gSetTime = 0
func setGravity(g):
	if orgGravity == null : orgGravity = default_gravity
	default_gravity = g
	gSetTime += 1
	
func resumeGravity():
	if orgGravity == null : orgGravity = default_gravity
	gSetTime = max(gSetTime-1,0)
	if gSetTime == 0: default_gravity = orgGravity
	
func forceResumeGravity():
	if orgGravity == null : orgGravity = default_gravity
	gSetTime = 0
	default_gravity = orgGravity
	
var orgCollisionLayer
var layerSetTime = 0
func setCollisionLayer(layer):
	if orgCollisionLayer == null : orgCollisionLayer = collision_layer
	orgCollisionLayer = layer
	layerSetTime += 1
	
func resumeCollisionLayer():
	if orgCollisionLayer == null : orgCollisionLayer = collision_layer
	layerSetTime = max(layerSetTime-1,0)
	if gSetTime == 0: collision_layer = orgCollisionLayer
	
func forceResumeCollisionLayer():
	if orgCollisionLayer == null : orgCollisionLayer = collision_layer
	layerSetTime = 0
	collision_layer = orgCollisionLayer

var controllerEnabled = true
func setControllerEnabled(enabled):
	controllerEnabled = enabled
	
var isInGrabArea = false
var isGrabbing = false
var grabDirection
var inGrabAreaCount = 0

func setInGrabArea(isIn,dir = 1):
	if isIn:
		inGrabAreaCount+=1
		grabDirection = sign(dir)
	else:
		inGrabAreaCount-=1

	isInGrabArea = inGrabAreaCount>0
	
func doGrab():
	isGrabbing = true
	velocity = Vector2.ZERO
	setGravity(0)
	
	if getAcionManager()!=null:
		getAcionManager().stopActionByNodeWithFinishCall(self)
	
func jumpFromGrabbing():
	velocity.y = -jump_velocity
	print(grabDirection)
	velocity.x = jump_velocity*grabDirection*0.6
	current_jump_type = JumpType.GRAB
	jumps_left -= 1
	coyote_timer.stop()
	jumped.emit(true)
	Events.playEffectSound.emit("Jump 1.wav")
	isGrabbing = false
	if getAcionManager()!=null:
		getAcionManager().stopActionByNodeWithFinishCall(self)

func getAcionManager():
	var root = get_tree().get_root()
	return root.find_child("ActionManager",false)

func setMaxVelocityX(v):
	max_velocity_x = v

func setMaxVelocityY(v):
	max_velocity_y = v

func restrictVelocity():
	velocity.x = sign( velocity.x)* min(abs(velocity.x),max_velocity_x)
	velocity.y = sign( velocity.y)* min(abs(velocity.y),max_velocity_y)
	
func setCollisionEnabled(enabled):
	if enabled:
		collision_layer = 2
		collision_mask = 1
		enterTrapBox.collision_layer = 2*2*2
		enterTrapBox.collision_mask = 2*2
	else:
		collision_layer = 0
		collision_mask = 0
		enterTrapBox.collision_layer = 0
		enterTrapBox.collision_mask = 0
		
func setTrapCollisionEnabled(enabled):
	if enabled:
		enterTrapBox.collision_layer = 2*2*2
		enterTrapBox.collision_mask = 2*2
	else:
		enterTrapBox.collision_layer = 0
		enterTrapBox.collision_mask = 0		

var moveEnabled = true
func setMoveEnabled(enabled):
	moveEnabled = enabled
	velocity = Vector2.ZERO

func onPlayerEnterDoor(curDoor,connectDoor):
	# var offset = curDoor.global_position - connectDoor.global_position
	# self.position -= offset
	var scale2 = Actions.ScaleTo.new(1,0.2)
	var rotate2 = Actions.RotateBy.new(360,0.2)
	var excitDoor = Actions.Merge.new([scale2,rotate2])
	
	var scale1 = Actions.ScaleTo.new(0.5,0.2)
	var rotate1 = Actions.RotateBy.new(360,0.2)
	var enterDoor = Actions.Merge.new([scale1,rotate1],func():
		# pos and camera 
		var orgPosY = self.position.y
		self.global_position = connectDoor.global_position

		var cameraOffsetY = self.position.y-orgPosY

		camera.follow = null
		Actions.MoveBy.new(Vector2(0,cameraOffsetY),0.2,func():
			camera.follow = camera.FollowType.Framed
		).easeOutCirc().run(camera)
		
		excitDoor.run(self)
	)
	enterDoor.run(self)

	

	
	
	
func playDead(finishCallBack = null):
	onDead()
	camera.zoomIn(2.0,0.6,func():
		# todo play dead animation
		lvManager.playerDead(func():
			camera.attachFollow(self)
			camera.zoomReset(0.5)
			onReborn()
			if finishCallBack : finishCallBack.call()
		)
	)
	
func onDead():
	setMoveEnabled(false)
	setControllerEnabled(false)
	setTrapCollisionEnabled(false)
	clearDispatchItem()

func onReborn():
	setMoveEnabled(true)
	setControllerEnabled(true)
	setTrapCollisionEnabled(true)

var dispatchItemList = []

func clearDispatchItem():
	dispatchItemList = []

func addDispatchItem(wrapper):
	dispatchItemList.append(wrapper)

func getDispatchList():
	return dispatchItemList
	
func removeDispatchItem(item):
	var index = -1
	for i in range(len(dispatchItemList)):
		if dispatchItemList[i] == item:
			index = i
			break
	if index!= -1:
		dispatchItemList.remove_at(index)

func getCurLayer():
	return floorNode.getLayerBelow(self)
	
func getCurBlock():
	return floorNode.getBlockBelow(self)

	
	
	

