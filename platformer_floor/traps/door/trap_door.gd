extends Trap
class_name TrapDoor

var doorId
var trap
var locked = true

var connectDoor
var palyerEnter

func _init(id,lock = true):
	doorId = id
	locked = lock

func init():
	text = "/#####\\\n"+"|#####|\n"+"|#####|\n"+"|#####|"
	textSize = 8
	textColor = Color.SADDLE_BROWN

func _ready():
	print("trap ready")
	initCollisionLayerAndMask()
	init()
	addLabel()
	self.area_entered.connect(_onEnterTrap)
	self.area_exited.connect(_onExitedTrap)
	
@export var input_use : String = "use"
func _input(event):
	if Input.is_action_just_pressed(input_use) and palyerEnter!=null:
		if locked :
			var tip = PanelTip.new()
			tip.showTipMoment(self,200,"need a key",Vector2(0,-80))
		else:
			Events.playEffectSound.emit("Balloon start riding 2.wav")
			palyerEnter.onPlayerEnterDoor(self,connectDoor)
		
func _onEnterTrap(tar):
	print("_onEnterTrap door ",tar)
	if locked == true and tar.has_method("onKeyEnterDoor"):
		tar.onKeyEnterDoor(self,func():locked = false)
			
	if tar.get_parent().has_method("onPlayerEnterDoor"):
		palyerEnter = tar.get_parent()
			
	
func _onExitedTrap(tar):
	palyerEnter = null



func initCollisionLayerAndMask():
	collision_layer = 2*2
	collision_mask  = 2*2 + 2*2*2


func isMatched(id):
	return doorId == id

func setConnectDoor(door):
	connectDoor = door
