extends CanvasLayer

func _process(_delta):
	if Globals.debugInfoShown:
		$DebugUI/DebugInfo.text = "pos " + str(Globals.player_position) + "\ngrounded = " + str(Globals.grounded) + "\ncanDoubleJump = " + str(Globals.canDoubleJump) + "\ndead = " + str(Globals.dead)
	elif not Globals.debugInfoShown:
		$DebugUI/DebugInfo.text = "move with wasd/arrows, jump with space, sprint with shift. can double jump. will die if touch danger. press p to toggle debug info"
