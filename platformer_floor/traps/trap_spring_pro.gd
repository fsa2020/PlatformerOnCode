extends TrapSpring

class_name TrapSpringPro

@export var vUp = -1200

func _init(v = -1200):
	vUp = v
	
func init():
	textSize = 15
	textColor = Color.CORAL
	text = "=="

func onTargetEnter(target):
	## tigger while v<=0
	if (target.velocity.y<0):return
	print("target enter v",target.velocity)
	# label animation
	label.position = Vector2(0,0)
	var up = Actions.MoveBy.new(Vector2(0,-20),0.05).easeOutCirc()
	var down = Actions.MoveBy.new(Vector2(0,20),0.1).easeInCirc()
	
	Actions.Seq.new([up,down]).run(label)
	# target velocity
	target.velocity = Vector2(0,vUp)
	

