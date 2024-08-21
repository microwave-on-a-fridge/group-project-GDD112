extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass





func _on_ceiling_hider_body_entered(_body):
	$EngClassCeiling.hide()


func _on_ceiling_hider_body_exited(_body):
	$EngClassCeiling.show()


func _on_ceiling_hider_2_body_entered(_body):
	$Class2Ceiling.hide()


func _on_ceiling_hider_2_body_exited(_body):
	$Class2Ceiling.show()


func _on_ceiling_hider_3_body_entered(_body):
	$Class3Ceiling.hide()


func _on_ceiling_hider_3_body_exited(_body):
	$Class3Ceiling.show()
