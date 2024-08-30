extends Node2D

class_name Parent

# all pretty self explanatory here

func _ready():
	$UI/DeathUI.set_visible(false)
	$UI/DeathUI/SpikeDeath.set_visible(false)
	$UI/DeathUI/EnemyDeath.set_visible(false)
	Globals.death_cause = "" # nullify it

func _process(_delta):
	if Globals.dead:
		$UI/DeathUI.set_visible(true)
	if Globals.death_cause == "spike":
		$UI/DeathUI/SpikeDeath.set_visible(true)
	if Globals.death_cause == "enemy":
		$UI/DeathUI/EnemyDeath.set_visible(true)

	
	if Input.is_action_just_pressed("escape"):
		Globals.dead = false
		get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_button_pressed():
	Globals.dead = false
	get_tree().reload_current_scene()


func _on_killzone_body_entered(_body):
	Globals.dead = true
