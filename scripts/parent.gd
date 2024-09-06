extends Node2D

var config = ConfigFile.new()
var config_path = "user://times.sav"

var banana_scene: PackedScene = preload("res://scenes/banana.tscn")

# all pretty self explanatory here
var level_num
var previous_best

@onready var real_death = randi() % 4 # random hyper-realistic version for funnies

func _ready():
	Globals.timer_total = 0
	Globals.timer_minutes = 0
	Globals.timer_seconds = 0
	var level_full = scene_file_path
	var level = level_full.get_file().get_basename()
	$UI/DeathUI.set_visible(false)
	$UI/WinUI.set_visible(false)
	$UI/DeathUI/SpikeDeath.set_visible(false)
	$UI/DeathUI/EnemyDeath.set_visible(false)
	$UI/DeathUI/RealisticDeath.set_visible(false)
	Globals.death_cause = "" # nullify it
	Globals.dead = false
	for i in 4:
		var int_string = str(i)
		if int_string in level:
			level_num = i
	
	var err = config.load(config_path)
	if err == OK:
		previous_best = config.get_value("Total", str(level_num), 0)
	else:
		previous_best = 99999
		print("couldnt load previous best")


func _process(_delta):
	if Globals.dead:
		$UI/DeathUI.set_visible(true)
	if Globals.death_cause == "spike":
		$UI/DeathUI/SpikeDeath.set_visible(true)
	if Globals.death_cause == "enemy":
		$UI/DeathUI/EnemyDeath.set_visible(true)
	if real_death == 0:
		Globals.death_cause = ""
		$UI/DeathUI/SpikeDeath.set_visible(false)
		$UI/DeathUI/EnemyDeath.set_visible(false)
		$UI/DeathUI/RealisticDeath.set_visible(true)
	
	if Input.is_action_just_pressed("escape"):
		Globals.dead = false
		get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_button_pressed():
	Globals.dead = false
	get_tree().reload_current_scene()


func _on_killzone_body_entered(_body):
	Globals.dead = true


func _on_goal_body_entered(_body):
	Globals.dead = true
	$UI/WinUI.set_visible(true)
	if Globals.timer_total < previous_best:
		config.set_value("Total", str(level_num), Globals.timer_total)
		config.set_value("Mins", str(level_num), Globals.timer_minutes)
		config.set_value("Secs", str(level_num), Globals.timer_seconds)
		config.save(config_path)


func _on_return_pressed():
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")


func _on_timer_timeout():
	Globals.timer_total += 1
	@warning_ignore("integer_division")
	Globals.timer_minutes = int(Globals.timer_total / 60)
	Globals.timer_seconds = Globals.timer_total - Globals.timer_minutes * 60
	$Timer.start()


func _on_player_banana(pos, direction):
	var banana = banana_scene.instantiate() as RigidBody2D
	banana.position = pos
	banana.linear_velocity = direction * banana.SPEED
	$Bananas.add_child(banana)
