extends Trap
class_name TrapScore

var scoreNum = 1
var scoreId

func _init(id):
	scoreId = id

func init():
	# todo set by user level data
	text = "<S>"
	textColor = Color.GREEN

func _ready():
	print("trap ready")
	initCollisionLayerAndMask()
	init()
	addLabel()
	
	var isShow = not UserData.isScoreGainedInCurLv(scoreId)
	setCollisionEnabled(isShow)
	self.visible = isShow

func onTargetEnter(target):
	UserData.setScoreGainedInCurLv(scoreId)
	setCollisionEnabled(false)
	var fadeT = 0.3
	var fadeIn = Actions.FadeIn.new(fadeT)
	var moveUp = Actions.MoveBy.new(Vector2(0,-50),fadeT)
	Actions.Merge.new([fadeIn,moveUp]).run(self)

	Events.CmdOut.emit("get a score ,id: "+str(scoreId))
	Events.playEffectSound.emit("Big Egg collect 1.wav")
	
func onTargetExited(target):
	pass
