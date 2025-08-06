extends Node2D

@export var floor_speed = 200  # Speed at which floor scrolls
@export var ground_scene: PackedScene  # This should be flooring.tscn
@export var player_scene: PackedScene  # Drag your player.tscn here in the Inspector

var floor_tiles: Array = []
var last_tile_position = Vector2.ZERO

func _ready():
	last_tile_position = Vector2.ZERO
	spawn_floor_tile()
	spawn_floor_tile()  # Spawn a second tile to fill screen width
	spawn_player()

func _process(delta):
	# Scroll floor tiles to the left
	for tile in floor_tiles:
		tile.position.x -= floor_speed * delta

	# If the last tile has moved far enough left, spawn another
	if floor_tiles.size() > 0:
		var last_tile = floor_tiles[-1]
		var sprite = last_tile.get_node("Sprite2D")
		var tile_width = sprite.texture.get_width()
		if last_tile.position.x + tile_width <= get_viewport().size.x:
			spawn_floor_tile()

func spawn_floor_tile():
	if ground_scene != null:
		var new_tile = ground_scene.instantiate()

		if floor_tiles.is_empty():
			new_tile.position = Vector2(0, 400)  # Adjust Y to fit your level
		else:
			var last_tile = floor_tiles[-1]
			var tile_width = last_tile.get_node("Sprite2D").texture.get_width()
			new_tile.position = last_tile.position + Vector2(tile_width, 0)

		add_child(new_tile)
		floor_tiles.append(new_tile)
	else:
		print("Error: Flooring scene not assigned!")

func spawn_player():
	if player_scene != null and floor_tiles.size() > 0:
		var player = player_scene.instantiate()

		var flooring_tile = floor_tiles[0]
		var sprite = flooring_tile.get_node("Sprite2D")

		# Position player above the ground tile
		var player_y = flooring_tile.position.y - sprite.texture.get_height() + 20  # +20 offset (adjust if needed)
		player.position = Vector2(flooring_tile.position.x + 100, player_y)  # Offset X to start slightly forward

		add_child(player)
	else:
		print("Error: Player scene or flooring tiles not ready!")
