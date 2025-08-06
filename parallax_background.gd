# ParallaxBackground.gd
extends ParallaxBackground

@export var scroll_speed := Vector2(100, 0) # scroll right to left

func _process(delta):
	scroll_offset.x += scroll_speed.x * delta
