extends CanvasLayer

func _process(_delta):
	if Globals.show_fps:
		$DebugInfo.text = str(Engine.get_frames_per_second()) + " fps"
	else:
		$DebugInfo.text = ""

