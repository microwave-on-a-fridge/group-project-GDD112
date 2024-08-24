extends CharacterBody2D

@export var speed = 1000
@export var sprint_speed = 1500
@export var jump_force = 3000
@export var gravity = 100

var can_coyote_jump = false
var jump_buffered = false
var can_double_jump = false


func _physics_process(_delta):
	if !is_on_floor() and (can_coyote_jump == false):
		velocity.y += gravity
		if velocity.y > 2000:
			velocity.y = 2000

	if Input.is_action_just_pressed("jump"):
		$JumpHeightTimer.start()
		jump()
	
	# Check for sprint input
	var current_speed = speed
	if Input.is_action_pressed("sprint"):
		current_speed = sprint_speed

	var horizontal_direction = Input.get_axis("left", "right")
	velocity.x = current_speed * horizontal_direction
	
	if horizontal_direction != 0:
		switch_direction(horizontal_direction)
		
	var was_on_floor = is_on_floor()
	move_and_slide()

	if was_on_floor and !is_on_floor() and velocity.y >= 0:
		can_coyote_jump = true
		$CoyoteTimer.start()
		
	if !was_on_floor and is_on_floor():
		if jump_buffered:
			jump_buffered = false
			jump()
		can_double_jump = false
	
	update_animations(horizontal_direction)

	if is_on_floor() and Input.is_action_just_pressed("down"):
		position.y += 1

func jump():
	if is_on_floor() or can_coyote_jump:
		velocity.y = -jump_force
		
		if can_coyote_jump:
			can_coyote_jump = false
		can_double_jump = true
		
	elif can_double_jump:
		velocity.y = -jump_force
		can_double_jump = false
		
	else:
		if !jump_buffered:
			jump_buffered = true
			$JumpBufferTimer.start()


func _on_coyote_timer_timeout():
	can_coyote_jump = false


func _on_jump_height_timer_timeout():
	if !Input.is_action_pressed("jump"):
		if velocity.y < -100:
			velocity.y = -100


func _on_jump_buffer_timer_timeout():
	jump_buffered = false


func update_animations(horizontal_direction):
	if is_on_floor():
		if horizontal_direction == 0:
			$AnimatedSprite2D.play("idle")
		else:
			# Check if the sprint action is pressed to play the sprint animation
			if Input.is_action_pressed("sprint"):
				$AnimatedSprite2D.play("run")
			else:
				$AnimatedSprite2D.play("walk")
	else:
		if velocity.y < 0:
			$AnimatedSprite2D.play("jump")
		elif velocity.y > 0:
			$AnimatedSprite2D.play("fall")


func switch_direction(horizontal_direction):
	$AnimatedSprite2D.flip_h = (horizontal_direction == -1)
	$AnimatedSprite2D.position.x = horizontal_direction * 4
