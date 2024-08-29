extends Node2D

class_name Parent

# all pretty self explanatory here

func _ready():
	$UI/DeathUI.set_visible(false)

func _process(_delta):
	if Globals.dead:
		$UI/DeathUI.set_visible(true)
		
	if Input.is_action_just_pressed("debugToggle") and not Globals.show_debug:
		Globals.show_debug = true
	elif Input.is_action_just_pressed("debugToggle") and Globals.show_debug:
		Globals.show_debug = false


func _on_button_pressed():
	Globals.dead = false
	get_tree().reload_current_scene()
