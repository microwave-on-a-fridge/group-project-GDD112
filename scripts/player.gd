extends CharacterBody2D

# ints for movement velocity stuff
@export var speed = 1000
@export var sprint_speed = 1500
@export var jump_force = 3000
@export var gravity = 100
@export var fall_velocity = 4000

# bools for can jump stuff (self explanatory)
var can_coyote_jump = false
var jump_buffered = false
var can_double_jump = false

var is_run_playing = false

# movement code stuff
func _physics_process(_delta):
	Globals.player_position = position
	# code for falling, with max fall speed
	if not is_on_floor() and (can_coyote_jump == false):
		velocity.y += gravity
		if velocity.y > fall_velocity:
			velocity.y = fall_velocity

	# run jump code and start jump timer for dictating how high jump will be
	if Input.is_action_just_pressed("jump"):
		$JumpHeightTimer.start()
		jump()
	
	# check for sprint input
	var current_speed = speed
	var tween = $Camera2D.create_tween()
	if Input.is_action_pressed("sprint"):
		current_speed = sprint_speed
		# zoom camera in when sprint
		tween.tween_property($Camera2D, "zoom", Vector2(0.27, 0.27), 0.25)

	# zoom camera back out
	if not Input.is_action_just_pressed("sprint"):
		tween.tween_property($Camera2D, "zoom", Vector2(0.3, 0.3), 0.15)
	
	# enable ladder launch mechanic thingy so you can fling off ladders
	if Globals.on_ladder and not is_on_floor():
		$LadderBoostStartTimer.start()
	
	# move left and right, easy enough to understand
	var horizontal_direction = Input.get_axis("left", "right")
	velocity.x = current_speed * horizontal_direction
	
	# for switching which direction player faces
	if horizontal_direction != 0:
		switch_direction(horizontal_direction)
		
	var was_on_floor = is_on_floor()
	move_and_slide()

	# coyote jump stuff
	if was_on_floor and not is_on_floor() and velocity.y >= 0:
		can_coyote_jump = true
		$CoyoteTimer.start()
		
	# jump buffering stuff
	if not was_on_floor and is_on_floor():
		if jump_buffered:
			jump_buffered = false
			jump()
		can_double_jump = false
	
	update_animations(horizontal_direction)

	# can drop down through platforms
	if is_on_floor() and Input.is_action_just_pressed("down"):
		position.y += 1
		
	# if on a ladder, be able to climb
	var vertical_direction = Input.get_axis("up", "down")
	if Globals.on_ladder:
		@warning_ignore("integer_division") # IT IS MERELY A WARNING AND THE CODE WORKS FINE
		velocity.y = current_speed / 2 * vertical_direction

	if Globals.dead:
		queue_free()
	
	if velocity.x != 0 and is_on_floor() and not is_run_playing:
		$RunSE.play()
		is_run_playing = true
		
	if velocity.x == 0 or not is_on_floor():
		$RunSE.stop()
		is_run_playing = false

#jump function
func jump():
	# basic jump
	if is_on_floor() or can_coyote_jump:
		velocity.y = -jump_force
		
		# cant coyote jump if coyote jumped
		if can_coyote_jump:
			can_coyote_jump = false
		can_double_jump = true
		
	# double jump, then cant double jump
	elif can_double_jump:
		velocity.y = -jump_force
		can_double_jump = false
		
	# more jump buffer stuff
	else:
		if not jump_buffered:
			jump_buffered = true
			$JumpBufferTimer.start()


# timers
func _on_coyote_timer_timeout():
	can_coyote_jump = false


func _on_jump_height_timer_timeout():
	if not Input.is_action_pressed("jump"):
		if velocity.y < -100:
			velocity.y = -100


func _on_jump_buffer_timer_timeout():
	jump_buffered = false


# running the correct animations in the correct direction
func update_animations(horizontal_direction):
	if is_on_floor():
		if horizontal_direction == 0:
			$AnimatedSprite2D.play("idle")
		else:
			if Input.is_action_pressed("sprint"):
				$AnimatedSprite2D.play("run")
			else:
				$AnimatedSprite2D.play("walk")
	else:
		if velocity.y < 0:
			$AnimatedSprite2D.play("jump")
		elif velocity.y > 0:
			$AnimatedSprite2D.play("fall")

# reverse the direction player is facing
func switch_direction(horizontal_direction):
	$AnimatedSprite2D.flip_h = (horizontal_direction == -1)
	$AnimatedSprite2D.position.x = horizontal_direction * 4


func _on_ladder_boost_start_timer_timeout():
	speed = 5000
	$LadderBoostEndTimer.start()


func _on_ladder_boost_end_timer_timeout():
	speed = 1000
