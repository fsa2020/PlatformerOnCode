extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var floorNode = $"../PlatformerFloor"
@onready var player = $"../PlatformerController2D"

#func _ready():
#	initTrapsByLv(0)

var trapList = []

func initTrapsByLv(lv):
	trapList = []
	var doors = []
	for cfg in TrapCfg.levels["lv"+str(lv)]:
		var trap = cfg["trap"]
		self.add_child(trap)
		trapList.append(trap)
		trap.owner = self.owner
		var pos = cfg["pos"]
		if typeof(pos) == TYPE_VECTOR2:
			trap.position = pos
		elif typeof(pos) == TYPE_DICTIONARY:
			var lineIndex = pos.line-1
			var wordIndex = pos.count-1+4
			var offsetV = Vector2(0,0)
			if pos.has("offset"):
				offsetV = pos.offset
			trap.position = offsetV + Vector2(
				TrapCfg.singleCharWidth*wordIndex,
				TrapCfg.layerHeight*lineIndex)
#			print(trap.position)
		if trap.has_method("setConnectDoor"):
			doors.append(trap)
	# init doors
	for i in range(len(doors)):
		for j in range(i+1,len(doors)):
			if doors[i].doorId == doors[j].doorId:
				doors[i].setConnectDoor(doors[j])	
				doors[j].setConnectDoor(doors[i])	
		
func clearTrap():
	for trap in trapList:
		trap.get_parent().remove_child(trap) 
		
func reset():
	for trap in trapList:
		if trap.has_method("reset"):
			trap.reset()
