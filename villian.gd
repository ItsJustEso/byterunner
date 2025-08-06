extends CharacterBody2D

@export var speed = 300
@export var jump_speed = -500
@export var gravity = 1000

# Called every physics frame. This is where physics-based movement goes!
func _physics_process(delta):
	# Handle horizontal input
	var direction = 0.0



	# Set horizontal velocity
	velocity.x = direction * speed

	# Apply gravity
	velocity.y += gravity * delta

	# Handle jump
	

	# Move the character (this is built-in to CharacterBody2D in Godot 4)
	move_and_slide()
