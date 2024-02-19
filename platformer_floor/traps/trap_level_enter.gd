extends Trap
class_name TrapLevelEnter

var level = 0
func _init(lv):
	level = lv
	
func init():
	# todo set by user level data
	if true:
		text = "Error !"
		textColor = Color.RED
	else :
		text = "Completed"
		textColor = Color.GREEN

## Name of input action to use.
@export var input_use : String = "use"

func _input(event):
	if Input.is_action_just_pressed(input_use) and canEnter:
		var root = self.get_tree().get_root()
		var LevelManager = root.find_child("LevelManager",true,false)
		LevelManager.stepIntoLevel(level)

var tip 
var canEnter = false
func onTargetEnter(target):
	if tip == null:
		canEnter = true
		tip = PanelTip.new()
		tip.showTip(self,350," STEP INTO ?",Vector2(0,-80))
	
func onTargetExited(target):
	if tip != null:
		canEnter = false
		tip.removeTip()

	
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

	label.size = Vector2(10*len(text),30)
	self.add_child(label)

func addBody():

	shape = CollisionShape2D.new()
	self.add_child(shape)
	var rect = RectangleShape2D.new()
	rect.size = label.size
	shape.shape = rect
	shape.position = Vector2(rect.size.x / 2, rect.size.y / 2)
	isAddBody = true
