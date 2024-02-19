extends Trap
class_name TrapTransRight

var h = 0
var w = 0

func _init(height=3,width=20):
	h = height
	w = width

func init():
	textSize = 15
	var l = ""
	for i in range(w): l += ">"
	text = l
	for i in range(h-1):text += "\n"+l
	

func onTargetEnter(target):
	var moveY = label.global_position.y + label.size.y/2 - target.global_position.y
	var moveX = label.global_position.x + label.size.x - target.global_position.x + 50
	var speedX = 400.0
	var speedY = 200.0
	var xTime = abs(moveX)/speedX
	var yTime = abs(moveY)/speedY
	# target animation
	target.setCollisionLayer(0)
	target.setGravity(0)
	target.velocity = Vector2.ZERO
	
	var centerPos = Vector2(target.position.x,target.position.y+moveY)
	var moveCenter = Actions.MoveTo.new(centerPos,yTime)
	
	var xPos = Vector2(target.position.x+moveX,target.position.y+moveY)
	var moveUp = Actions.MoveTo.new(xPos,xTime)

	Actions.Seq.new([moveCenter,moveUp],func():
		print("trans right over")
		target.resumeCollisionLayer()
		target.resumeGravity()).run(target)
		
# todo add a cap 
var cap
var capShape

func addExtraBody():
	cap = StaticBody2D.new()
	capShape = CollisionShape2D.new()
	capShape.debug_color = Color("#6257f7")

	self.add_child(cap)
	cap.add_child(capShape)

	var rect = RectangleShape2D.new()
	rect.size = Vector2(20,label.size.y+10)
	capShape.shape = rect
	capShape.position = Vector2(label.size.x,label.size.y/2)
