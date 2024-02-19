extends TrapAbility
class_name TrapResetJump

func init():
	# todo set by user level data
	text = "(^)"
	textColor = Color.GREEN

var cdTime = 5.0
var isReloading = false

func reload():
	if not isReloading :
		setCollisionEnabled(false)
		isReloading = true
		
		var fadeT = 0.3
		var fadeIn = Actions.FadeIn.new(fadeT)
		var delay = Actions.Delay.new(cdTime-fadeT*2)
		var fadeOut = Actions.FadeOut.new(fadeT)
		var reLoadAction = Actions.Seq.new([fadeIn,delay,fadeOut],func ():
			setCollisionEnabled(true)
			isReloading = false)
		

		reLoadAction.run(label)

func onTargetEnter(target):
	print("TrapResetJump",target)
	if not isReloading and target.has_method("addTempJumpTime") :
		target.addTempJumpTime()
		reload()
	
	
