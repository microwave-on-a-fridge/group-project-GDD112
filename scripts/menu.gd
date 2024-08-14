extends Control

func _ready():
	$IntroSequence.play("intro_sequence")

func _process(_delta):
	if Input.is_anything_pressed():
		$IntroSequence.advance(12.5)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/debug.tscn")

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/settings.tscn")

func _on_exit_pressed():
	get_tree().quit()
