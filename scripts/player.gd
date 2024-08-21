extends CharacterBody2D

const JUMP_VELOCITY = -1500.0
var speed = 1000
var canDoubleJump = true
var canDie = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	$SpawnImmunity.start()
	$Anim.hide()

func _physics_process(delta):
	Globals.player_position = position
	Globals.player_velocity = velocity
	
	if Input.is_action_just_pressed("right"):
		if Input.is_action_pressed("sprint"):
			$Anim.show()
			speed = 1500
			$Anim.scale.x = 0.5
			$Anim.play("run")
			$SsIdle.hide()
		else:
			$Anim.show()
			speed = 1000
			$Anim.scale.x = 0.5
			$Anim.play("walk")
			$SsIdle.hide()
	elif Input.is_action_just_pressed("left"):
		if Input.is_action_pressed("sprint"):
			$Anim.show()
			speed = 1500
			$Anim.scale.x = -0.5
			$Anim.play("run")
			$SsIdle.hide()
		else:
			$Anim.show()
			speed = 1000
			$Anim.scale.x = -0.5
			$Anim.play("walk")
			$SsIdle.hide()
	
	if Input.is_action_just_released("right") :
		$Anim.hide()
		$SsIdle.show()
		$SsIdle.scale.x = 0.5
	elif Input.is_action_just_released("left") :
		$Anim.hide()
		$SsIdle.show()
		$SsIdle.scale.x = -0.5

	if is_on_floor():
		Globals.canJump = true
		canDoubleJump = true
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		Globals.canJump = false

	# Handle jump.
	if Input.is_action_just_pressed("jump") and Globals.canJump:
		$Anim.show()
		$Anim.play("jump")
		$SsIdle.hide()
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("jump") and not Globals.canJump and canDoubleJump:
		$Anim.show()
		$Anim.play("jump")
		$SsIdle.hide()
		velocity.y = JUMP_VELOCITY
		canDoubleJump = false

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if Input.is_action_pressed("down"):
		position.y += 1

	move_and_slide()
	
	Globals.canDoubleJump = canDoubleJump
	
	if Globals.dead:
		print("dead")
		print(Globals.player_position)
		queue_free()

func _on_spawn_immunity_timeout():
	canDie = true

func _on_spike_body_entered(_body):
	if canDie:
		Globals.dead = true
		print("dead")
		print(Globals.player_position)
		queue_free()


func _on_end_body_entered(_body):
	queue_free()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
