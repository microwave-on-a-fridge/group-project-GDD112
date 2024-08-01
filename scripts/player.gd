extends CharacterBody2D

const JUMP_VELOCITY = -600.0
var speed = 300

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	Globals.player_position = position
	if Input.is_action_pressed("sprint"):
		speed = 600
	else:
		speed = 300
	
	if is_on_floor():
		Globals.grounded = true
		print("currently grounded")
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func _on_area_2d_body_entered(_body):
	Globals.dead = true
	print("dead")
	print(Globals.player_position)
	queue_free()
	pass # Replace with function body.
