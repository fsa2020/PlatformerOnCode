extends Node

var singleCharWidth = 8
var layerHeight = 25
var playerPos = {
	"lv0" = {line = 80,count = 65,offset = Vector2(0,0)},
	"lv1" = {line = 106,count = 85,offset = Vector2(0,0)},
	"lv2" = {line = 114,count = 85,offset = Vector2(0,0)},
	"lv3" = {line = 129,count = 80,offset = Vector2(0,0)},
	# "lv3" = {line = 17,count = 36,offset = Vector2(0,0)},
	# "lv4" = {line = 190,count = 80,offset = Vector2(0,0)},
	"lv4" = {line = 163,count = 80,offset = Vector2(0,0)},

}
var savingPoints = {
	"lv0" = [
		{line = 80,count = 80,offset = Vector2(0,0)},
	],
	"lv1" = [
		{line = 107,count = 65,offset = Vector2(0,0)},
		{line = 77,count = 14,offset = Vector2(0,0)},
	],
	"lv2" = [
		{line = 115,count = 14,offset = Vector2(0,0)},
		{line = 102,count = 70,offset = Vector2(0,0)},
		{line = 90,count = 25,offset = Vector2(0,0)},
		{line = 85,count = 93,offset = Vector2(0,0)},
		{line = 85,count = 60,offset = Vector2(0,0)},
		{line = 80,count = 30,offset = Vector2(0,0)},
		{line = 70,count = 10,offset = Vector2(0,0)},
		{line = 50,count = 15,offset = Vector2(0,0)},
		{line = 27,count = 15,offset = Vector2(0,0)},
		{line = 13,count = 60,offset = Vector2(0,0)},
	],
	"lv3" = [
		{line = 129,count = 80,offset = Vector2(0,0)},
		{line = 109,count = 15,offset = Vector2(0,0)},
		{line = 98,count = 14,offset = Vector2(0,0)},
		{line = 76,count = 60,offset = Vector2(0,0)},
		{line = 59,count = 30,offset = Vector2(0,0)},
		{line = 37,count = 50,offset = Vector2(0,0)},
	],
	"lv4" = [
		{line = 192,count = 80,offset = Vector2(0,0)},
		{line = 192,count = 44,offset = Vector2(0,0)},
		{line = 172,count = 21,offset = Vector2(0,0)},
	],
}

