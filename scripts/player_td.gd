extends CharacterBody2D

func _process(_delta):
	
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * 500
	move_and_slide()
	
	
	#direction
	var player_direction = (get_global_mouse_position()-position).normalized()
