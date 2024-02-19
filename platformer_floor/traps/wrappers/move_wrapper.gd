extends Node2D
class_name MoveWrapper

var trap
var moveAction
var isMoveStrat

# use on traps
func _init(t,act = null):
	trap = t
	moveAction = act
	self.add_child(trap)

func _ready():
	initCollisionLayerAndMask()

func _process(delta):
	if moveAction!= null and not isMoveStrat :
		moveAction.run(self)
		isMoveStrat = true
		
func stopMove():
	if moveAction!= null and isMoveStrat :
		moveAction.stop()
		isMoveStrat = false
		
func initCollisionLayerAndMask():
	
	trap.collision_layer = 2*2
	trap.collision_mask  = 2*2*2
