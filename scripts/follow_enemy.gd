extends CharacterBody2D

var speed = 0
var music_started = false

func _process(delta):
	var direction = position.direction_to(Globals.player_position)
	velocity = direction * speed
	var player_collision = move_and_collide(velocity * delta)
	
	if player_collision:
		Globals.dead = true
		Globals.death_cause = "enemy"
		
	if position.x > Globals.player_position.x:
		$AnimatedSprite2D.flip_h = true
	
	if position.x < Globals.player_position.x:
		$AnimatedSprite2D.flip_h = false
		
	if Globals.dead:
		$JudgementBGM.stop()


# dont move until the player encounters the enemy
func _on_detection_zone_body_entered(_body):
	speed = 1000
	if not music_started:
		$JudgementBGM.play()
		$ScreamSE.play()
		music_started = true


# if player gets too far, give enemy a speed boost to catch up
func _on_detection_zone_body_exited(_body):
	speed = 2000
