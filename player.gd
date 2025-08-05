extends CharacterBody2D

@export var speed = 200
@export var jump_velocity = -400
@export var gravity = 1000

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	# Jump input
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Auto-run forward
	velocity.x = speed

	# Move the character
	move_and_slide()
