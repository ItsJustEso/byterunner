extends Area2D

@export var speed: float = 200.0
@export var lifespan: float = 10.0  # Set lifespan to 10 seconds

var time_alive: float = 0.0

func _ready():
	connect("body_entered", _on_body_entered)

func _process(delta):
	if visible:
		position.x -= speed * delta
		time_alive += delta
		
		# Despawn after 10 seconds or when the meteor goes off-screen
		if time_alive >= lifespan or position.x < -100:  # Off-screen cleanup
			visible = false
			set_deferred("monitoring", false)  # Disable collision

func _on_body_entered(body):
	if body.name == "Player":  # Adjust if your player is named differently
		if body.has_method("take_damage"):
			body.take_damage()
		visible = false
		set_deferred("monitoring", false)  # Disable collision on impact
