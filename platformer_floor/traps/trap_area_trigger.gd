extends Trap
class_name  TrapAreaTrigger

var triggerId
# id == 401 : lv 4 trigger 1
# id == 2022 : lv 10 trigger 22
func _init(id):
	triggerId = id
	textColor = Color.DARK_ORANGE
func init():
	text = "[@]"
	
func onTargetEnter(target):
	print("TrapAreaTrigger on")
	Events.TrapTiggerOn.emit(triggerId)
	Events.playEffectSound.emit("Big Egg collect 1.wav")
	
func onTargetExited(target):
	pass
	
