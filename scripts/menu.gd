extends Control

var config = ConfigFile.new()
var config_path = "user://config.cfg"


# comically shitass and ugly code but it works so fuck off
func _ready():
	var err = config.load(config_path)
	if err == OK: # if config exists do stuff
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), config.get_value("Audio", "Volume", 0)) # set the audio master bus to be the previously configured volume
		Globals.show_fps = config.get_value("Game", "ShowFPS", 0) # set showfps to previously configured value
		# depending on config value, be either windowed or fullscreen, may modify later
		if config.get_value("Game", "WindowMode", 0) == 0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			get_window().size = Vector2i(1600, 900)
			print("windowed")
		elif config.get_value("Game", "WindowMode", 0) == 1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			print("fullscreen")
		print("config loaded!")
	else:
		print("failed to load config, using default options")
	
	# if the intro has played already, dont play it again
	if not Globals.intro_played:
		$IntroSequence.play("intro_sequence")
		Globals.intro_played = true
	else:
		$IntroSequence.play("intro_sequence")
		$IntroSequence.advance(12.5) # length of the animation (skip to end)


func _process(_delta):
	if Input.is_anything_pressed():
		$IntroSequence.advance(12.5)


# change these later
func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/level2.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/settings.tscn")


func _on_exit_pressed():
	get_tree().quit()
