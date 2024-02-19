extends Node2D
class_name Trans

var templates = []

var templatesDict = {}
var selectedDict = {}

var blocks = []
var blocksPos = []

var needBlockInfos = []

var charWidth
var charHeight

func getShapeWords():
	return [
	"###        ######",
	"###        ######",
	"###        ######",
	]

func _init(parent,temps = [],attatchNode = null):
	initTemplates(temps)
	parent.add_child(self)
	initPos(attatchNode)
	initShapeWords()
	for info in needBlockInfos:
		fillBlock(info)		

func initPos(attatchNode):
		
	if attatchNode!=null:
		self.global_position = attatchNode.global_position
	
	# self.position += getInitalOffset()

func getInitalOffset():
	return Vector2(0,0)

#	templates.sort_custom(func(a, b): return a[0] > b[0])
func initTemplates(temps):
	for b in temps:
		if b.isCollisionEnabled():
			templates.append(b)


	var lenMax = 0
	for b in templates:
		var len = len(b.label.text)
		if not templatesDict.has(len):
			templatesDict[len] = []
		templatesDict[len].append(b)
		lenMax = max(lenMax,len)
		
	var b = templatesDict[lenMax][0]
	charWidth = b.label.get_rect().size.x /lenMax
	charHeight =  b.label.get_rect().size.y-5

func initShapeWords():
	needBlockInfos = []
	# {"pos" = Vector2(0,0),"len" = 3}
	var shapeWords = getShapeWords()
	var posOffset = getInitalOffset()
	for i in range(len(shapeWords)):
		var s = shapeWords[i]
		var p = 0
		while p<len(s):
			var l = 0
			while p<len(s) and s[p] == " " :
				p+=1
			
			var tempP = p
			while p<len(s) and s[p] != " " :
				p+=1
				l+=1
				
			if l>=1:
				var pos = Vector2(tempP*charWidth,i*charHeight)+posOffset
				needBlockInfos.append({"pos" =pos ,len=l})
	print(needBlockInfos,"needBlockInfos")

		
# {"pos" = Vector2(0,0),"len" = 3}
func fillBlock(info):
	if info.len == 0:return
	for i in range(info.len,0,-1):
		var t = findTemplateByLen(i)
		if t:
			info.len -= i
			cloneBlock(t,info.pos)
			info.pos.x += i*charWidth
			fillBlock(info)
			return


func cloneBlock(t,pos = Vector2(0,0)):
	var b = t.clone()
	blocks.append(b)
	blocksPos.append(pos)
	self.add_child(b)
	b.visible = false
	b.global_position = t.global_position
	print(b.global_position,t.global_position)
	
	print(b.position,t.position)

#	runPack(b,pos)

var packNum = 0
func runPack():	
	print(blocksPos,"runPack blocksPos")
	packNum = 0
	for i in range(len(blocks)):
		var block = blocks[i]
		var tarPos = blocksPos[i]
		block.setCollisionEnabled(false)
		block.visible = true
		Actions.MoveTo.new(tarPos,0.5,func():
			block.setCollisionEnabled(true)
			onPackOver(block)
		).easeInOutCirc().run(block)



				
func onPackOver(block):
	packNum += 1
	print("onPackOver",packNum)
	if packNum == len(blocks):
		onPackOverAll()

func onPackOverAll():
	print("onPackOverAll")


func runBreakApart():
	print("runBreakApart")
	packNum = len(blocks)
	for i in range(len(blocks)):
		var block = blocks[i]
		block.playExplode()
		block.setCollisionEnabled(false)
		onPackOver(block)


func onBreakApartOver(block):
	packNum -= 1
	print("onBreakApartOver",packNum)
	if packNum == 0:
		onBreakApartOverAll()

func onBreakApartOverAll():
	print("onPackOverAll")

func getSelectedTemplates():
	var  templates = []
	for b in selectedDict.keys():
		templates.append(b)
	return templates

func findTemplateByLen(l):
	if templatesDict.has(l):
		# find a not used one
		for t in templatesDict[l]:
			if not selectedDict.has(t):
				selectedDict[t] = true
				return t
		# all used return a rand one
		if l<=3:
			return templatesDict[l].pick_random()
		else:
			return null
	else:
		return null
		
	
