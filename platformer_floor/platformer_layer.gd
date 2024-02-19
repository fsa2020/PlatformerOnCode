extends Node2D

## add PlatformerBlock as child
class_name PlatformerLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	init()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not isBlockSorted:
		sortBlocks()
	
func init():
	# print("layer init()")
	pass

var isBlockSorted = false
var blockList = []
var layerContent :String

func setBlocks(blocks,fontSize):
	blockList = []
	isBlockSorted = false
	layerContent = ""
	
	if len(blocks) == 0:
		blocks.append([' ','w'])
	for i in range(len(blocks)):
		var info = blocks[i]
		if i+1<len(blocks):
			info.append(blocks[i+1][0])  
		# print(info)
		var block = PlatformerBlock.new()
		block.setContent(info,fontSize)
		self.add_child(block)
		# todo set block pos
		blockList.append(block)
		layerContent += info[0]
		
func sortBlocks():
	var offsetX = 0
	for b in blockList:
		b.position.x = offsetX
		offsetX += b.label.get_rect().size.x
	isBlockSorted = true

func getBlockByPosX(x):
	for b in blockList:
		var start =  b.position.x
		var end = start + b.label.get_rect().size.x
		if x> start and x< end:
			return b
			
func isEmpty(startX,endX):
	for b in blockList:
		var start =  b.position.x
		var end = start + b.label.get_rect().size.x
		if (start >= startX and start <= endX) or (end >= startX and end <= endX) :
			return false
	return true

func shakeAndFall():
	for b in blockList:
		b.shakeAndFall()

func reset():
	for b in blockList:
		b.reset()
