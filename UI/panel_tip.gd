extends Panel
class_name PanelTip
# Called when the node enters the scene tree for the first time.
var tip
var label

func showTip(attachTarget,width,tipStr,offset = Vector2.ZERO,fontSize = 20,fontColr = Color.ANTIQUE_WHITE):
	initTip(attachTarget,width,tipStr,offset,fontSize,fontColr)
	# apear animation 
	self.modulate.a = 0.0
	var move = Vector2(10,-30)
	self.position -= move
	
	var fadeOut = Actions.FadeOut.new(0.4)
	var moveUp = Actions.MoveBy.new(move,0.5)
	Actions.Merge.new([fadeOut,moveUp]).easeOutCirc().run(self)
	
func initTip(attachTarget,width,tipStr,offset,fontSize,fontColr):
	size.x = width
	tip = tipStr
	label = Label.new()
	label.text = tip
	label.size.x = width
	
	var ls = LabelSettings.new() 
	ls.set_font_color(fontColr) 
	ls.set_font_size(fontSize) 
	label.label_settings = ls
	
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART 
	self.add_child(label)
	
	attachTarget.add_child(self)
	self.position = offset
	
func showTipMoment(attachTarget,width,tipStr,offset = Vector2.ZERO,fontSize = 20,fontColr = Color.ANTIQUE_WHITE):
	initTip(attachTarget,width,tipStr,offset,fontSize,fontColr)
	self.modulate.a = 0.0
	var move = Vector2(0,-80)
	self.position -= move

	var fadeSeq = Actions.Seq.new([ Actions.FadeOut.new(0.3), Actions.Delay.new(0.3),Actions.FadeIn.new(0.3)]).easeInOutSine()
	var moveUp = Actions.MoveBy.new(move,0.9)
	Actions.Merge.new([fadeSeq,moveUp],func():
		removeTip()).easeOutCirc().run(self)
	
func removeTip():
	queue_free()

func hideTip():
	visible = false
