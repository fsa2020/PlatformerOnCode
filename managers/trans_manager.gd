extends Node
class_name TransManager
# Called when the node enters the scene tree for the first time.




func _ready():
	Events.createTransLv4Start.connect(createTransLv4Start)

#	Actions.Delay.new(0.5,transTest).run(self)
	


func _process(delta):
	pass

@onready var floorNode = $"../PlatformerFloor"
@onready var camera = $"../Camera2D"
@onready var player = $"../PlatformerController2D"

func transTest():
	var blocks = floorNode.getBlocksInScreen()
	var ball = Ball.new(self,blocks,player)
	var tamplates =  ball.getSelectedTemplates()
	for b in tamplates:
		b.playShake()
	
	Actions.Delay.new(0.5,func():
		for b in ball.getSelectedTemplates():
			b.stopShake()
			b.setCollisionEnabled(false)
			b.visible = false
		ball.runPack()).run(self)
		

func createTransLv4Start():
	
	var blocks = floorNode.getBlocksInScreen()
	var rocket = Rocket.new(self,blocks,player)
	var tamplates =  rocket.getSelectedTemplates()
	for b in tamplates:
		b.playShake()


	player.velocity = Vector2(0,0)

	Actions.Delay.new(0.5,func():
		for b in rocket.getSelectedTemplates():
			b.stopShake()
			b.setCollisionEnabled(false)
			b.visible = false
		rocket.runPack()
	
		var moveRocket = Actions.MoveBy.new(Vector2(0,-4500),10,func():

			player.velocity = Vector2(-700,-500)
			rocket.runBreakApart())


		Actions.Delay.new(1.5,func(): 
			rocket.stopShake()
			moveRocket.run(rocket)).run(self)

	).run(self)


	

