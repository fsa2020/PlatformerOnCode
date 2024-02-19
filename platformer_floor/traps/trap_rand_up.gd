extends Trap
class_name TrapRandUp

func init():
	textSize = 15
	text = "??"

func onTargetEnter(target):

	print("target enter v",target.velocity)
	# label animation
	label.position = Vector2(0,0)
	label.pivot_offset = Vector2(label.size.x/2,label.size.y)

	var s1 = Actions.ScaleTo.new(1.3,0.05).easeOutCirc()
	var s2 = Actions.ScaleTo.new(1,0.1).easeInCirc()
	var seq = Actions.Seq.new([s1,s2]).run(label)
	# target animation
	target.setGravity(0)
	var randX = randf_range(-50,50)
	var randY = randf_range(-100,-150)
	var pry = Actions.MoveBy.new(Vector2(randX,randY),0.35,func():
		print("rand over")
		target.resumeGravity()).easeOutCubic().run(target)
	
func onTargetExited(target):
	print("target exited v",target.velocity)
	
