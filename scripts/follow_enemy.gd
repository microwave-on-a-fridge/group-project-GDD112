extends CharacterBody2D

func _process(delta):
	if !Globals.dead:
		var speed = 150
		var direction = position.direction_to(Globals.player_position)
		velocity = direction * speed
		var playerCollision = move_and_collide(velocity * delta)
		
		if playerCollision:
			Globals.dead = true
