extends Trap
class_name TrapPlot

var plotName
var plotAreaSize
var plotEndCall

func _init(name,size = Vector2(100,100),finishCall = null):
	plotName = name
	plotAreaSize = size
	plotEndCall = finishCall

func _ready():
	print("trap ready")
	initCollisionLayerAndMask()

	# var isShow = not UserData.isPlotGainedInCurLv(plotName)
	var isShow = true
	setCollisionEnabled(isShow)
	self.visible = isShow

func onTargetEnter(target):
	UserData.setPlotGainedInCurLv(plotName)
	setCollisionEnabled(false)
	Events.StartPlot.emit(plotName,plotEndCall)
	
func onTargetExited(target):
	pass

func addBody():
	shape = CollisionShape2D.new()
	self.add_child(shape)
	var rect = RectangleShape2D.new()
	rect.size = plotAreaSize
	shape.shape = rect
	shape.position = Vector2(rect.size.x / 2, rect.size.y / 2)
	isAddBody = true
