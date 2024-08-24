extends Control

var config = ConfigFile.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Settings/VolumeSlider.min_value = -80
	$Settings/VolumeSlider.max_value = 0
	$Settings/VolumeSlider.value = 0


func _on_option_button_item_selected(index):
	var option = index
	if option == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		get_window().size = Vector2i(1600, 900)
		print("windowed")
		#config.set_value("Game", "Window", "DisplayServer.WINDOW_MODE_WINDOWED")
	if option == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		print("fullscreen")
		#config.set_value("Game", "Window", "DisplayServer.WINDOW_MODE_FULLSCREEN")


func _on_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	#config.save("user://settings.cfg")
