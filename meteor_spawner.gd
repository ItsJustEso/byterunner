extends Node2D

@export var spawn_y_range = Vector2(100, 400)

@export var initial_wait_time = 2.0        # Start spawn interval
@export var min_wait_time = 0.5            # Fastest spawn interval allowed
@export var difficulty_interval = 10.0     # Time between difficulty increases
@export var decrease_amount = 0.2          # How much to decrease each time

var time_elapsed = 0.0                     # Tracks time passed for difficulty scaling

func _ready():
	$SpawnTimer.wait_time = initial_wait_time
	$SpawnTimer.start()
	$SpawnTimer.timeout.connect(_on_SpawnTimer_timeout)

func _process(delta):
	time_elapsed += delta

	if time_elapsed >= difficulty_interval:
		time_elapsed = 0
		if $SpawnTimer.wait_time > min_wait_time:
			$SpawnTimer.wait_time = max($SpawnTimer.wait_time - decrease_amount, min_wait_time)
			print("Spawn rate increased. New wait_time: ", $SpawnTimer.wait_time)

func _on_SpawnTimer_timeout():
	var spawn_y = randf_range(spawn_y_range.x, spawn_y_range.y)
	var spawn_position = Vector2(900, spawn_y)

	# Access the pool (adjust path if your structure is different)
	var pool = get_node("/root/Main/MeteorPool")  # Make sure this path is correct
	pool.spawn_meteor(spawn_position)
