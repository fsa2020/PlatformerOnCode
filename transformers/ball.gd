extends Trans
class_name Ball
func getShapeWords():
	return [
	"                     ########                          ",
	"                   ############                        ",
	"                  ####      ####                       ",
	"                  ####      ####                       ",
	"                   ############                        ",
	"                     ########                          ",
	]


func getInitalOffset():
	var cW = charWidth
	var cH = charHeight
	var shape = getShapeWords()
	var h = len(shape)
	var w = len(shape[0])

	return Vector2(-w*cW*0.5, -h*cH*0.5)

func onPackOverAll():
	print("onPackOverAll")
	addRigidBody2D()
	Actions.RotateBy.new(720,1.0).run(self)

var rigidBody 
func addRigidBody2D():	
	var body = RigidBody2D.new()
	var shape = CollisionShape2D.new()
	body.add_child(shape)
	var circle = CircleShape2D.new()
	circle.radius = 100
	shape.shape = circle
	shape.position =  Vector2(0,0)
	body.position = Vector2(0,0)
	rigidBody = body
	self.add_child(body)


	body.collision_layer = 16
	body.collision_mask = 1
