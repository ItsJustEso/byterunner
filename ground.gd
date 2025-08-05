extends Node2D

@export var speed := 200  # How fast the ground scrolls (pixels/sec)
@export var reset_position_x := 1024  # Where to teleport to (adjust later)

func _process(delta):
	# Move the ground left over time
	position.x -= speed * delta

	# When the ground moves too far left, teleport it to the right
	if position.x <= -reset_position_x:
		position.x += reset_position_x * 2  # Loops it back to the right
