extends ColorRect
class_name Cmd
# Called when the node enters the scene tree for the first time.
@onready var player = $"../../PlatformerController2D"
@onready var lvManager = $"../../LevelManager"
@onready var trapRoot = $"../../TrapRoot"
@onready var flooRoot = $"../../PlatformerFloor"

var wordRectPosHide
var wordRectPosShow

var minLineNum = 2
var maxLineNum = 8
var linHeight = 15

var paddingX = 10
var paddingY = 10

var lines = []

func _ready():
	wordRectPosHide = Vector2(0,-maxLineNum*linHeight)
	wordRectPosShow = Vector2(0,0)
	initWord()
	self.visible = false
	Events.CmdOut.connect(addCmd)

var hideTimeCount
func addCmd(str,color = Color.ANTIQUE_WHITE):
	if self.visible == false:
		playAppear()
	addLine(str,color)

	if hideTimeCount != null:
		hideTimeCount.stop()
	
	hideTimeCount = Actions.Delay.new(5.0,func():
		playHide()).run(self)

func addLine(str,color = Color.ANTIQUE_WHITE):
	var line = createLine(str,color)

	if len(lines) >= maxLineNum:	
		lines[0].queue_free()
		lines.remove_at(0)
		for l in lines:
			Actions.MoveBy.new(Vector2(0,-linHeight),0.1).run(l)

	line.position.y =  paddingY + len(lines)*linHeight
	line.position.x =  paddingX
	
	lines.append(line)
	self.add_child(line)	
	Actions.WordDisplay.new(0.015,str).run(line.get_child(0))
	resetSizeY()

	
func createLine(str,color):
	var line = Label.new()
	var fontSize = 15
	line.text = "D:\\User>"
	setLabel(line,fontSize,Color.DARK_GREEN)
	var outPut = Label.new()
	outPut.text = str
	setLabel(outPut,fontSize,color)
	line.add_child(outPut)
	outPut.position.x = 100
	return line
	
	
func setLabel(label,size=15,color = Color.ANTIQUE_WHITE):
	var ls = LabelSettings.new() 
	ls.set_font_color(color) 
	# print("TYPE_COLOR",FloorUtils.TYPE_COLOR[colorIndex])
	ls.set_font_size(size) 
	var f = FontFile.new()
	f.load_dynamic_font("res://asset/fonts/cmu-typewriter/Typewriter/cmuntb.ttf")
	ls.font = f
	label.label_settings = ls
	return label
	
	
func playAppear():
	self.visible = true
	Actions.MoveTo.new(wordRectPosShow,0.2).easeOutCirc().run(self)

	
func playHide():
	Actions.MoveTo.new(wordRectPosHide,0.1,func():
		self.visible = false).easeOutCirc().run(self)
		
func resetSizeY():
	var yNum = max(minLineNum,len(lines))
	self.size.y = yNum*linHeight+paddingY*2



func initWord():
	self.position = wordRectPosHide
	self.size.x = get_viewport_rect().size.x/3
	resetSizeY()
	
	
