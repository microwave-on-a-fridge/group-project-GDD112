extends CanvasLayer

func _process(_delta):
	if Globals.debugInfoShown:
		# really ugly long line im sorry ill refactor later
		$DebugUI/DebugInfo.text = "fps" + str(Engine.get_frames_per_second()) + "\npos" + str(Globals.player_position) + "\nvel " + str(Globals.player_velocity) + "\ncanJump = " + str(Globals.canJump) + "\ncanDoubleJump = " + str(Globals.canDoubleJump) + "\ndead = " + str(Globals.dead)
	elif not Globals.debugInfoShown:
		$DebugUI/DebugInfo.text = "move with wasd/arrows, jump with space, sprint with shift. can double jump. will die if touch danger. press p to toggle debug info"
