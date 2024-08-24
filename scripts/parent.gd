extends Node2D
# all pretty self explanatory here
class_name Parent

func _ready():
	$UI/DeathUI.set_visible(false)

func _process(_delta):
	if Globals.dead:
		$UI/DeathUI.set_visible(true)
		
	if Input.is_action_just_pressed("debugToggle") and not Globals.debugInfoShown:
		Globals.debugInfoShown = true
	elif Input.is_action_just_pressed("debugToggle") and Globals.debugInfoShown:
		Globals.debugInfoShown = false


func _on_button_pressed():
	print("restarting!")
	Globals.dead = false
	get_tree().reload_current_scene()
