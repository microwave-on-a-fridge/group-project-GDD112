extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$DeathUI.set_visible(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Globals.dead:
		$DeathUI.set_visible(true)


func _on_button_pressed():
	print("restarting!")
	Globals.dead = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")
