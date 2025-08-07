extends CharacterBody2D

@export var speed: float = 300.0
@export var fly_force: float = -600.0
@export var gravity: float = 800.0
@export var max_hp: int = 3
@export var knockback_force: Vector2 = Vector2(-300, -200)

var hp: int
var is_hurt: bool = false

func _ready():
	hp = max_hp

func _physics_process(delta):
	if not is_hurt:
		velocity.x = 0.0

		# Horizontal movement
		if Input.is_action_pressed("ui_right"):
			velocity.x += speed
		elif Input.is_action_pressed("ui_left"):
			velocity.x -= speed

		# Vertical flying when holding jump
		if Input.is_action_pressed("jump"):
			velocity.y = fly_force
		else:
			velocity.y += gravity * delta
	else:
		# Gravity still applies during knockback
		velocity.y += gravity * delta

	move_and_slide()

func take_damage():
	if is_hurt:
		return

	hp -= 1
	is_hurt = true
	flash_effect()

	# Apply knockback
	velocity = knockback_force

	if hp <= 0:
		die()
	else:
		await get_tree().create_timer(1.0).timeout
		is_hurt = false

func flash_effect():
	var sprite = get_node("Sprite2D")
	if sprite:
		sprite.modulate = Color(1, 0.4, 0.4)
		await get_tree().create_timer(0.2).timeout
		sprite.modulate = Color(1, 1, 1)

func die():
	print("Game Over")
	queue_free()