var levels = {
	"lv0" = [
		# {
		# 	"pos" = {
		# 		line = 80,
		# 		count = 50,
		# 	},

		# 	"trap" = TrapEvent.new("createTrans")
		# },
		# {
		# 	"pos" = {
		# 		line = 73,
		# 		count = 76,
		# 		offset = Vector2(0,-30)
		# 	},

		# 	"trap" = TrapDoor.new(999,false)
		# },
		# {
		# 	"pos" = {
		# 		line = 81,
		# 		count = 80,
		# 		offset = Vector2(0,-30)
		# 	},

		# 	"trap" = TrapDoor.new(999,false)
		# },

		{
			"pos" = {
				line = 80,
				count = 65,
			},

			"trap" = TrapPlot.new("lv0guide1")
		},
		
		{
			"pos" = {
				line = 72,
				count = 63,
			},

			"trap" = TrapPlot.new("lv0guide2",Vector2(40,10))
		},
		{
			"pos" = {
				line = 61,
				count = 12,
			},

			"trap" = TrapPlot.new("lv0guide3",Vector2(30,30))
		},

		{
			"pos" = {
				line = 78,
				count = 1,
			},
			"trap" = TrapSpring.new()
		},
		{
			"pos" = {
				line = 65,
				count = 32,
			},
			"trap" = TrapPryRight.new()
		},
		{
			"pos" = {
				line = 65,
				count = 58,
			},
			"trap" = TrapSpring.new()
		},
		{
			"pos" = {
				line = 57,
				count = 10,
			},
			"trap" = TrapLevelEnter.new(1)
		},
	],

	"lv1" = [
		{
			"pos" = {
				line = 107,
				count = 14,
			},

			"trap" = TrapSpring.new()
		},
		{
			"pos" = {
				line = 103,
				count = 48,
			},

			"trap" = TrapScore.new(1)
		},
		{
			"pos" = {
				line = 94,
				count = 40,
			},

			"trap" = TrapSpring.new()
		},
		{
			"pos" = {
				line = 89,
				count = 72,
			},

			"trap" = TrapScore.new(2)
		},
		{
			"pos" = {
				line = 89,
				count = 9,
			},

			"trap" = TrapPryRight.new()
		},
		{
			"pos" = {
				line = 83,
				count = 42,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 80,
				count = 72,
			},

			"trap" = TrapPryLeft.new()
		},
		{
			"pos" = {
				line = 75,
				count = 48,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 75,
				count = 85,
			},

			"trap" = TrapScore.new(3)
		},
		{
			"pos" = {
				line = 89,
				count = 0,
			},

			"trap" = TrapSpringPro.new(-1500)
		},
		{
			"pos" = {
				line = 63,
				count = 9,
			},

			"trap" = TrapScore.new(4)
		},
		{
			"pos" = {
				line = 59,
				count = 48,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 55,
				count = 48,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 53,
				count = 88,
			},

			"trap" = TrapSpring.new()
		},
		{
			"pos" = {
				line = 43,
				count = 10,
			},

			"trap" = TrapSpring.new()
		},
		{
			"pos" = {
				line = 36,
				count = 36,
			},

			"trap" = TrapScore.new(5)
		},
		{
			"pos" = {
				line = 42,
				count = 53,
			},

			"trap" = TrapSpring.new()
		},
		{
			"pos" = {
				line = 30,
				count = 64,
			},

			"trap" = TrapSpring.new()
		},
		{
			"pos" = {
				line = 21,
				count = 38,
			},

			"trap" = TrapSpringPro.new()
		},
		{
			"pos" = {
				line = 4,
				count = 40,
			},

			"trap" = TrapPlot.new("lv1endPlot",Vector2(100,100), func():
				Events.StepIntoLv.emit(2))
		},
		# {
		# 	"pos" = {
		# 		line = 14,
		# 		count = 55,
		# 	},

		# 	"trap" = TrapLevelEnter.new(2)
		# },
		
	],
	"lv2" = [
		############ doors and key ##############
		{
			"pos" = {
				line = 74,
				count = 24,
			},

			"trap" = TrapKeyFollow.new(1)
		},
		{
			"pos" = {
				line = 126,
				count = 9,
				offset = Vector2(0,-30)
			},

			"trap" = TrapDoor.new(1,true)
		},
		{
			"pos" = {
				line = 71,
				count = 7,
				offset = Vector2(0,-30)
			},

			"trap" = TrapDoor.new(1,false)
		},
		############ no.1 ##############
		{
			"pos" = {
				line = 123,
				count = 48,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 123,
				count = 32,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 124,
				count = 2,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 123,
				count = 2,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 122,
				count = 2,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 121,
				count = 2,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 120,
				count = 2,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 119,
				count = 2,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 118,
				count = 2,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 117,
				count = 2,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 116,
				count = 2,
			},

			"trap" = TrapResetJump.new()
		},
		############ no.2 ##############
		{
			"pos" = {
				line = 113,
				count = 18,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 113,
				count = 36,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 113,
				count = 53,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 100,
				count = 50,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 101,
				count = 45,
				offset = Vector2(0,-10)
			},

			"trap" = TrapDead.new()
		},
		############ no.3 ##############
		{
			"pos" = {
				line = 97,
				count = 15,
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(0,-250),2.0),
					Actions.MoveBy.new(Vector2(0,250),2.0)
				])
			)) 
		},
		{
			"pos" = {
				line = 95,
				count = 20,
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(0,-125),1.0),
					Actions.MoveBy.new(Vector2(0,125),1.0)
				])
			)) 
		},
		{
			"pos" = {
				line = 91,
				count = 33,
				offset = Vector2(0,30)
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(0,-100),1.0),
					Actions.MoveBy.new(Vector2(0,100),1.0)
				])
			)) 
		},
		{
			"pos" = {
				line = 91,
				count = 51,
				offset = Vector2(0,30)
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(0,-100),1.0),
					Actions.MoveBy.new(Vector2(0,100),1.0)
				])
			)) 
		},		
		{
			"pos" = {
				line = 91,
				count = 68,
				offset = Vector2(0,30)
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(0,-100),1.0),
					Actions.MoveBy.new(Vector2(0,100),1.0)
				])
			)) 
		},
		{
			"pos" = {
				line = 89,
				count = 30,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 89,
				count = 48,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 89,
				count = 66,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 87,
				count = 88,
			},

			"trap" = TrapResetJump.new()
		},
		############ no.4 ##############
		{
			"pos" = {
				line = 86,
				count = 79,
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(0,-220),1.5),
					Actions.MoveBy.new(Vector2(0,220),1.5)
				])
			)) 
		},		
		{
			"pos" = {
				line = 75,
				count = 93,
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(0,220),1.5),
					Actions.MoveBy.new(Vector2(0,-220),1.5)
				])
			)) 
		},
		{
			"pos" = {
				line = 83,
				count = 86,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 79,
				count = 86,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 75,
				count = 86,
			},

			"trap" = TrapResetJump.new()
		},
		############ no.5 ##############
		{
			"pos" = {
				line = 86,
				count = 25,
				offset = Vector2(0,10)
			},

			"trap" = TrapDeadLine.new(25)
		},
		{
			"pos" = {
				line = 84,
				count = 23,
			},

			"trap" = TrapScore.new(1)
		},
		{
			"pos" = {
				line = 86,
				count = 52,
			},

			"trap" = TrapPryLeft.new()
		},
		{
			"pos" = {
				line = 80,
				count = 6,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 77,
				count = 15,
				offset = Vector2(0,10)
			},

			"trap" = TrapDeadLine.new(20)
		},
		{
			"pos" = {
				line = 79,
				count = 36,
				offset = Vector2(0,10)
			},

			"trap" = TrapSpring.new()
		},
		{
			"pos" = {
				line = 76,
				count = 35,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 76,
				count = 24,
			},

			"trap" = TrapResetJump.new()
		},
		############ no.6 ##############
		{
			"pos" = {
				line = 71,
				count = 19,
				offset = Vector2(0,10)
			},

			"trap" = TrapDeadLine.new(40)
		},
		{
			"pos" = {
				line = 71,
				count = 15,
			},

			"trap" = TrapPryRight.new()
		},
		# {
		# 	"pos" = {
		# 		line = 69,
		# 		count = 43,
		# 	},

		# 	"trap" = TrapResetJump.new()
		# },
		{
			"pos" = {
				line = 67,
				count = 57,
			},

			"trap" = TrapPryLeft.new()
		},
		############ no.7 ##############
		{
			"pos" = {
				line = 57,
				count = 31,
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(120,0),1.5),
					Actions.MoveBy.new(Vector2(-120,0),1.5)
				])
			)) 
		},
		{
			"pos" = {
				line = 51,
				count = 27,
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(120,0),1.5),
					Actions.MoveBy.new(Vector2(-120,0),1.5)
				])
			)) 
		},
		{
			"pos" = {
				line = 50,
				count = 2,
				offset = Vector2(0,10)
			},

			"trap" = TrapSpring.new()
		},
		{
			"pos" = {
				line = 45,
				count = 8,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 40,
				count = 48,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 38,
				count = 40,
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(120,0),1.5),
					Actions.MoveBy.new(Vector2(-120,0),1.5)
				])
			)) 
		},
		############ no.8 ##############
		{
			"pos" = {
				line = 28,
				count = 27,
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(80,0),1.0),
					Actions.MoveBy.new(Vector2(-80,0),1.0)
				])
			)) 
		},
		{
			"pos" = {
				line = 27,
				count = 7,
				offset = Vector2(0,10)
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(0,-200),2.0),
					Actions.MoveBy.new(Vector2(0,200),2.0)
				])
			)) 
		},
		{
			"pos" = {
				line = 23,
				count = 24,
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(120,0),2.0),
					Actions.MoveBy.new(Vector2(-120,0),2.0)
				])
			)) 
		},
		{
			"pos" = {
				line = 23,
				count = 41,
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(120,0),2.0),
					Actions.MoveBy.new(Vector2(-120,0),2.0)
				])
			)) 
		},
		{
			"pos" = {
				line = 23,
				count = 58,
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(120,0),2.0),
					Actions.MoveBy.new(Vector2(-120,0),2.0)
				])
			)) 
		},
		{
			"pos" = {
				line = 22,
				count = 32,
			},

			"trap" = TrapScore.new(1)
		},
		{
			"pos" = {
				line = 23,
				count = 32,
			},

			"trap" = TrapSpring.new()
		},
		{
			"pos" = {
				line = 22,
				count = 47,
			},

			"trap" = TrapScore.new(2)
		},
		{
			"pos" = {
				line = 23,
				count = 47,
			},

			"trap" = TrapSpring.new()
		},
		{
			"pos" = {
				line = 22,
				count = 64,
			},

			"trap" = TrapScore.new(3)
		},
		{
			"pos" = {
				line = 23,
				count = 64,
			},

			"trap" = TrapSpring.new()
		},
		{
			"pos" = {
				line = 19,
				count = 73,
				offset = Vector2(0,10)
			},

			"trap" = TrapSpring.new()
		},
		############ no.9 ##############
		{
			"pos" = {
				line = 10,
				count = 30,
			},

			"trap" = TrapPlot.new("lv2endPlot")
		},
		{
			"pos" = {
				line = 13,
				count = 10,
			},

			"trap" = TrapLevelEnter.new(3)
		},
	],
	"lv3" = [
		####### start  #######
		{
			"pos" = {
				line = 130,
				count = 55,
			},

			"trap" = TrapPlot.new("lv3startPlot",Vector2(100,100),func():
				Events.BlockShakeAndFallStart.emit())
		},
		{
			"pos" = {
				line = 123,
				count = 62,
			},

			"trap" = TrapScore.new(1)
		},
		{
			"pos" = {
				line = 117,
				count = 48,
				offset = Vector2(0,10)
			},

			"trap" = TrapSpring.new()
		},
		{
			"pos" = {
				line = 114,
				count = 55,
			},

			"trap" = TrapSpring.new()
		},

		####### savingPoint 1 #######
		{
			"pos" = {
				line = 104,
				count = 20,
			},

			"trap" = DispatchWrapper.new(TrapSpringPro.new(-900),Vector2(80,20))
		},

		
		####### savingPoint 2 #######
		{
			"pos" = {
				line = 96,
				count = 45,
			},

			"trap" = DispatchWrapper.new(TrapSpring.new())
		},		
		{
			"pos" = {
				line = 96,
				count = 60,
			},

			"trap" = DispatchWrapper.new(TrapSpring.new())
		},
		{
			"pos" = {
				line = 89,
				count = 12,
			},

			"trap" = TrapScore.new(2)
		},
		{
			"pos" = {
				line = 86,
				count = 18,
			},

			"trap" = TrapScore.new(3)
		},
		{
			"pos" = {
				line = 86,
				count = 40,
			},

			"trap" = TrapPryRight.new()
		},
		{
			"pos" = {
				line = 85,
				count = 89,
			},

			"trap" = DispatchWrapper.new(TrapPryLeft.new())
		},
		{
			"pos" = {
				line = 86,
				count = 89,
			},

			"trap" = TrapSpring.new()
		},
		{
			"pos" = {
				line = 82,
				count = 49,
			},

			"trap" = TrapSpring.new()
		},
		# {
		# 	"pos" = {
		# 		line = 82,
		# 		count = 80,
		# 	},

		# 	"trap" = TrapSpring.new()
		# },
		####### savingPoint 3 #######
		{
			"pos" = {
				line = 75,
				count = 65,
			},

			"trap" = DispatchWrapper.new(TrapSpring.new())
		},
		{
			"pos" = {
				line = 74,
				count = 70,
			},

			"trap" = DispatchWrapper.new(TrapPryLeft.new())
		},
		{
			"pos" = {
				line = 68,
				count = 30,
			},

			"trap" = TrapScore.new(4)
		},
		####### savingPoint 4 #######
		{
			"pos" = {
				line = 59,
				count = 30,
			},

			"trap" = TrapEvent.new("BlockShakeAndFallStop")
		},
		{
			"pos" = {
				line = 59,
				count = 10,
			},

			"trap" = TrapSpring.new()
		},
		{
			"pos" = {
				line = 57,
				count = 10,
			},

			"trap" = TrapEvent.new("BlockShakeAndFallStart")
		},
		{
			"pos" = {
				line = 47,
				count = 10,
			},

			"trap" = DispatchWrapper.new(TrapSpring.new()) 
		},
		{
			"pos" = {
				line = 43,
				count = 8,
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(120,0),2.0),
					Actions.MoveBy.new(Vector2(-120,0),2.0)
				])
			)) 
		},
		{
			"pos" = {
				line = 43,
				count = 60,
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(120,0),2.0),
					Actions.MoveBy.new(Vector2(-120,0),2.0)
				])
			)) 
		},
		{
			"pos" = {
				line = 40,
				count = 42,
			},

			"trap" = TrapResetJump.new()
		},
		{
			"pos" = {
				line = 40,
				count = 80,
			},

			"trap" = TrapScore.new(5)
		},
		####### savingPoint 5 #######
		# 1
		{
			"pos" = {
				line = 37,
				count = 55,
			},

			"trap" = TrapPryLeft.new()
		},
		{
			"pos" = {
				line = 36,
				count = 48,
			},

			"trap" = DispatchWrapper.new(TrapSpring.new())
		},
		{
			"pos" = {
				line = 32,
				count = 7,
			},

			"trap" = TrapDeadLine.new(10,true)
		},
		{
			"pos" = {
				line = 31,
				count = 8,
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(120,0),2.0),
					Actions.MoveBy.new(Vector2(-120,0),2.0)
				])
			)) 
		},
		# 2
		{
			"pos" = {
				line = 30,
				count = 6,
			},

			"trap" = TrapPryRight.new()
		},
		{
			"pos" = {
				line = 29,
				count = 19,
			},

			"trap" = DispatchWrapper.new(TrapSpring.new())
		},
		{
			"pos" = {
				line = 25,
				count = 49,
			},

			"trap" = TrapDeadLine.new(10,true)
		},
		{
			"pos" = {
				line = 24,
				count = 30,
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(120,0),2.0),
					Actions.MoveBy.new(Vector2(-120,0),2.0)
				])
			)) 
		},
		# 3
		{
			"pos" = {
				line = 23,
				count = 55,
			},

			"trap" = TrapPryLeft.new()
		},
		{
			"pos" = {
				line = 20,
				count = 23,
			},

			"trap" = TrapPryRight.new()
		},
		{
			"pos" = {
				line = 19,
				count = 35,
			},

			"trap" = DispatchWrapper.new(TrapSpring.new())
		},
		{
			"pos" = {
				line = 15,
				count = 7,
			},

			"trap" = TrapDeadLine.new(10,true)
		},
		{
			"pos" = {
				line = 13,
				count = 60,
			},

			"trap" = TrapPryLeft.new()
		},
		{
			"pos" = {
				line = 14,
				count = 37,
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(120,0),2.0),
					Actions.MoveBy.new(Vector2(-120,0),2.0)
				])
			)) 
		},
		# end
		{
			"pos" = {
				line = 11,
				count = 27,
			},

			"trap" = TrapEvent.new("BlockShakeAndFallStop")
		},
		{
			"pos" = {
				line = 11,
				count = 7,
			},

			"trap" = TrapPlot.new("lv3endPlot",Vector2(100,100),func():
				Events.StepIntoLv.emit(4))
		},
	],
	"lv4" = [
		####### start #######
		{
			"pos" = {
				line = 192,
				count = 65,
			},
			"trap" = TrapPlot.new("lv4startPlot")
		},
		# {
		# 	"pos" = {
		# 		line = 174,
		# 		count = 45,
		# 	},
		# 	"trap" = TrapEvent.new("createTransLv4Start")
	
		# },
		####### savingPoint 1 #######
		{
			"pos" = {
				line = 195,
				count = 38,
			},

			"trap" = MoveWrapper.new(TrapDead.new(),Actions.Repeat.new(
				Actions.Seq.new([
					Actions.MoveBy.new(Vector2(0,-220),2.0),
					Actions.MoveBy.new(Vector2(0,220),2.0)
				])
			)) 
		},
		{
			"pos" = {
				line = 185,
				count = 42,
			},

			"trap" = DispatchWrapper.new(TrapPryRight.new())
		},
		{
			"pos" = {
				line = 181,
				count = 68,
			},

			"trap" = DispatchWrapper.new(TrapPryLeft.new())
		},
		{
			"pos" = {
				line = 181,
				count = 37,
			},

			"trap" = TrapAreaTrigger.new(401)
		},
		{
			"pos" = {
				line = 190,
				count = 17,
			},

			"trap" = Block.new("###",true).addAction(
				Actions.Repeat.new(Actions.Seq.new([
					Actions.MoveBy.new(Vector2(0,-200),2.0),
					Actions.MoveBy.new(Vector2(0,200),2.0)]))
				,401)
		},

		####### savingPoint 2 #######
		{
			"pos" = {
				line = 169,
				count = 15,
			},

			"trap" = TrapAreaTrigger.new(402)
		},
		{
			"pos" = {
				line = 173,
				count = 40,
			},

			"trap" = Block.new("###",true).addAction(
				Actions.Repeat.new(Actions.Seq.new([
					Actions.MoveBy.new(Vector2(200,0),2.0),
					Actions.MoveBy.new(Vector2(-200,0),2.0)]))
				,402)
		},
		{
			"pos" = {
				line = 173,
				count = 93,
			},

			"trap" = Block.new("###",true).addAction(
				Actions.Repeat.new(Actions.Seq.new([
					Actions.MoveBy.new(Vector2(0,-100),1.5),
					Actions.MoveBy.new(Vector2(0,100),1.5)]))
				,402)
		},

		{
			"pos" = {
				line = 174,
				count = 37,
				offset = Vector2(0,10)
			},

			"trap" = TrapDeadLine.new(25)
		},


		{
			"pos" = {
				line = 167,
				count = 60,
			},
			"trap" = TrapPlot.new("lv4transPlot",Vector2(100,40),func():
				Events.createTransLv4Start.emit())
		},
		{
			"pos" = {
				line = 4,
				count = 15,
			},

			"trap" = TrapPlot.new("lv4endPlot",Vector2(100,100))
		},
	]
}

