extends Area2D

# self explanatory

func _on_body_entered(_body):
	Globals.onLadder = true


func _on_body_exited(_body):
	Globals.onLadder = false
