extends Trap
class_name TrapDeadLine

var size = 1
var isVertical = false
func _init(s = 1,vertical = false):
	size = s
	isVertical = vertical
	
func init():
	textSize = 12
	textColor = Color.RED
	if isVertical:
		text = "#\n"
		for i in range(size):
			text += "E\n"
		text += "#"
	else:
		text = "<"
		for i in range(size):
			text += "E"
		text += ">"
		
func onTargetEnter(target):
	## tigger while v<=0
	if (target.has_method("playDead")):
		target.playDead()
	
	
	
func addBody():
	shape = CollisionShape2D.new()
	self.add_child(shape)
	var rect = RectangleShape2D.new()
	rect.size = Vector2(label.get_rect().size.x-3,label.get_rect().size.y) 
	shape.shape = rect
	shape.position = Vector2(rect.size.x / 2, rect.size.y/2 )
	isAddBody = true
	
