class_name Player
extends CharacterBody2D

@export var speed = 6600

@onready var target = Vector2(position)

var in_the_air = false
var is_alive = true
var is_moving = false
signal movement_finished

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func take_off():
	if in_the_air:
		# Already in the air
		return Strings.NOTICE_PLAYER_ALREADY_IN_AIR

	in_the_air = true
	sprite.play("take_off")
	await sprite.animation_finished


func move_to(new_target: Vector2):

	Log.log("Moving from", position, "to", new_target)

	# Apply sprite animation + transformation
	var coord_diff = new_target.x - position.x
	if abs(coord_diff) < 1:
		sprite.play("idle")
	else:
		sprite.play("walk_horizontal")
		sprite.flip_h = coord_diff < -1

	is_moving = true
	target = new_target

	# Wait for _physics_process(delta) function to finish movement
	# Pass optional result
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
		movement_finished.emit(Strings.NOTICE_PLAYER_COLLIDED_WITH_OBSTACLE)

	# Finish player moving
	if is_moving:
		is_moving = false
		sprite.play("idle")
		movement_finished.emit()
