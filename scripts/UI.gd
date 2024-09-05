extends CanvasLayer

func _process(_delta):
	if Globals.show_fps:
		$DebugInfo.text = str(Engine.get_frames_per_second()) + " fps"
	else:
		$DebugInfo.text = ""
		
		
	$SpeedrunTimer.text = "%02d:%02d" % [Globals.timer_minutes, Globals.timer_seconds]
		
		
		
		
		
		
		
		
		
		
	"""
	if Globals.timer_seconds < 10:
		$SpeedrunTimer.text = "00:0" + str(Globals.timer_seconds)
	elif Globals.timer_seconds < 60:
		$SpeedrunTimer.text = "00:" + str(Globals.timer_seconds)
	if Globals.timer_seconds > 60:
		Globals.timer_minutes += 1
		Globals.timer_seconds = 0
		$SpeedrunTimer.text = "0" + str(Globals.timer_minutes) + ":" + str(Globals.timer_seconds)
	if Globals.timer_minutes > 9:
		$SpeedrunTimer.text = str(Globals.timer_minutes) + ":" + str(Globals.timer_seconds)
	if Globals.timer_seconds > 60 and Globals.timer_minutes > 9:
		Globals.timer_minutes += 1
		Globals.timer_seconds = 0
		$SpeedrunTimer.text = str(Globals.timer_minutes) + ":" + str(Globals.timer_seconds)
"""
