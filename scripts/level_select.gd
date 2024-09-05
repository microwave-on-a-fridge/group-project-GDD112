extends Control

var config = ConfigFile.new()
var config_path = "user://times.sav"


func _ready():
	var err = config.load(config_path)
	if err == OK: # if config exists do stuff
		$CanvasLayer/Level1/Time1.text = "Best: %02d:%02d" % [config.get_value("Mins", "1", 0), config.get_value("Secs", "1", 0)]
		$CanvasLayer/Level2/Time2.text = "Best: %02d:%02d" % [config.get_value("Mins", "2", 0), config.get_value("Secs", "2", 0)]
		$CanvasLayer/Level3/Time3.text = "Best: %02d:%02d" % [config.get_value("Mins", "3", 0), config.get_value("Secs", "3", 0)]
	else:
		print("failed to load times, not displaying")

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")


func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://scenes/level_3.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
