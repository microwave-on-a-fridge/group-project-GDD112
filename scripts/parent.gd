# I HAVENT DONE LIKE ANY COMMENTING AT ALL YET BUT I WILL IN THE FUTURE THIS IS JUST THE PROTOTYPE THAT I AM RUSHING TO GET OUT

extends Node2D

class_name Parent

# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/DeathUI.set_visible(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Globals.dead:
		$UI/DeathUI.set_visible(true)
		
	if Input.is_action_just_pressed("debugToggle") and not Globals.debugInfoShown:
		Globals.debugInfoShown = true
	elif Input.is_action_just_pressed("debugToggle") and Globals.debugInfoShown:
		Globals.debugInfoShown = false


# when pressing button, reload the level
func _on_button_pressed():
	print("restarting!")
	Globals.dead = false
	get_tree().reload_current_scene()
