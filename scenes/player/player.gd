class_name Player
extends CharacterBody2D

@export var speed = 6600

@onready var target = Vector2(position)

var is_alive = true
var is_moving = false
signal movement_finished

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func move_to(new_target: Vector2):
	# Return if player is dead
	if not is_alive:
		return

	Log.log("Moving from", position, "to", new_target)

	is_moving = true

	# Apply sprite animation + transformation
	var coord_diff = new_target.x - position.x
	if abs(coord_diff) < 1:
		sprite.play("idle")
	else:
		sprite.play("walk_horizontal")
		sprite.flip_h = coord_diff < -1

	target = new_target

	# Wait for _physics_process(delta) function to finish movement
	# Return error message if passed
	return await movement_finished


func _physics_process(delta: float):
	# Return if player is dead
	if not is_alive:
		return

	# Calculate player velocity based on direction, speed, and delta value to keep time and scaling
	velocity = position.direction_to(target) * speed * delta

	# Move player until the target position is reached
	if position.distance_to(target) > 1:
		# Move and return if no collision detected
		if not move_and_slide():
			return

		# Collision with certain object detected
		is_alive = false
		is_moving = false
		sprite.play("death")
		movement_finished.emit("Гравець зіткнувся з перешкодою")

	# Finish player moving
	if is_moving:
		is_moving = false
		sprite.play("idle")
		movement_finished.emit()
