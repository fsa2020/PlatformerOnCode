extends Trap
class_name TrapSocket

var socketId
var trap

func _init(id):
	socketId = id

func _ready():
	print("trap ready")
	initCollisionLayerAndMask()
	init()
	addLabel()
	self.area_entered.connect(_onEnterTrap)
	self.area_exited.connect(_onExitedTrap)

	
func _onEnterTrap(trapArea):
	if trapArea.has_method("onSocketEnter"):
		trapArea.onSocketEnter(self)
	
func _onExitedTrap(trapArea):
	pass

	
func init():
	text = "#  #"
	textColor = Color.GREEN

func initCollisionLayerAndMask():
	collision_layer = 2*2
	collision_mask  = 2*2

func isMatched(id):
	return socketId == id
	
func addLabel():
	label = RichTextLabel.new()
	label.bbcode_enabled = true
	label.text = "[wave amp=50 freq=3]"+text+"[/wave]"

	var f = FontFile.new()
	f.load_dynamic_font("res://asset/fonts/poco/Poco.ttf")
	label.theme = Theme.new()
	label.theme.default_font = f
	label.theme.default_font_size = textSize
	
	label.add_theme_color_override("default_color",textColor)

	label.size = Vector2(12*len(text),30)
	label.position = Vector2(-15,0)
	self.add_child(label)

func addBody():

	shape = CollisionShape2D.new()
	self.add_child(shape)
	var rect = RectangleShape2D.new()
	rect.size = label.size
	shape.shape = rect
	shape.position = Vector2(rect.size.x / 2, rect.size.y / 2)
	isAddBody = true
