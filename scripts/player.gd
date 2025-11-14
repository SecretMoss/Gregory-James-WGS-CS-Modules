extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -350.0
const ACCELERATION = 500

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Gets the movement direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Play Animations
	if is_on_floor():
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
	else:
		animated_sprite.play("jump")
	
	# Play animation
	if direction == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")
	
	# Applies the movement
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta) 
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, 30)
		else:
			velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)

	move_and_slide()
