extends HSlider  

@export var audio_player: AudioStreamPlayer

func _ready():
	# Ensure the audio_player is assigned before accessing its properties
	if audio_player:
		value = audio_player.volume_db
	else:
		print("Warning: audio_player is not assigned")

func _on_value_changed(new_value):
	if audio_player:
		var db_value = lerp(-80, 0, new_value)
		audio_player.volume_db = db_value
	else:
		print("Warning: audio_player is not assigned")
