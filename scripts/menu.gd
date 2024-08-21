extends Control

#var config = ConfigFile.new()
#var err = config.load("usrr://settings.cfg")

func _ready():
	#var cfgWindowSetting = config.get_value("Game", "Window")
	#DisplayServer.window_set_mode(cfgWindowSetting)
	
	if not Globals.introPlayed:
		$IntroSequence.play("intro_sequence")
		Globals.introPlayed = true
	else:
		$IntroSequence.play("intro_sequence")
		$IntroSequence.advance(12.5)

func _process(_delta):
	if Input.is_anything_pressed():
		$IntroSequence.advance(12.5)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/level2.tscn")

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/settings.tscn")

func _on_exit_pressed():
	get_tree().quit()