############################ plots #############################
var plots = {
	"prologue" = [
		{
			"word" = "A start scene ,to be modified",
			"character" = [null,null],
			"expression" = null,
			"bg" = null
		},
	],
	"lv0guide1" = [
		{
			"word" = " A guide ",
			"character" = [0,null],
			"expression" = null,
			"bg" = null
		},
		{
			"word" = " Press a /space to jump",
			"character" = [0,null],
			"expression" = null,
			"bg" = null
		},
	],
	"lv0guide2" = [
		{
			"word" = "Press Lt/ctrl to grab wall",
			"character" = [0,null],
			"expression" = null,
			"bg" = null
		},
	],
	"lv0guide3" = [
		{
			"word" = "Come near [Error] press B/E",
			"character" = [0,null],
			"expression" = null,
			"bg" = null
		},
	],
	"lv1endPlot" = [
		{
			"word" = "A plot ",
			"character" = [0,null],
			"expression" = null,
			"bg" = null
		}
	],	
	"lv2endPlot" = [
		{
			"word" = "A plot",
			"character" = [0,null],
			"expression" = null,
			"bg" = null
		},
		{
			"word" = "A plot....",
			"character" = [0,null],
			"expression" = null,
			"bg" = null
		},
	],	
	"lv3startPlot" = [
		{
			"word" = "A plot",
			"character" = [null,0],
			"expression" = null,
			"bg" = null
		},
		{
			"word" = "A plot....",
			"character" = [null,0],
			"expression" = null,
			"bg" = null
		},
	],	
	"lv3endPlot" = [
		{
			"word" = "A plot",
			"character" = [null,0],
			"expression" = null,
			"bg" = null
		},
		{
			"word" = "A plot....",
			"character" = [0,null],
			"expression" = null,
			"bg" = null
		},
	],	
	"lv4startPlot" = [
		{
			"word" = "A plot",
			"character" = [null,0],
			"expression" = null,
			"bg" = null
		},
		{
			"word" = "A plot....",
			"character" = [0,null],
			"expression" = null,
			"bg" = null
		},
	],		
	"lv4transPlot" = [
		{
			"word" = "A plot",
			"character" = [null,0],
			"expression" = null,
			"bg" = null
		},
		{
			"word" = "A plot....",
			"character" = [0,null],
			"expression" = null,
			"bg" = null
		},
	],	
	"lv4endPlot" = [
		{
			"word" = "A plot",
			"character" = [null,0],
			"expression" = null,
			"bg" = null
		},
		{
			"word" = "A plot....",
			"character" = [0,null],
			"expression" = null,
			"bg" = null
		},
	],	
	

	"GuidePause" = [
		{
			"word" = "Press RT/enter ，to pause the world ",
			"character" = [0,null],
			"expression" = null,
			"bg" = null
		},
		{
			"word" = "Move the block ，press B/E to fixed the block and resume the world",
			"character" = [0,null],
			"expression" = null,
			"bg" = null
		},
	]		
}

