extends Trap
class_name TrapSpring

func init():
	textSize = 15
	text = "=="

func onTargetEnter(target):
	## tigger while v<=0
	if (target.velocity.y<-200):
		print(target.velocity.y,"target.velocity.y")
		return
	Events.playEffectSound.emit("Bubble heavy 1.wav")
	print("target enter v",target.velocity)
	# label animation
	label.position = Vector2(0,0)
	var up = Actions.MoveBy.new(Vector2(0,-20),0.05).easeOutCirc()
	var down = Actions.MoveBy.new(Vector2(0,20),0.1).easeInCirc()
	
	Actions.Seq.new([up,down]).run(label)
	# target velocity
	target.velocity = Vector2(0,-500)
	
	
	
func addBody():
	shape = CollisionShape2D.new()
	self.add_child(shape)
	var rect = RectangleShape2D.new()
	rect.size = Vector2(label.get_rect().size.x,label.get_rect().size.y/2) 
	shape.shape = rect
	shape.position = Vector2(rect.size.x / 2, rect.size.y )
	
	addExtraBody()
	isAddBody = true
	
