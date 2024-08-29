extends Node2D

class_name Parent

# all pretty self explanatory here

func _ready():
	$UI/DeathUI.set_visible(false)

func _process(_delta):
	if Globals.dead:
		$UI/DeathUI.set_visible(true)
	"""
	if Input.is_action_just_pressed("debugToggle") and not Globals.show_debug:
		Globals.show_debug = true
	elif Input.is_action_just_pressed("debugToggle") and Globals.show_debug:
		Globals.show_debug = false
	"""
	
	if Input.is_action_just_pressed("escape"):
		Globals.dead = false
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
	"""
	var tween = $Player/Camera2D.create_tween()
	var is_zoomed = false
	if Input.is_action_just_pressed("zoom") and not is_zoomed:
		tween.tween_property($Player/Camera2D, "zoom", Vector2(0.1, 0.1), 0.5)
		is_zoomed = true
	if Input.is_action_just_pressed("zoom") and is_zoomed:
		tween.tween_property($Player/Camera2D, "zoom", Vector2(0.3, 0.3), 0.5)
		is_zoomed = false
	"""

func _on_button_pressed():
	Globals.dead = false
	get_tree().reload_current_scene()


func _on_killzone_body_entered(_body):
	Globals.dead = true
