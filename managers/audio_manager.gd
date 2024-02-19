extends Node
class_name AudioManager
# Called when the node enters the scene tree for the first time.

func _ready():
	UserSetting.loadSetting()
	process_mode = Node.PROCESS_MODE_ALWAYS
	Events.playEffectSound.connect(playEffectSound)
	Events.playBgm.connect(playBgm)

#	playEffectSound.emit("Balloon Pop 1.wav")
#	playBgm("Balloon Pop 1.wav")
	
	Actions.Schedule.new(1.0,func():
		for child in self.get_children():
			if ! child.playing:
				child.queue_free()).run(self)


		
func playEffectSound(name):
	var audioPlayer = AudioStreamPlayer.new()
	var path = "res://asset/sounds/"
	var audioStream = load(path+name)

	audioPlayer.stream = audioStream
	self.add_child(audioPlayer)
	
	var v = UserSetting.getEffectSoundVolume()
	var db = vToDB(v)
	audioPlayer.volume_db = db

	audioPlayer.play()
	
var bgmPlayer
func playBgm(name):
	
	if bgmPlayer == null:
		bgmPlayer = AudioStreamPlayer.new()
		self.add_child(bgmPlayer)
	var path = "res://asset/sounds/"
	var audioStream = load(path+name)
	audioStream.loop_mode = 1	
	bgmPlayer.stream = audioStream
	bgmPlayer.play()

# v : 0-1
func vToDB(v):
	if v == 0:
		return -200
	else:
		return lerp(-10,0,v)
