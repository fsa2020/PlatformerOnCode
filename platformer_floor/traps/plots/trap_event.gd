extends Trap
class_name TrapEvent

var eventName
var areaSize

func _init(name,size = Vector2(100,100)):
	eventName = name
	areaSize = size

func _ready():
	initCollisionLayerAndMask()

func onTargetEnter(target):
	setCollisionEnabled(false)
	if Events.has_signal(eventName):
		Events.emit_signal(eventName)
	
func onTargetExited(target):
	pass

func addBody():
	shape = CollisionShape2D.new()
	self.add_child(shape)
	var rect = RectangleShape2D.new()
	rect.size = areaSize
	shape.shape = rect
	shape.position = Vector2(rect.size.x / 2, rect.size.y / 2)
	isAddBody = true

func reset():
	setCollisionEnabled(true)
