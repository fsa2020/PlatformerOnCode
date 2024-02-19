extends TrapAbility
class_name TrapMoveBall

func init():
	# todo set by user level data
	text = "####\n####"	
	textSize = 10
	textColor = Color.GREEN



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


func _input(_event):
	if isPlayerInside and Input.is_action_just_released(input_jump) :
		release()
		return

	if isPlayerInside and moveDir == null :
		if Input.is_action_just_released(input_left):
			startMove(Vector2(-1,0))
			
		elif Input.is_action_just_released(input_right):
			startMove(Vector2(1,0))
			
		elif Input.is_action_just_released(input_up):
			startMove(Vector2(0,-1))
			
		elif Input.is_action_just_released(input_down):
			startMove(Vector2(0,1))

var cdTime = 3.0
var isReloading = false		
var moveSpeed = 100
var isPlayerInside = false
var moveDir
var player

func _physics_process(delta):
	if moveDir != null:
		self.position += moveDir*moveSpeed
	

func release():
	moveDir = null
	isPlayerInside = false
	player = null
	reload()
	
func absorb(target):
	isPlayerInside = true
	player = target
	

func startMove(dir):
	moveDir = dir

func reload():
	if not isReloading :
		setCollisionEnabled(false)
		isReloading = true
		
		var fadeT = 0.3
		var fadeIn = Actions.FadeIn.new(fadeT)
		var delay = Actions.Delay.new(cdTime-fadeT*2)
		var fadeOut = Actions.FadeOut.new(fadeT)
		var reLoadAction = Actions.Seq.new([fadeIn,delay,fadeOut],func ():
			setCollisionEnabled(true)
			isReloading = false)
		

		reLoadAction.run(label)

func onTargetEnter(target):
	print("TrapResetJump",target)
	# is player
	if not isReloading and target.has_method("playDead") :
		absorb(target)
