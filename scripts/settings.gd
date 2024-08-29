extends Control

var config = ConfigFile.new()
var config_path = "user://config.cfg"


func _ready():
	# set min max of volume slider
	$Settings/VolumeSlider.min_value = -80
	$Settings/VolumeSlider.max_value = 0
	
	# load the previously stored values from config
	# (this doesnt load the settings itself, rather it sets the option
	#  select items to LOOK like theyre correct, the config is already
	# loaded in the previous scene)
	var err = config.load(config_path)
	if err == OK:
		$Settings/VolumeSlider.value = config.get_value("Audio", "Volume", 0)
		$Settings/WindowDropdown.selected = config.get_value("Game", "WindowMode", 0)
		$Settings/ToggleFPS.button_pressed = config.get_value("Game", "ShowFPS", 0)
	else:
		print("failed to load config, using default options")


# make the window mode change according to what was selected in the dropdown
func _on_window_dropdown_item_selected(index):
	var option = index
	
	if option == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		get_window().size = Vector2i(1600, 900)
		print("windowed")
		config.set_value("Game", "WindowMode", 0)
		
	if option == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		print("fullscreen")
		config.set_value("Game", "WindowMode", 1)

	config.save(config_path)


# adjust volume in accordance with the slider value
func _on_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	config.set_value("Audio", "Volume", value)
	config.save(config_path)


# go back (duh)
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


# toggle show fps
func _on_toggle_fps_toggled(toggled_on):
	Globals.show_fps = toggled_on
	config.set_value("Game", "ShowFPS", toggled_on)
	config.save(config_path)




