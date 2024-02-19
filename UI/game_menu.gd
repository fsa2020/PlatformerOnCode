extends Control

var font
var fullsceen = false
var vsync = false
var ob
var lv_select
var screen_halfx
var screen_halfy

var menu 
var btn_menu
var bg

@onready var colorRect = $"../ColorRect"
@onready var levelManager = $"../../LevelManager"

# Called when the node enters the scene tree for the first time.
func _ready():
	initMenu()
	createMenuBtn()
	setMenuVisible(false)

@export var input_menu : String = "menu"

func _input(_event):

	if Input.is_action_pressed(input_menu):
		setMenuVisible( menu.visible == false)

	
func initMenu():
	font = load("res://asset/fonts/cmu-typewriter/Typewriter/cmuntb.ttf")
	
	screen_halfx = get_viewport().size.x/2
	screen_halfy = get_viewport().size.y/2
	# bg
	bg = ColorRect.new()
	bg.color = Color.BLACK
	bg.modulate.a = 0.7

	bg.size = get_viewport().size
	bg.visible = false
	add_child(bg)
	
	# tab container and panels
	var psize = 400
	var panel_main = Panel.new()
	panel_main.set_position(Vector2(20, 20))
	panel_main.set_size(Vector2(psize, psize))
	panel_main.name = "Main"
	
	var panel_settings = Panel.new()
	panel_settings.set_position(Vector2(20, 20))
	panel_settings.set_size(Vector2(psize, psize))
	panel_settings.name = "Settings"
	
	var panel_help = Panel.new()
	panel_help.set_position(Vector2(20, 20))
	panel_help.set_size(Vector2(psize, psize))
	panel_help.name = "Help"
	
	var tabcont = TabContainer.new()
	tabcont.set_position(Vector2(20, 20))
	tabcont.set_size(Vector2(psize, psize))
	tabcont.add_child(panel_main)
	tabcont.add_child(panel_settings)
	tabcont.add_child(panel_help)
	
	# main
	tabcont.get_tab_control(0).add_child(createMainTab())
	# settings
	tabcont.get_tab_control(1).add_child(createSettingTab())
	# help
	tabcont.get_tab_control(2).add_child(createHelpTab())
	
	add_child(tabcont)
	menu = tabcont

func setMenuVisible(isVisible):
	if self.menu != null:
		bg.visible = isVisible
		menu.visible = isVisible

func createMenuBtn():
	btn_menu = Button.new()
	btn_menu.text = "Menu"
	btn_menu.set_position(Vector2(get_viewport().size.x-100, 0))
	btn_menu.connect("pressed", self.onBtnMenuPressed)
	add_child(btn_menu)

func onBtnMenuPressed():
	if menu.visible:
		setMenuVisible(false)
	else:	
		setMenuVisible(true)

func createMainTab():
	var vflowcont_main = HFlowContainer.new()
	vflowcont_main.set_position(Vector2(10, 10))
	
	var newgame_button = Button.new()
	newgame_button.set_position(Vector2(10, 10))
	newgame_button.text = "reset current lv"
	newgame_button.connect("pressed", self._load_game)
	vflowcont_main.add_child(newgame_button)
	
	
	var exit_button = Button.new()
	exit_button.set_position(Vector2(10, 110))
	exit_button.text = "Exit"
	exit_button.connect("pressed", self._exit_game)
	vflowcont_main.add_child(exit_button)


	lv_select = OptionButton.new()
	
	var lv_max = 4
	for i in range(lv_max+1):
		lv_select.add_item("level:"+str(i))
	
	lv_select.connect("item_selected", self._handle_lv_change)
	vflowcont_main.add_child(lv_select)

	return vflowcont_main
	
