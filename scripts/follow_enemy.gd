extends CharacterBody2D

var speed = 0

func _process(delta):
	var direction = position.direction_to(Globals.player_position)
	velocity = direction * speed
	var player_collision = move_and_collide(velocity * delta)
	
	if player_collision:
		Globals.dead = true


# dont move until the player encounters the enemy
func _on_detection_zone_body_entered(_body):
	speed = 1000


# if player gets too far, give enemy a speed boost to catch up
func _on_detection_zone_body_exited(_body):
	speed = 2000
