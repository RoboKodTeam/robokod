class_name Player
extends CharacterBody2D

@export var speed = 6600

@export var tile_size: int = 32
var tile_center = Vector2(int(tile_size / 2), tile_size / 2)

@onready var position_grid = coord_to_grid(position)
@onready var target = position

var is_active = true
var is_moving = false
signal movement_finished

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func up(s_steps: String = ""):
	var steps = IPZScriptUtils.string_to_int_or_default(s_steps, 1)
	var direction = Vector2(0, -steps)
	return await _move(direction)


func down(s_steps: String = ""):
	var steps = IPZScriptUtils.string_to_int_or_default(s_steps, 1)
	var direction = Vector2(0, steps)
	return await _move(direction)


func left(s_steps: String = ""):
	var steps = IPZScriptUtils.string_to_int_or_default(s_steps, 1)
	var direction = Vector2(-steps, 0)
	return await _move(direction)


func right(s_steps: String = ""):
	var steps = IPZScriptUtils.string_to_int_or_default(s_steps, 1)
	var direction = Vector2(steps, 0)
	return await _move(direction)


func _move(direction: Vector2):
	position_grid += direction

	target = grid_to_coord(position_grid)
	Log.log("Moving from", position, "to", target)

	is_moving = true
	sprite.play("walk_horizontal")
	sprite.flip_h = direction.x < 0

	return await movement_finished


func _physics_process(delta: float):
	# Return if player is dead
	if not is_active:
		return

	# Calculate player velocity based on direction, speed, and delta value to keep time and scaling
	velocity = position.direction_to(target) * speed * delta

	# Move player until the target position is reached
	if position.distance_to(target) > 1:
		# Move and return if no collision detected
		if not move_and_slide():
			return

		# Collision with certain object detected
		is_active = false
		is_moving = false
		sprite.play("death")
		movement_finished.emit("Гравець зіткнувся з перешкодою")

	# Finish player moving
	if is_moving:
		is_moving = false
		sprite.play("idle")
		movement_finished.emit()


func coord_to_grid(coord: Vector2):
	return (coord - tile_center) / tile_size


func grid_to_coord(grid: Vector2):
	return grid * tile_size + tile_center
