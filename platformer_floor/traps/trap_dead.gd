extends Trap
class_name TrapDead

func init():
	textSize = 12
	textColor = Color.RED
	text = "<E>"

func onTargetEnter(target):
	## tigger while v<=0
	if (target.has_method("playDead")):
		target.playDead()
	
	
	
func addBody():
	shape = CollisionShape2D.new()
	self.add_child(shape)
	var rect = RectangleShape2D.new()
	rect.size = Vector2(label.get_rect().size.x,label.get_rect().size.y/2) 
	shape.shape = rect
	shape.position = Vector2(rect.size.x / 2, rect.size.y )
	isAddBody = true
	
