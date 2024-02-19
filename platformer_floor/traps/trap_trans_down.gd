extends Trap
class_name TrapTransDown

var h = 0
var w = 0

func _init(height=10,width=5):
	h = height
	w = width

func init():
	textSize = 15
	var l = ""
	for i in range(w): l += "v"
	text = l
	for i in range(h-1):text += "\n"+l
	

func onTargetEnter(target):
	var moveY = label.global_position.y + label.size.y - target.global_position.y +20
	var moveX = label.global_position.x + label.size.x/2 - target.global_position.x 
	var speedX = 200.0
	var speedY = 400.0
	var xTime = abs(moveX)/speedX
	var yTime = abs(moveY)/speedY
	# target animation
	target.setCollisionLayer(0)
	target.setGravity(0)
	target.velocity = Vector2.ZERO
	
	var centerPos = Vector2(target.position.x+moveX,target.position.y)
	var moveCenter = Actions.MoveTo.new(centerPos,xTime)
	
	var upPos = Vector2(target.position.x+moveX,target.position.y+moveY)
	var moveUp = Actions.MoveTo.new(upPos,yTime)

	Actions.Seq.new([moveCenter,moveUp],func():
		print("trans down over")
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
	rect.size = Vector2(label.size.x+10,20)
	capShape.shape = rect
	capShape.position = Vector2(label.size.x/2, label.size.y)
