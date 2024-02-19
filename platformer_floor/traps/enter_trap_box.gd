extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.area_entered.connect(_onEnterTrap)
	self.area_exited.connect(_onExitedTrap)
	
func _onEnterTrap(trapArea):
#	print("_onEnterTrap")
#	print(self,trapArea)
	if trapArea.has_method("onTargetEnter"):
		trapArea.onTargetEnter(self.get_parent())
	
func _onExitedTrap(trapArea):
#	print("_onExitedTrap")
#	print(self,trapArea)
	if trapArea.has_method("onTargetExited"):
		trapArea.onTargetExited(self.get_parent())
