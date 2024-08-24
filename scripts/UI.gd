extends CanvasLayer

func _process(_delta):
	if Globals.show_fps:
		$DebugInfo.text = "fps" + str(Engine.get_frames_per_second())
	else:
		$DebugInfo.text = ""
