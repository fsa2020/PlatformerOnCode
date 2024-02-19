extends AnimatableBody2D
class_name Block

var isOneWayCollision
var text 
var textSize = 20
var textColor = Color("#bbc3ef")

var rect 
var label

var isAddBody = false
var shape

var moveAction
var isActionRunning = false

var triggerId
var isTriggerOn

# block generate with traps
func _init(string = "#####",isOneWay = false):
	text = string
	isOneWayCollision = isOneWay
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _ready():
	print("TrapBlock ready")
	initCollisionLayerAndMask()
	init()
	addLabel()

func _process(delta):
	if not isAddBody:
		addBody()
	if triggerId == -1:
		runAction()
		
func runAction():
	if self.moveAction != null and (not isActionRunning):
		moveAction.run(self)
		isActionRunning = true

func initCollisionLayerAndMask():
	collision_layer = 1
	collision_mask  = 1
	
func init():
	pass

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
	
	shape.one_way_collision = isOneWayCollision

	var rect = RectangleShape2D.new()
	rect.size = label.get_rect().size
	shape.shape = rect
	shape.position = Vector2(rect.size.x / 2, rect.size.y / 2+5)
	isAddBody = true

func addAction(act,id = -1):
	moveAction = act
	triggerId = id
	
	if triggerId != -1:
		Events.TrapTiggerOn.connect(triggerOn)
		isTriggerOn = false	
	return self
	
func triggerOn(id):
	if id == triggerId and (not isTriggerOn):
		isTriggerOn = true
		print('trigger on',id)
		runAction()
