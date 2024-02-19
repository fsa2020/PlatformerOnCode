extends Control


# Called when the node enters the scene tree for the first time.
@onready var btnNew = $ButtonNew
@onready var btnContinue = $ButtonContinue
@onready var btnSetting = $ButtonSetting

var font
var settingBg

func _ready():
	btnNew.connect("button_down",onNewGame)
	btnContinue.connect("button_down",onContinue)
	btnSetting.connect("button_down",onSettings)


func onNewGame():
	UserData.clearRecord()
	get_tree().change_scene_to_file("res://DemoScene.tscn")

func onContinue():
	get_tree().change_scene_to_file("res://DemoScene.tscn")

func onSettings():
	pass
	
func closeSettings():
	pass

	
