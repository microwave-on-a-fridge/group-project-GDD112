extends Area2D

# self explanatory

func _on_body_entered(_body):
	Globals.on_ladder = true


func _on_body_exited(_body):
	Globals.on_ladder = false