func createSettingTab():
	var vflowcont_settings = HFlowContainer.new()
	vflowcont_settings.set_position(Vector2(10, 10))
	
	ob = OptionButton.new()
	ob.add_item("1280x720")
	ob.add_item("1600x920")
	ob.add_item("1920x1080")
	
	ob.connect("item_selected", self._handle_resolution_change)
	
	var fullscreen = CheckBox.new()
	fullscreen.connect("pressed", self._handle_fullscreen)
	fullscreen.text = "fullscreen"
	
	var setting = UserSetting.loadSetting()
	
	var labelMain = Label.new()
	labelMain.text = "main sound volume"
	var soundVolume = HSlider.new()
	soundVolume.custom_minimum_size.x = 350
	soundVolume.value = setting["global music volume"]*100
	soundVolume.connect("value_changed",func(value):
		UserSetting.setGlobalMusicVolume(value/100)
		Events.playEffectSound.emit("Confirm 1.wav"))
	

		
	var labelBgm = Label.new()
	labelBgm.text = "BGM sound volume"
	var bgmVolume = HSlider.new()
	bgmVolume.custom_minimum_size.x = 350
	bgmVolume.value = setting["back ground music volume"]*100
	bgmVolume.connect("value_changed",func(value):
		UserSetting.setBgmVolume(value/100)
		# todo set bgm sound
		Events.playEffectSound.emit("Confirm 1.wav"))
		
	var labelEffect = Label.new()
	labelEffect.text = "effect sound volume"
	var effectVolume = HSlider.new()
	effectVolume.custom_minimum_size.x = 350
	effectVolume.value = setting["effect sound volume"]*100
	effectVolume.connect("value_changed",func(value):
		UserSetting.setEffectSoundVolume(value/100)
		Events.playEffectSound.emit("Confirm 1.wav"))
		
	vflowcont_settings.add_child(labelMain)
	vflowcont_settings.add_child(soundVolume)

	vflowcont_settings.add_child(labelBgm)
	vflowcont_settings.add_child(bgmVolume)
		
	vflowcont_settings.add_child(labelEffect)
	vflowcont_settings.add_child(effectVolume)
#	vflowcont_settings.add_child(ob)
#	vflowcont_settings.add_child(fullscreen)
	return vflowcont_settings
	
func createHelpTab():
	var vflowcont_help = HFlowContainer.new()
	vflowcont_help.set_position(Vector2(10, 10))
	
	
	var desc = Label.new()
	desc.set_position(Vector2(10, 10))
	desc.set_size(Vector2(200, 200))
	desc.text = "This demo is created by Godot 4 Actions! \n"
	vflowcont_help.add_child(desc)
	
	var godot_link = LinkButton.new()
	godot_link.text = "Check the godot asset"
	godot_link.connect("pressed", self._open_godot_link)
	godot_link.modulate = Color(0.7, 0.7, 0.9)
	vflowcont_help.add_child(godot_link)
	
	var git_link = LinkButton.new()
	git_link.text = "Check the github repo"
	git_link.connect("pressed", self._open_git_link)
	git_link.modulate = Color(0.7, 0.7, 0.9)
	vflowcont_help.add_child(git_link)
	
	return vflowcont_help
	
func _exit_game():
	get_tree().quit()
	
func _load_game():
#	get_tree().change_scene_to_file("res://game.tscn")
	setMenuVisible(false)
	levelManager.stepIntoLevel(levelManager.curLv)

func _open_godot_link():
	OS.shell_open("https://godotengine.org/asset-library/asset/2073")
	
func _open_git_link():
	OS.shell_open("https://github.com/fsa2020/CocosLikeGodotActions")


func _handle_resolution_change(selected):
	var selection = ob.get_item_text(selected)
	if selection == "1920x1080":
		DisplayServer.window_set_size(Vector2i(1920, 1080))
		get_viewport().size = Vector2i(1920, 1080)
	elif selection == "1600x920":
		DisplayServer.window_set_size(Vector2i(1600, 920))
		get_viewport().size = Vector2i(1600, 920)
	elif selection == "1280x720":
		DisplayServer.window_set_size(Vector2i(1280, 720))
		get_viewport().size = Vector2i(1280, 720)
		
	screen_halfx = get_viewport().size.x/2
	screen_halfy = get_viewport().size.y/2

func _handle_lv_change(selected):
	var selection = lv_select.get_item_text(selected)
	var s = selection.split(":", true, 2)
	var lv =  s[1].to_int()
	setMenuVisible(false)
	levelManager.stepIntoLevel(lv)

func _handle_fullscreen():
	fullsceen = !fullsceen
	if fullsceen == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	screen_halfx = get_viewport().size.x/2
	screen_halfy = get_viewport().size.y/2


