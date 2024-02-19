extends Node2D

## trans
@export var can_trans : bool = true
@export var trans_type : int = FloorUtils.BlockType.EMPTY
@export var trans_time : float = 0.8

signal trans_prepare()
signal trans_start()
signal trans_end()

## Name of input action to trans up.
@export var input_trans_up : String = "trans_up"

# Called when the node enters the scene tree for the first time.

var player
var playerAnimation
var isHoldingTrans = false
var floorNode
func _ready():
	player = $"../../PlatformerController2D"
	floorNode = $"../../PlatformerFloor"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(_event):

	if Input.is_action_pressed(input_trans_up):
		isHoldingTrans = true
		# do sth while trans preparing
	if Input.is_action_just_released(input_trans_up):
		isHoldingTrans = false
		var target = floorNode.getExitLayerBlockAbove(player,null)
		if target == null :
			pass
			# do sth while trans fails
		else:
			# do while trans success
			var tLayer = target[0]
			var tBlock = target[1]
			var playerHieght = player.getCollisionShape().shape.size.y
			var targetPos = Vector2(player.position.x,tLayer.position.y-playerHieght/2)
			#player.position = targetPos
			var up = Actions.MoveTo.new(targetPos,0.2)
			var ro = Actions.RotateBy.new(360,0.2)
			# Lambda func
			var callBack = func(): 
				print("Lambda call")
				return 0
			
			var delay = Actions.Delay.new(0.3,func():print("Lambda call"))
			var action = Actions.Merge.new([ro,up,delay])
			var move = Actions.MoveBy.new(Vector2(100,0),0.2)
			var action2 = Actions.Seq.new([ro,up,delay])
			
			
			var targetPos2 = Vector2(player.position.x+30,tLayer.position.y-playerHieght/2)
			var right = Actions.MoveTo.new(targetPos2,0.2)
			
			Actions.Seq.new([up,right]).run(player)

	
