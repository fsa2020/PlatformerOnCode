extends Trap
class_name TrapPryRight

func init():
	textSize = 15
	text = "\\"

func onTargetEnter(target):

	print("target enter v",target.velocity)
	Events.playEffectSound.emit("Bubble heavy 1.wav")
	# label animation
	label.position = Vector2(0,0)
	label.pivot_offset = Vector2(label.size.x,label.size.y)

	var r1 = Actions.RotateBy.new(-80,0.05).easeOutCirc()
	var r2 = Actions.RotateBy.new(80,0.1).easeInCirc()
	Actions.Seq.new([r1,r2]).run(label)
	# # target animation
	# target.setGravity(0)
	# Actions.MoveBy.new(Vector2(200,-80),0.35,func():
	# 	print("pry over")
	# 	target.resumeGravity()).easeOutCubic().run(target)
	target.velocity = Vector2(1000,-400)
	
func onTargetExited(target):
	print("target exited v",target.velocity)
	
