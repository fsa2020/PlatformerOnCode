extends Trap
class_name TrapWind

var size
var height
var direction
var speed
func _init(s = 3,h=100,speed = 20,dir = Vector2(0,-1)):
	size = s
	height = h
	direction = dir.normalized()

func init():
	textSize = 15	
	text = "<"
	for i in range(size):
		text += "+"
	text += ">"

func _process(delta):
	for body in get_overlapping_bodies():
		processBody(body,delta)
		
func onTargetEnter(target):
	pass
	
func onTargetExited(target):
	pass

func processBody(body,delta):
	if body.velocity.y <= -200: return
	body.velocity.y -= speed*delta*direction
	
func addBody():
	shape = CollisionShape2D.new()
	self.add_child(shape)
	var rect = RectangleShape2D.new()
	rect.size = Vector2(label.get_rect().size.x,height) 
	shape.shape = rect
	shape.position = Vector2(rect.size.x / 2, rect.size.y )
	
	addExtraBody()
	isAddBody = true

	# rotate
	var angle = direction.angle_to(Vector2(0,-1))
	var degrees = rad_to_deg(angle)
	self.rotation_degrees = degrees	
