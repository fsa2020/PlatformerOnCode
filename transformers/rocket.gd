extends Trans
class_name Rocket
func getShapeWords():
	return [
	"                        #                               ",
	"                      #####                             ",
	"                  #############                         ",
	"                  #############                         ",
	"                  #############                         ",
	"                   ###########                          ",
	"                   ##       ##                          ",
	"                   ##       ##                          ",
	"                   ##       ##                          ",
	"                   ##       ##                          ",
	"                   ##       ##                          ",
	"                   ##       ##                          ",
	"                   ###########                          ",
	"               ###################                      ",
	"                 ###############                        ",
	"                ###     ##    ###                       ",

	]

# func getShapeWords():
# 	return [
# 	"                        ##                             ",
# 	"                        ##                             ",]

func getInitalOffset():
	var cW = charWidth
	var cH = charHeight
	var shape = getShapeWords()
	var h = len(shape)
	var w = len(shape[0])

	return Vector2(-w*cW*0.5, -h*cH*0.5)

func onPackOverAll():
	print("onPackOverAll")
	addArea2D()
	playShake()

var actionShake

var rng = RandomNumberGenerator.new()

func playShake():
	if actionShake!= null:return


	var randX =  rng.randf_range(-10.0, 10.0)
	var randY =  rng.randf_range(-5.0, 5.0)
	
	var move1 = Actions.MoveBy.new(Vector2(randX,randY),0.02)
	var move2 = Actions.MoveBy.new(Vector2(-randX,-randY),0.02)
	
	actionShake = Actions.Seq.new([
		move1,move2
	],func():
		stopShake()
		playShake()
	).run(self)

func stopShake():
	if actionShake == null:return
	actionShake.stop()
	actionShake = null

func _process(delta):
	destroyFloorBlock()


var blockEnterAreaDict = {}
func destroyFloorBlock():
	for area in areas:
		for body in area.get_overlapping_bodies():
			var floorBlock = body.get_parent()
			if ! blockEnterAreaDict.has(floorBlock):
				blockEnterAreaDict[floorBlock] = true
				if floorBlock.has_method("playExplode") and floorBlock.isOrgFloorBlock: 
					floorBlock.playExplode()
					floorBlock.setCollisionEnabled(false)		
var areas = []
func addArea2D():	
	for binfo in needBlockInfos:
		var area = Area2D.new()
		var shape = CollisionShape2D.new()
		area.add_child(shape)
		var rect = RectangleShape2D.new()
		rect.size = Vector2(charWidth*binfo.len+40,charHeight+20)
		shape.shape = rect
#		shape.position =  Vector2(rect.size.x / 2, rect.size.y / 2)
		shape.position =  Vector2(-20, 0)
		area.position = binfo.pos 
		areas.append(area)
		self.add_child(area)


		area.collision_layer = 1
		area.collision_mask = 1

		# area.area_entered.connect(onEntered)
		# area.area_exited.connect(onExited)

# func onEntered(block):
# 	print(block,"entered rocket")
# 	if block.has_method("playExplode"):
# 		print(block,"block entered rocket")


# func onExited(block):
# 	print(block,"onExited rocket")
