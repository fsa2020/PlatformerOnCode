extends Node2D

## time pause
@export var can_pause : bool = false
@export var pause_max_time : float = 30.0
@export var pause_cd_time : float = 0.1

@export var item_move_speed : float = 2.0

## Name of input action to trans up.
@export var input_ability : String = "ability"
@export var input_use : String = "use"

## Name of input action to move left.
@export var input_left : String = "move_left"
## Name of input action to move right.
@export var input_right : String = "move_right"
## Name of input action to move up.
@export var input_up : String = "move_up"
## Name of input action to move down.
@export var input_down : String = "move_down"

# Called when the node enters the scene tree for the first time.

var isHoldingPause = false
var isInCD = false

@onready var  lvManager = $"../../LevelManager"
@onready var  enterTrapBox = $"../EnterTrapBox"
@onready var  camera = $"../../Camera2D"

@onready var  floorNode = $"../../PlatformerFloor"
@onready var  player = $".."
	
func _process(delta):
	if curItem == null : return
	var dir = Vector2(0,0)
	if Input.is_action_pressed(input_left):
		dir += Vector2(-1,0)
	if Input.is_action_pressed(input_right):
		dir += Vector2(1,0)
	if Input.is_action_pressed(input_up):
		dir += Vector2(0,-1)
	if Input.is_action_pressed(input_down):
		dir += Vector2(0,1)
	if dir.length_squared() >1: dir.normalized()
	
	curItem.position += item_move_speed*dir
	
func _input(_event):

	if Input.is_action_pressed(input_ability):
		if (not isHoldingPause) and (not isInCD): 
			print("startPause")
			startPause()
			
		# do sth while trans preparing
	if Input.is_action_just_released(input_ability) and (not isInCD):
		print("endPause")
		endPause()
	
	if Input.is_action_pressed(input_use) and (not isInCD) :
		print("placeItem and endPause")
		placeItem()
		endPause()
			

			
	
			
var pasueTimeCountAction	
var curItem

func getDispatchItem():
	var items =  player.getDispatchList()
	if len(items)>0:return items[0]

func startPause():
	curItem = getDispatchItem()
	if curItem == null:return

	Events.playEffectSound.emit("Confirm 1.wav")
	get_tree().paused = true
	isHoldingPause = true
	# count left time
	pasueTimeCountAction = Actions.Schedule.new(1.0,func(p):
		print("pause max",str(p.time)+"/"+str(pause_max_time))
		p.time -= 1
		# todo show time in ui 
		if p.time == 0: endPause()
		print("pause max",str(p.time)+"/"+str(pause_max_time))

	,{"time" = pause_max_time},pause_max_time)
	
	pasueTimeCountAction.run(self)
	# start blink
	curItem.playSelectedAction()
	
	# foucs effect
	camera.zoomIn(1.5,0.1)



func placeItem():
	if curItem == null : return
	curItem.stopFollow()
	player.removeDispatchItem(curItem)
	print(curItem,"placeItem")
	# show some place effect 

var cdAction	
func endPause():
	if get_tree().paused == false: return
	if curItem == null : return
	if pasueTimeCountAction !=null: pasueTimeCountAction.stop()
	
	Events.playEffectSound.emit("Cancel 1.wav")
	get_tree().paused = false
	isHoldingPause = false
	isInCD = true

	# slow down player velocity while end pause
	player.velocity = player.velocity*0.3

	# count cd
	cdAction = Actions.Delay.new(1.0,func():
		isInCD = false)
	cdAction.run(self)
	# stop blink
	curItem.stopSelectedAction()
	curItem = null
	# end foucs effect
	camera.zoomReset(0.1,func():
		camera.follow = camera.FollowType.Framed
	)
	
