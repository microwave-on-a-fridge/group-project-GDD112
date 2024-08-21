extends CharacterBody2D

var speed = 300


func _process(_delta):
	
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	if Input.is_action_pressed("sprint"):
		speed = 500
	else:
		speed = 250
	move_and_slide()
	
	
