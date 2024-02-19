extends Area2D
class_name Trap
## target need to be player or sth 
func _ready():
	print("trap ready")
	initCollisionLayerAndMask()
	init()
	addLabel()

func _process(delta):
	if not isAddBody:
		addBody()


var label
var shape
var isAddBody = false

# property
var textSize = 20
var textColor = Color("#bbc3ef")
var text 
# todo add prop
func initCollisionLayerAndMask():
	collision_layer = 2*2
	collision_mask  = 2*2*2
	
func init():
	pass
	
func reset():
	pass


var org_collision_layer
var org_collision_mask

var collisionEnabled = true

func setCollisionEnabled(enabled):
	if collisionEnabled != enabled :
		collisionEnabled = enabled
		if enabled:
			collision_layer = org_collision_layer
			collision_mask  = org_collision_mask
		else :
			org_collision_layer = collision_layer
			org_collision_mask = collision_mask
			collision_layer = 0
			collision_mask  = 0

	
	
func onTargetEnter(target):
	print("default func target enter v",target.velocity)
	
func onTargetExited(target):
	print("default func target exited v",target.velocity)
	
func addLabel():
	label = Label.new()
	label.text = text

	var ls = LabelSettings.new() 
	ls.set_font_color(textColor) 
	ls.set_font_size(textSize) 
	label.label_settings = ls

	self.add_child(label)

func addBody():
	shape = CollisionShape2D.new()
	self.add_child(shape)
	var rect = RectangleShape2D.new()
	rect.size = label.get_rect().size
	shape.shape = rect
	shape.position = Vector2(rect.size.x / 2, rect.size.y / 2)
	
	addExtraBody()
	isAddBody = true

func addExtraBody():
	pass
