extends Node

@export var meteor_scene: PackedScene
@export var pool_size: int = 10

var pool: Array = []

func _ready():
	for i in range(pool_size):
		var meteor = meteor_scene.instantiate()
		meteor.visible = false
		pool.append(meteor)
		add_child(meteor)

func get_meteor() -> Node2D:
	for meteor in pool:
		if !meteor.visible:
			return meteor
	return null  # Optionally increase pool if needed

func spawn_meteor(position: Vector2):
	var meteor = get_meteor()
	if meteor:
		meteor.position = position
		meteor.visible = true
