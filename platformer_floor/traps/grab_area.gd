extends Area2D
class_name GrabArea
## target need to be player or sth 
func _ready():
	initCollisionLayerAndMask()

func _process(delta):
	if not isAddBody:
		addBody()

var shape
var rectSize

var isAddBody = false

# todo add prop
func initCollisionLayerAndMask():
	collision_layer = 2*2
	collision_mask  = 2*2*2

func setCollisionEnabled(enabled):
	if enabled :
		initCollisionLayerAndMask()
	else:
		collision_layer = 0
		collision_mask  = 0

func onTargetEnter(target):
	if target.has_method("setInGrabArea") :
		target.setInGrabArea(true,target.global_position.x-global_position.x )

func onTargetExited(target):
	if target.has_method("setInGrabArea") :
		target.setInGrabArea(false)

func setShape(r):
	rectSize = r

func addBody():
	shape = CollisionShape2D.new()
	self.add_child(shape)
	var rect = RectangleShape2D.new()
	rect.size = rectSize
	shape.shape = rect
	shape.position = Vector2(rect.size.x / 2, rect.size.y / 2)
	isAddBody = true

