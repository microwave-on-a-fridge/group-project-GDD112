extends Area2D


func _on_body_entered(_body):
	Globals.onLadder = true


func _on_body_exited(_body):
	Globals.onLadder = false
